//
//  DialogViewController.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 17/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import "DialogViewController.h"

@interface DialogViewController () {
}
@end

@implementation DialogViewController

NSInteger chatId;
RLMResults<MessageItem *> *messages;
NSArray<NSString *> *suggestions;
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Keyboard observers
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboard:)
                                                 name:UIKeyboardWillShowNotification object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboard:)
                                                 name:UIKeyboardWillHideNotification object:NULL];
    
    // Setup TableView
    UINib* cellNib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"cellId"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Setup CollectionView
    UINib* suggestNib = [UINib nibWithNibName:@"SuggestCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.suggestCollectionView registerNib:suggestNib forCellWithReuseIdentifier:@"cellId"];
    self.suggestCollectionView.delegate = self;
    self.suggestCollectionView.dataSource = self;
    
    // Fill Suggestion with default values
    suggestions = [[NSArray alloc] initWithObjects:@"Hello", @"What's up?", @"Good luck", nil];
}
    
/**
 Will add to screen and save new message in chat

 @param message - text of the message
 @param chatId - id of Character that involved in dialog
 @param isOutgoing - flag defining if message is sending to the Character
 */
-(void)addNewMessage: (NSString*) message withChatId: (NSInteger) chatId isOutgoing: (BOOL) isOutgoing {
    MessageItem *item = [[MessageItem alloc] initWithId:chatId message:message isOutgoing:isOutgoing];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:item];
        [realm commitWriteTransaction];
    }];
    NSIndexPath *index = [NSIndexPath indexPathForRow:messages.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[[NSArray alloc] initWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    if (isOutgoing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC/2), dispatch_get_main_queue(), ^{
            [self createResponse];
        });
    }
}
    
/**
 Creating new response message from Character
 */
-(void)createResponse {
    NSArray<NSString*> *messages = [[NSArray alloc] initWithObjects:
                            @"I am good how about you?",
                            @"Yeah, I am pretty tired of all the superpowers :[",
                            @"Do you need some help?",
                            @"OK, I am kinda busy. Will need to fight my enemy!", nil];
    NSInteger randomIndex = arc4random() % messages.count;
    NSString *response = [messages objectAtIndex:randomIndex];
    [self addNewMessage:response withChatId:chatId isOutgoing:NO];
}
    
/**
 Setter for character in dialog.
 Performs loading chat history from database

 @param character - item of class CharacterItem
 */
-(void)setCharacter: (CharacterItem*) character {
    self.title = character.name;
    chatId = character.uid;
    RLMResults<MessageItem *> *messagesList = [MessageItem objectsWhere:[NSString stringWithFormat:@"charId == %li", (long)character.uid]];
    
    // Create first message if there was no chat yet
    if (messagesList.count == 0) {
        [self addNewMessage:@"Hello" withChatId:character.uid isOutgoing:NO];
    }
    messages = [messagesList sortedResultsUsingKeyPath:@"date" ascending:YES];
}
    
- (void)viewDidLayoutSubviews {
    [self updateContentOffset:0];
    
    // Scroll to bottom of table view
    if (messages.count > 4) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:messages.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}
    
- (void)handleKeyboard: (NSNotification*) notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    short curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] shortValue];
    
    CGFloat bottomOffset = 0;
    if (notification.name == UIKeyboardWillShowNotification) {
        bottomOffset = kbSize.height - self.view.safeAreaInsets.bottom;
    }
    [self updateContentOffset:bottomOffset];
    self.textContainerBottomConstraint.constant = -bottomOffset;
    [UIView animateKeyframesWithDuration:duration delay:0 options:curve animations:^{
        [self.view layoutIfNeeded];
    } completion:NULL];
}
    
- (IBAction)sendButtonTapped:(id)sender {
    [self.view endEditing:YES];
    NSString *message = self.messageTextField.text;
    if (message != NULL && [message isEqual: @""]) { return; }
    [self addNewMessage:message withChatId:chatId isOutgoing:YES];
    self.messageTextField.text = NULL;
}
    
/**
 Updating tableview content insets

 @param bottomOffset - distance from bottom to desired content end
 */
- (void)updateContentOffset: (CGFloat) bottomOffset {
    CGFloat contentOffset = bottomOffset + self.textInputContainer.frame.size.height + self.suggestCollectionView.frame.size.height;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, contentOffset, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}
    
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:NULL];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:NULL];
}
    
#pragma mark - Table view data source
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    MessageItem *item = [messages objectAtIndex:indexPath.row];
    [cell setMessage:item.message isOutgoing:item.isOutgoing];
    
    return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - Collection view data source
    
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return suggestions.count;
}
    
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SuggestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.text = [suggestions objectAtIndex:indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.frame.size.width / 3;
    
    return CGSizeMake(width, 40);
}
    
#pragma mark - Collection view delegate
    
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self addNewMessage:[suggestions objectAtIndex:indexPath.row] withChatId:chatId isOutgoing:YES];
}
    
@end

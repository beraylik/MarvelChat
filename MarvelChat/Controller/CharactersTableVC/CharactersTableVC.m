//
//  CharactersTableVC.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 17/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import "CharactersTableVC.h"

@interface CharactersTableVC ()
@end

@implementation CharactersTableVC

NSInteger const rowHeigth = 120;
int totalItems = 0;
Boolean isLoadingNewData = NO;
NSMutableArray<CharacterItem *> *charactersData;
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Characters";
    charactersData = [[NSMutableArray alloc] init];
    
    // Register table cell
    UINib* cellNib = [UINib nibWithNibName:@"CharacterTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"cellId"];
    
    // Load data
    [self loadDataWithLimit: 30 andOffset: 0];
}
    
#pragma mark - Data loading
    
/**
 Loading Characters from API with params

 @param limit - number of items requested
 @param offset - should load items from offset
 */
- (void)loadDataWithLimit:(NSInteger) limit andOffset: (NSInteger) offset {
    [CharactersProvider loadDataWithLimit:limit andOffset:offset completion:^(NSArray<CharacterItem *> *response, NSInteger total) {
        isLoadingNewData = NO;
        totalItems = (int) total;
        [charactersData addObjectsFromArray:response];
        [self.tableView reloadData];
    }];
}
    

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return charactersData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    CharacterItem *item = charactersData[indexPath.row];
    [cell fillName:item.name andimageUrl:item.imageUrl];
    
    return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeigth;
}
    
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DialogViewController *detailViewController = [[DialogViewController alloc] initWithNibName:@"DialogViewController" bundle:nil];
    [detailViewController setCharacter:[charactersData objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Scroll view delegate
    
/**
 Will load new rows when there are less than 25 rows left before the end

 @param scrollView holding table view content
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoadingNewData || charactersData.count >= totalItems) { return; }
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat leftToBottom = scrollView.contentSize.height - rowHeigth*25;
    if (actualPosition >= leftToBottom) {
        NSInteger offset = charactersData.count;
        isLoadingNewData = true;
        [self loadDataWithLimit:50 andOffset:offset];
    }
}
    
@end

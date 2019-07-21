//
//  DialogViewController.h
//  MarvelChat
//
//  Created by Генрих Берайлик on 17/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "../../Model/MessageItem.h"
#import "../../Model/CharacterItem.h"
#import "../../View/Cells/MessageCell/MessageTableViewCell.h"
#import "../../View/Cells/SuggestCell/SuggestCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DialogViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (weak, nonatomic) IBOutlet UITextField *messageTextField;
    @property (weak, nonatomic) IBOutlet UIView *textInputContainer;
    @property (weak, nonatomic) IBOutlet UICollectionView *suggestCollectionView;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *textContainerBottomConstraint;
    
- (IBAction)sendButtonTapped:(id)sender;
-(void)setCharacter: (CharacterItem*) character;
    
@end

NS_ASSUME_NONNULL_END

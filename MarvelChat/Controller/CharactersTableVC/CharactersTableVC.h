//
//  CharactersTableVC.h
//  MarvelChat
//
//  Created by Генрих Берайлик on 17/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

#import "../../View/Cells/CharacterCell/CharacterTableViewCell.h"
#import "../../Service/CharactersProvider.h"
#import "../../Model/CharacterItem.h"
#import "../DialogVC/DialogViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CharactersTableVC : UITableViewController
@property (nonatomic) NSMutableArray *marvelCharacters;
@end

NS_ASSUME_NONNULL_END

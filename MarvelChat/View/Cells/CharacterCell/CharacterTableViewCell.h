//
//  CharacterTableViewCell.h
//  MarvelChat
//
//  Created by Генрих Берайлик on 17/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CharacterTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIImageView *characterImageView;
    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    
    @property (assign) NSString *imageUrl;
    
    -(void) fillName: (NSString *)name andimageUrl: (NSString *) imageUrl;
    
@end

NS_ASSUME_NONNULL_END

//
//  MessageTableViewCell.h
//  MarvelChat
//
//  Created by Генрих Берайлик on 17/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../../Model/MessageItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIView *bubbleView;
    @property (strong, nonatomic) IBOutlet UILabel *messageLabel;
    @property (strong, nonatomic) IBOutlet NSLayoutConstraint *bubbleLeadingConstraint;
    @property (strong, nonatomic) IBOutlet NSLayoutConstraint *bubbleTrailingConstraint;
    @property (strong, nonatomic) IBOutlet NSLayoutConstraint *bubbleWidthContraint;
    
    - (void)setMessage:(NSString *) message isOutgoing: (Boolean) isOutgoing;
    
@end

NS_ASSUME_NONNULL_END

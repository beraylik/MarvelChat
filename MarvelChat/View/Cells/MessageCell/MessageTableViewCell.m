//
//  MessageTableViewCell.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 17/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bubbleView.layer.cornerRadius = 12;
    self.bubbleView.backgroundColor = UIColor.whiteColor;
    self.messageLabel.textColor = UIColor.whiteColor;
}
    
- (void)prepareForReuse {
    [super prepareForReuse];
    self.bubbleView.backgroundColor = UIColor.whiteColor;
    self.messageLabel.text = NULL;
    self.bubbleWidthContraint.constant = 0;
    
    NSArray<NSLayoutConstraint *> *willDeactivate = [[NSArray alloc] initWithObjects:self.bubbleLeadingConstraint, nil];
    [NSLayoutConstraint deactivateConstraints:willDeactivate];
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setMessage:(NSString *) message isOutgoing: (Boolean) isOutgoing {
    NSMutableArray<NSLayoutConstraint *> *willActivate = [[NSMutableArray alloc] init];
    NSMutableArray<NSLayoutConstraint *> *willDeactivate = [[NSMutableArray alloc] init];
    
    if (isOutgoing) {
        [willActivate addObject:self.bubbleTrailingConstraint];
        [willDeactivate addObject:self.bubbleLeadingConstraint];
        self.bubbleView.backgroundColor = UIColor.grayColor;
    } else {
        [willActivate addObject:self.bubbleLeadingConstraint];
        [willDeactivate addObject:self.bubbleTrailingConstraint];
        self.bubbleView.backgroundColor = UIColor.blueColor;
    }
    self.messageLabel.text = message;
    
    // Update constraints
    self.bubbleWidthContraint.constant = self.frame.size.width * 0.6;
    [NSLayoutConstraint deactivateConstraints:willDeactivate];
    [NSLayoutConstraint activateConstraints:willActivate];
}
    
@end

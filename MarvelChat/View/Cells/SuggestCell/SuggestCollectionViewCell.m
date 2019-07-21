//
//  SuggestCollectionViewCell.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 21/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import "SuggestCollectionViewCell.h"

@implementation SuggestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.textLabel.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.textLabel.layer.shadowRadius = 3.0f;
    self.textLabel.layer.shadowOpacity = 1.0f;
}

@end

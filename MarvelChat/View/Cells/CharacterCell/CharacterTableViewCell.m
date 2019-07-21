//
//  CharacterTableViewCell.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 17/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import "CharacterTableViewCell.h"
#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>

@implementation CharacterTableViewCell
    
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupViews];
}
    
- (void)setupViews {
    _characterImageView.layer.cornerRadius = 16;
    _characterImageView.contentMode = UIViewContentModeScaleAspectFill;
}
    
- (void)prepareForReuse {
    [super prepareForReuse];
    _nameLabel.text = NULL;
    _characterImageView.image = NULL;
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)fillName:(NSString *)name andimageUrl:(NSString *)imageUrl {
    _nameLabel.text = name;
    [_characterImageView setImage:[UIImage imageNamed:@"placeholder"]];
    NSURL *url = [NSURL URLWithString:imageUrl];
    [_characterImageView setImageWithURL:url];
}
    
@end

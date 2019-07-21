//
//  NSObject+CharacterItem.h
//  MarvelChat
//
//  Created by Генрих Берайлик on 21/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CharacterItem : NSObject
    
    @property NSInteger uid;
    @property NSString *name;
    @property NSString *imageUrl;
    
    - (instancetype) initWithDictionary: (NSDictionary*) dictionary;
    
@end

NS_ASSUME_NONNULL_END

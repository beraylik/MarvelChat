//
//  NSObject+CharacterItem.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 21/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import "CharacterItem.h"

@implementation CharacterItem
   
    - (instancetype)initWithDictionary:(NSDictionary *)dictionary {
        self = [super init];
        if (self) {
            self.uid = (NSInteger) [dictionary valueForKey:@"id"];
            self.name = [dictionary valueForKey:@"name"];
            
            NSArray *thumbnail = [dictionary valueForKey:@"thumbnail"];
            [thumbnail valueForKey:@"path"];
            NSString *imageUrl = [[NSString alloc] initWithFormat:@"%@.%@",
                                  [thumbnail valueForKey:@"path"],
                                  [thumbnail valueForKey:@"extension"]];
            self.imageUrl = imageUrl;
        }
        return self;
    }
    
@end

//
//  MessageItem.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 21/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import "MessageItem.h"

@implementation MessageItem

    - (instancetype)initWithId: (NSInteger) charId message: (NSString *) message isOutgoing: (BOOL) isOutgoing
    {
        self = [super init];
        if (self) {
            self.charId = charId;
            self.date = [[NSDate alloc] init];
            self.isOutgoing = isOutgoing;
            self.message = message;
        }
        return self;
    }
    
@end

//
//  MessageItem.h
//  MarvelChat
//
//  Created by Генрих Берайлик on 21/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageItem : RLMObject

    @property NSInteger charId;
    @property NSString *message;
    @property NSDate *date;
    @property BOOL isOutgoing;
    
- (instancetype)initWithId: (NSInteger) charId message: (NSString*) message isOutgoing: (BOOL) isOutgoing;
    
@end

NS_ASSUME_NONNULL_END

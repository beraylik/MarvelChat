//
//  CharacterProvider.h
//  MarvelChat
//
//  Created by Генрих Берайлик on 21/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "../Model/CharacterItem.h"

typedef void (^CharacterCompletionHandler)(NSArray<CharacterItem*> *response, NSInteger total);

@interface CharactersProvider : NSObject

+ (void)loadDataWithLimit:(NSInteger) limit andOffset: (NSInteger) offset completion: (CharacterCompletionHandler) completion;
    
@end

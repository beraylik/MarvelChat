//
//  CharactersProvider.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 21/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

/*
 P.S.
    Почему-то Realm не хочет сохранять данные при перезапуске приложения.
    В коде вроде все ок, но все равно не заработало у меня.
    Много времени потратил что бы разобраться но пока не успел пофиксить эту багу.
    Может просто у меня симулятор дает сохранять.
 */

#import <Foundation/Foundation.h>
#import "CharactersProvider.h"

@implementation CharactersProvider

+ (void)loadDataWithLimit:(NSInteger) limit andOffset: (NSInteger) offset completion: (CharacterCompletionHandler) completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *url = [NSString stringWithFormat:  @"https://gateway.marvel.com/v1/public/characters?apikey=f8358637bff26d83dbe6814a24f845f1&hash=594a8b2657b91e9c3f3e05bc3cf2ade4&ts=1&limit=%ld&offset=%ld", (long)limit, (long)offset];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSArray *dataObject = [responseObject valueForKey:@"data"];
            int totalItems = (int) [dataObject valueForKey:@"total"];
            NSMutableArray<CharacterItem *> *result = [[NSMutableArray alloc] init];
            NSArray *list =[dataObject valueForKey:@"results"];
            for (NSDictionary* charDict in list) {
                CharacterItem *charItem = [[CharacterItem alloc] initWithDictionary:charDict];
                [result addObject:charItem];
            }
            completion(result, totalItems);
        }
    }];
    [dataTask resume];
}

@end

//
//  AppDelegate.m
//  MarvelChat
//
//  Created by Генрих Берайлик on 16/07/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

#import "AppDelegate.h"
#import "Controller/CharactersTableVC/CharactersTableVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
    
    CharactersTableVC* characterVC = [[CharactersTableVC alloc] init];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:characterVC];
    navigation.navigationBar.prefersLargeTitles = YES;
    
    _window.rootViewController = navigation;
    [_window makeKeyAndVisible];
    
    return YES;
}

@end

//
//  AppDelegate.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import <BaiduMapAPI/BMapKit.h>

@interface AppDelegate ()<BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
    //ssss
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //pnAYzADGMp5cfO6ZtVnaYEOn
    // Override point for customization after application launch.
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"pnAYzADGMp5cfO6ZtVnaYEOn" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor =[UIColor whiteColor];
    ViewController *VC = [[ViewController alloc]init];
    LoginViewController *loginVC = [[LoginViewController alloc]init];

    BOOL A = NO;
    if (A) {
        self.window.rootViewController = loginVC;
    }
    else
        self.window.rootViewController = VC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

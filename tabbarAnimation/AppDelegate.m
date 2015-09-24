//
//  AppDelegate.m
//  tabbarAnimation
//
//  Created by chuck on 15-7-11.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import "AppDelegate.h"
#import "baseTabBarViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController * VC1 = [[ViewController alloc] init];
    VC1.title = @"首页";
    VC1.view.backgroundColor = [UIColor whiteColor];
    ViewController * VC2 = [[ViewController alloc] init];
    VC2.title = @"收藏";
    VC2.view.backgroundColor = [UIColor greenColor];
    ViewController * VC3 = [[ViewController alloc] init];
    VC3.title = @"添加";
    VC3.view.backgroundColor = [UIColor cyanColor];
    ViewController * VC4 = [[ViewController alloc] init];
    VC4.title = @"个人";
    VC4.view.backgroundColor = [UIColor yellowColor];
    
    NSArray * imageNames = @[@"icon_tabbar_merchant_normal",@"icon_tabbar_nearby_normal",@"mine_tabbar_mine_normal",@"tabbar_home_normal"];
    NSArray * selectedImageNames = @[@"icon_tabbar_merchant_selected",@"icon_tabbar_nearby_selected",@"mine_tabbar_mine_selected",@"tabbar_home_selected"];
    
    baseTabBarViewController * baseTabVC = [[baseTabBarViewController alloc] init];
    [baseTabVC setupChildViewControllerWithArray:@[VC1,VC2,VC3,VC4] imageNames:imageNames selectedImageNames:selectedImageNames];
    self.window.rootViewController = baseTabVC;
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

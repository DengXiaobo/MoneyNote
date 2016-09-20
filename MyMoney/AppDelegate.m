//
//  AppDelegate.m
//  MyMoney
//
//  Created by Dengxiaobo on 16/6/16.
//  Copyright © 2016年 Dengxiaobo. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "DDMenuController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSLog(@"%@",NSHomeDirectory());
    
    // 移动数据库到沙盒
    [self moveDB2Sandbox];
    
    // 中间的主控制器
    MainViewController *mainViewController = [[MainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [mainViewController release];
    
    // 左边的控制器
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    
    // 配置DDMenuController
    DDMenuController *menuController = [[DDMenuController alloc] initWithRootViewController:nav];
    menuController.leftViewController = leftViewController;
    [nav release];
    [leftViewController release];
    
    // 作为单例类的属性
    MoneySingleton *singleton = [MoneySingleton sharedMoneySingleton];
    singleton.menuController = menuController;
    [menuController release];
    
    self.window.rootViewController = singleton.menuController;
    
    return YES;
}

- (void)moveDB2Sandbox
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"money" ofType:@"sqlite"];

    NSString *toPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/money.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:toPath])
    {
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:toPath error:nil];
    }
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

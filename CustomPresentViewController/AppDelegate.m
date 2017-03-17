//
//  AppDelegate.m
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/14.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import "AppDelegate.h"
#import "loginViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:[[loginViewController alloc]init]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (LeftSlideViewController *)LeftSlideVC{
    if (!_LeftSlideVC) {
        //主页面
        UITabBarController * mainTabBarController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"basrTabbar"];
        //左侧页面
        LeftController *leftVC=[[LeftController alloc]init];
        leftVC.view.frame=CGRectMake(0, 0, SCREENWIDTH-100, SCREENHEIGHT);
        //侧滑控制器
        _LeftSlideVC= [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:mainTabBarController];
    }
    return _LeftSlideVC;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

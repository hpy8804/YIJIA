//
//  AppDelegate.m
//  YIJIa
//
//  Created by sven on 3/16/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "AppDelegate.h"
#import "ComMacros.h"
#import "MainViewController.h"
#import "HistoryViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self customViewAppearance];
    [self customTabbarController];

    [self.window makeKeyAndVisible];
    [self showLoginView];
    
    return YES;
}

- (void)showLoginView
{
    LoginViewController *vcLogin = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.window.rootViewController = vcLogin;
}

- (void)customViewAppearance
{
    //导航栏背景
    UINavigationBar *naviBar = [UINavigationBar appearance];
    [naviBar setTintColor:[UIColor whiteColor]];
    
    //导航栏文字
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    [barAttrs setObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [naviBar setTitleTextAttributes:barAttrs];
    
    //底部栏颜色
    UITabBar *tabBarItem = [UITabBar appearance];
    tabBarItem.backgroundImage = PNGIMAGE(@"一级菜单底栏");
    tabBarItem.tintColor = [UIColor whiteColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor grayColor], UITextAttributeTextColor,
                                                       nil,nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor redColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil,nil] forState:UIControlStateSelected];
    
    
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)customTabbarController
{
    MainViewController *vcMain = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *vcNavMain = [[UINavigationController alloc] initWithRootViewController:vcMain];
    vcNavMain.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:PNGIMAGE(@"首页_灰色") tag:0];
    [vcNavMain.tabBarItem setFinishedSelectedImage:PNGIMAGE(@"首页_红色") withFinishedUnselectedImage:PNGIMAGE(@"首页_灰色")];
    
    //无线
    HistoryViewController *vcHistory = [[HistoryViewController alloc] init];
    UINavigationController *vcNavHistory = [[UINavigationController alloc] initWithRootViewController:vcHistory];
    vcNavHistory.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"历史记录" image:PNGIMAGE(@"历史_灰色") tag:1];
    [vcNavHistory.tabBarItem setFinishedSelectedImage:PNGIMAGE(@"历史_红色") withFinishedUnselectedImage:PNGIMAGE(@"历史_灰色")];
    
    //设置
    SettingViewController *vcSettingView = [[SettingViewController alloc] init];
    UINavigationController *vcNavSettingView = [[UINavigationController alloc] initWithRootViewController:vcSettingView];
    vcNavSettingView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:PNGIMAGE(@"设置_灰色") tag:1];
    [vcNavSettingView.tabBarItem setFinishedSelectedImage:PNGIMAGE(@"设置_红色") withFinishedUnselectedImage:PNGIMAGE(@"设置_灰色")];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:vcNavMain, vcNavHistory, vcNavSettingView, nil];
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

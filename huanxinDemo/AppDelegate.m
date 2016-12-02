//
//  AppDelegate.m
//  huanxinDemo
//
//  Created by jefactoria on 16/9/23.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "ApplyViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    TabBarViewController * tabbar = [[TabBarViewController alloc] initWithNibName:@"TabBarViewController" bundle:nil];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:tabbar];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.barTintColor =  [UIColor colorWithRed:0/255.0 green:199/255.0 blue:205/255.0 alpha:1];
//    nav.navigationBarHidden = YES;
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    
    
  
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:@"1103160922178815#etrip"
                                         apnsCertName:@""
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    //注册一个监听对象到监听列表中,监听环信SDK事件
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    EMError *error = [[EMClient sharedClient] loginWithUsername:@"hanwei123" password:@"123456"];
    if (!error) {
        NSLog(@"登录成功");
      
    
    }
    
    
    return YES;
}

//监听好友请求回调
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{
    if (!aUsername) {
        return;
    }
    
    if (!aMessage) {
        aMessage = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), aUsername];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":aUsername, @"username":aUsername, @"applyMessage":aMessage, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
    [[ApplyViewController shareController] addNewApply:dic];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
     [[EMClient sharedClient] applicationDidEnterBackground:application];
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
     [[EMClient sharedClient] applicationWillEnterForeground:application];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

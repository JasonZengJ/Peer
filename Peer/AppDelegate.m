//
//  AppDelegate.m
//  Peer
//
//  Created by jason on 8/15/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "AppDelegate.h"
#import "AppService.h"

#pragma mark - -- Vendor
#import <SMS_SDK/SMS_SDK.h>
#import "MobClick.h"


#warning TEST
#import "TestViewController.h"
#import "ApplicationDirectoryService.h"
#import "SendPhotoMomentViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    if (![AppService appLaunched]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [AppService initAppService];
        });
    } else {
        [AppService clearCachedData];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [AppService monitorNetwork];
        });
    }
    
    [AppService registerRemoteNotification];
// 第三方手机验证码工具初始化
//    [SMS_SDK registerApp:@"a72297a4628e" withSecret:@"52cf6cd4ef00aec3e52f8e7af55bbaa1"];
    
// 友盟统计工具初始化
    [MobClick startWithAppkey:@"561f4307e0f55a8ae2002752" reportPolicy:BATCH   channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    self.homeViewController = [[PeerHomeViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:ScreenBounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    DLog(@"resingActive %ld",(long)[UIApplication sharedApplication].applicationState);
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    
    DLog(@"enter background %ld",(long)[UIApplication sharedApplication].applicationState);
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    DLog(@"enter foreground %ld",(long)[UIApplication sharedApplication].applicationState);
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    DLog(@"become active %ld",(long)[UIApplication sharedApplication].applicationState);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DLog(@"terminate %ld",(long)[UIApplication sharedApplication].applicationState);
}


#pragma mark - -- Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[[[deviceToken description]
                         stringByReplacingOccurrencesOfString: @"<" withString: @""]
                        stringByReplacingOccurrencesOfString: @">" withString: @""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    
    DLog(@"%@", token);
    [AppService registerRemoteToken:token];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    DLog(@"register error :%@",error);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0) {
    
    NSLog(@"LocalNotification 8_0");
    completionHandler();
}

//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
//{
//    NSLog(@"RemoteNotification 8_0");
//    //handle the actions
//    if ([identifier isEqualToString:@"declineAction"]){
//    }
//    else if ([identifier isEqualToString:@"answerAction"]){
//    }
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"RemoteNotification 3_0");
    NSLog(@"%@",userInfo);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}




@end

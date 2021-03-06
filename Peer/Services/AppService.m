//
//  AppService.m
//  Peer
//
//  Created by jason on 9/15/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//
#import "AppService.h"
#import "OpenUDID.h"
#import "PeerNetworkManager.h"
#import "AppDelegate.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

#define RegisterDevicePath  @"v1/sys/register-device"
#define RegisterRemoteToken @"v1/sys/register-remote-token"


@implementation AppService

//+ (id)shareInstance {
//    static dispatch_once_t onceToken;
//    static AppService *appService;
//    dispatch_once(&onceToken, ^{
//        appService = [[AppService alloc] init];
//    });
//    return appService;
//}

+ (void)initAppService {
    

    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version    = infoDictionary[@"CFBundleShortVersionString"];
    NSString *sysName    = [[UIDevice currentDevice] systemName];
    NSString *sysVer     = [[UIDevice currentDevice] systemVersion];
    NSDictionary *appConfiguration = @{
                                       @"udid":[OpenUDID value],
                                       @"appVer":version,
                                       @"sysName":sysName,
                                       @"sysVer":sysVer,
                                       @"deviceType":[AppService deviceType]
                                       };
    
    [[NSUserDefaults standardUserDefaults] setObject:appConfiguration forKey:@"app"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [AppService registerDevice];
    [self monitorNetwork];

    
}

+ (void)clearCachedData {
    
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    if (user && ![user objectForKey:@"userId"]) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

+ (void)monitorNetwork {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        DLog(@"network status changed :%ld",(long)status);
        [[NSUserDefaults standardUserDefaults] setObject:@(status) forKey:@"NetworkStatus"];
        [[NSNotificationCenter defaultCenter]  postNotificationName:kNetworkChangedNotification object:@(status)];
        if (![AppService token] && status > 0 && ![AppService isRegisteringDevice] ) {
            [AppService registerDevice];
        }
    }];
}


+ (void)registerDevice {
    
    NSDictionary *appConfiguration = [[NSUserDefaults standardUserDefaults] objectForKey:@"app"];
    if (appConfiguration) {
       [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"isRegisteringDevice"];
       [[PeerNetworkManager shareInstance] securePostWithParams:appConfiguration apiPath:RegisterDevicePath callBackBlock:^(id responseObject) {
           if (responseObject && [[responseObject objectForKey:@"code"] integerValue] == 0) {
               NSMutableDictionary *appConfig = [NSMutableDictionary dictionaryWithDictionary:appConfiguration];
               [appConfig setObject:responseObject[@"data"][@"token"] forKey:@"token"];
               [appConfig setObject:responseObject[@"data"][@"id"]    forKey:@"deviceId"];
               [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"access_key"] forKey:@"AccessKey"];
               [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"secret_key"] forKey:@"SecretKey"];
               [[NSUserDefaults standardUserDefaults] setObject:appConfig forKey:@"app"];
               [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"isRegisteringDevice"];
               [[NSUserDefaults standardUserDefaults] synchronize];
               
               AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
               [appDelegate.homeViewController loadData];
               
               [self setAppLaunched];
           }
           
       }];
    }
    
}


+ (void)registerRemoteNotification
{
     [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
     [[UIApplication sharedApplication] registerForRemoteNotifications];
}

+ (void)registerRemoteToken:(NSString *)remoteToken {
    
    [[NSUserDefaults standardUserDefaults] setObject:remoteToken forKey:@"remoteToken"];
    [[PeerNetworkManager shareInstance] securePostWithParams:@{@"remoteToken":remoteToken}
                                                     apiPath:RegisterRemoteToken
                                               callBackBlock:^(id responseObject) {
                                               }];
    
    
}

+ (BOOL)isRegisteringDevice {
   return [[[NSUserDefaults standardUserDefaults] objectForKey:@"isRegisteringDevice"] integerValue];
}

+ (AFNetworkReachabilityStatus)networkState {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"networkStatus"] integerValue];
}

+ (NSNumber *)deviceId {
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"deviceId"];
}

+ (NSString *)token {
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"token"];
}


+ (NSString *)appVersion {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"appVer"];
}

+ (NSString *)systemVersion {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"sysVer"];
}

+ (NSString *)udid {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"udid"];
}



+ (NSString *)appName {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"appName"];
}

+ (NSString *)remoteToken {
    return [[NSUserDefaults standardUserDefaults]  objectForKey:@"remoteToken"];
}


+ (void)setAppLaunched {
    
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"appLaunched"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (BOOL)appLaunched {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"appLaunched"];
}

+ (AFNetworkReachabilityStatus)networkStatus {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"NetworkStatus"] integerValue];
}

+ (NSString *)deviceType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return @"";
}


@end









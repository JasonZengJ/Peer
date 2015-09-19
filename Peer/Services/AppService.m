//
//  AppService.m
//  Peer
//
//  Created by jason on 9/15/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//
#import "AppService.h"
#import "OpenUDID.h"
#import <UIKit/UIKit.h>

@implementation AppService

+ (id)shareInstance {
    static dispatch_once_t onceToken;
    static AppService *appService;
    dispatch_once(&onceToken, ^{
        appService = [[AppService alloc] init];
    });
    return appService;
}

- (void)initAppService {
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version    = infoDictionary[@"CFBundleShortVersionString"];
    NSString *build      = infoDictionary[(NSString*)kCFBundleVersionKey];
    NSString *bundleName = infoDictionary[(NSString *)kCFBundleNameKey];
    NSString *sysVer     = [[UIDevice currentDevice] systemVersion];
    
    NSDictionary *appConfiguration = @{
                                       @"udid":[OpenUDID value],
                                       @"appName":bundleName,
                                       @"appVer":version,
                                       @"build":build,
                                       @"sysVer":sysVer,
                                       @"deviceType":@""
                                       };
    
    [[NSUserDefaults standardUserDefaults] setObject:appConfiguration forKey:@"app"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

- (void)registerDevice {
    
    
    
    
}


- (NSString *)appVersion {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"appVer"];
}

- (NSString *)udid {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"udid"];
}

- (NSString *)appName {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"appName"];
}

- (NSString *)remoteToken {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"app"] objectForKey:@"remoteToken"];
}

@end









//
//  AppService.h
//  Peer
//
//  Created by jason on 9/15/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppService : NSObject


+ (void)initAppService;

+ (NSString *)token;

+ (NSString *)deviceType;

+ (NSString *)appVersion;

+ (NSString *)udid;

+ (NSString *)appName;

+ (NSString *)remoteToken;

@end

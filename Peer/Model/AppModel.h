//
//  AppModel.h
//  Peer
//
//  Created by jason on 9/17/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface AppModel : BaseModel

@property(nonatomic)NSString *deviceId;
@property(nonatomic)NSString *udid;
@property(nonatomic)NSString *appVer;
@property(nonatomic)NSString<Optional> *build;
@property(nonatomic)NSString *sysVer;
@property(nonatomic)NSString *sysName;
@property(nonatomic)NSString *deviceType;
@property(nonatomic)NSString<Optional> *remoteToken;

@end

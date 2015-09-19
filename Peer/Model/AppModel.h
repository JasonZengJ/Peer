//
//  AppModel.h
//  Peer
//
//  Created by jason on 9/17/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface AppModel : JSONModel

@property(nonatomic)NSString *uuid;
@property(nonatomic)NSString *appName;
@property(nonatomic)NSString *appVer;
@property(nonatomic)NSString *build;
@property(nonatomic)NSString *sysVer;

@end

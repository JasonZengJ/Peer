//
//  UserModel.h
//  Peer
//
//  Created by jason on 9/18/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface UserModel : JSONModel

@property(nonatomic)NSNumber *userId;
@property(nonatomic)NSString *nickname;
@property(nonatomic)NSString *phone;
@property(nonatomic)NSString *password;
@property(nonatomic)NSNumber *sex;
@property(nonatomic)NSString<Optional> *city;
@property(nonatomic)NSString<Optional> *avatar;
@property(nonatomic)NSNumber *deviceId;

@end

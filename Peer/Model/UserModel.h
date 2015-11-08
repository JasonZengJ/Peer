//
//  UserModel.h
//  Peer
//
//  Created by jason on 9/18/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel

@property(nonatomic)NSNumber *userId;
@property(nonatomic)NSString *nickname;
@property(nonatomic)NSString *phone;
@property(nonatomic)NSString *password;
@property(nonatomic)NSNumber *sex;
@property(nonatomic)NSNumber *age;
@property(nonatomic)NSString<Optional> *city;
@property(nonatomic)NSString<Optional> *area;
@property(nonatomic)NSString<Optional> *avatar;
@property(nonatomic)NSString<Optional> *userDescription;
@property(nonatomic)NSNumber *deviceId;

@end

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

@property(nonatomic)NSNumber<Optional> *userId;
@property(nonatomic)NSString<Optional> *nickname;
@property(nonatomic)NSString *phone;
@property(nonatomic)NSString *password;
@property(nonatomic)NSNumber<Optional> *sex;
@property(nonatomic)NSNumber<Optional> *age;
@property(nonatomic)NSString<Optional> *city;
@property(nonatomic)NSString<Optional> *area;
@property(nonatomic)NSString<Optional> *avatar;
@property(nonatomic)NSString<Optional> *userDescription;
@property(nonatomic)NSNumber<Optional> *deviceId;

@end

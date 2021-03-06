//
//  UserModel.m
//  Peer
//
//  Created by jason on 9/18/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    
    self = [super init];
    if (self) {
        self.userId   = dict[@"id"];
        self.nickname = dict[@"nickname"];
        self.phone    = dict[@"phone"];
        self.password = dict[@"password"];
        self.age      = dict[@"age"];
        self.sex      = dict[@"sex"];
        self.city     = dict[@"city"] ? dict[@"city"] : nil;
        self.area     = dict[@"area"] ? dict[@"area"] : nil;
        self.avatar   = dict[@"avatar"] ? dict[@"avatar"] : nil;
        self.deviceId = dict[@"device_id"];
        self.userDescription = dict[@"description"] ? dict[@"description"] : nil;
    }
    
    return self;
}

@end

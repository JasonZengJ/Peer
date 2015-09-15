//
//  LoginService.m
//  Peer
//
//  Created by jason on 9/14/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "LoginService.h"
#import "PeerNetworkManager.h"

#define LoginApiPath @"user/login"

@interface LoginService ()



@end

@implementation LoginService


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return  self;
}

- (void)loginWithParams:(NSDictionary *)params  {
    [[PeerNetworkManager shareInstance] postWithParams:params apiPath:LoginApiPath target:self callBack:@selector(loginCompleted:)];
}

- (void)loginCompleted:(NSDictionary *)dataDic {
    
    
    if (dataDic[@"errCode"]) {
        
    } else {
        [self persistUserData:dataDic];
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessWithData:)]) {
            [self.delegate loginSuccessWithData:dataDic];
        }
    }
    
}

- (void)persistUserData:(NSDictionary *)userData {
    
    //TODO: 暂时存在NSUserDefaults里面；
    [[NSUserDefaults standardUserDefaults] setValue:userData forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (NSDictionary *)currentUserData {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
}


@end











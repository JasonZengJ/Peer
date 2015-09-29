//
//  UserService.m
//  Peer
//
//  Created by jason on 9/17/15.
//  Copyright (c) 2015 peer. All rights reserved.
//

#import "UserService.h"
#import "PeerNetworkManager.h"

#define UpdateUserInfoPath @"v1/user/update-user-info"

@implementation UserService


- (void)updateUserInfo:(NSDictionary *)userInfo callBackBlock:(void(^)(NSDictionary *responseObject))callBackBlock {
    
    [[PeerNetworkManager shareInstance] securePostWithParams:userInfo apiPath:UpdateUserInfoPath callBackBlock:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
            
        } else {
            
        }
        
    }];
    
}

@end

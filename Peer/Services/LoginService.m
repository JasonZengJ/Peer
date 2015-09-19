//
//  LoginService.m
//  Peer
//
//  Created by jason on 9/14/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "LoginService.h"
#import "PeerNetworkManager.h"
#import "UserModel.h"

#define LoginApiPath @"user/login"
#define RegisterApiPath @"user/register"

@interface LoginService ()



@end

@implementation LoginService


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return  self;
}

- (void)loginWithUserModel:(UserModel *)userModel {
    
    NSDictionary *params = @{@"phone":userModel.phone,@"password":userModel.password};
    [[PeerNetworkManager shareInstance] securePostWithParams:params apiPath:LoginApiPath target:self callBack:@selector(loginCompleted:)];
    
}

- (void)loginCompleted:(NSDictionary *)dataDic {
    
    
    DLog(@"%@",dataDic);
    
    NSDictionary *error = nil;
    if ([dataDic[@"code"] integerValue] == 0) {
        [self persistUserData:dataDic[@"data"]];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginCompleteWithError:)]) {
        [self.delegate loginCompleteWithError:error];
    }
    
}

- (void)registerWithUserModel:(UserModel *)userModel {
    
    NSDictionary *params = @{@"phone":userModel.phone,@"password":userModel.password};
    [[PeerNetworkManager shareInstance] securePostWithParams:params apiPath:RegisterApiPath target:self callBack:@selector(registerCompleted:)];
    
}

- (void)registerCompleted:(NSDictionary *)dataDic {
    
    NSDictionary *error = nil;
    if (dataDic[@"errCode"] != 0) {
        error = dataDic;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(registerCompleteWithError:)]) {
        [self.delegate registerCompleteWithError:error];
    }
    
}

- (void)persistUserData:(NSDictionary *)userData {
    
    //TODO: 暂时存在NSUserDefaults里面；
    [[NSUserDefaults standardUserDefaults] setValue:userData forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


+ (UserModel *)currentUser {
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    if (userDic) {
        return [[UserModel alloc] initWithDictionary:userDic error:nil];
    } else {
    }
        return nil;
}


@end











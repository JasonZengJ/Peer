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
#import "AppService.h"
#import <SMS_SDK/SMS_SDK.h>

#define LoginApiPath    @"v1/user/login"
#define RegisterApiPath @"v1/user/register"

@interface LoginService ()

@end

@implementation LoginService


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return  self;
}


#pragma mark - -- Login
- (void)loginWithUserModel:(UserModel *)userModel {
    
    NSDictionary *params = @{@"phone":userModel.phone,@"password":userModel.password,@"deviceId":[AppService deviceId]};
    [[PeerNetworkManager shareInstance] securePostWithParams:params apiPath:LoginApiPath target:self callBack:@selector(loginCompleted:)];
    
}

// 用户登录完成，如果登录成功，则保存用户数据到本地
- (void)loginCompleted:(NSDictionary *)dataDic {
    
    NSError *error = nil;
    if ([dataDic[@"code"] integerValue] == 0) {
        DLog(@"登录成功！");
        [self persistUserData:dataDic[@"data"]];
    } else {
        error = [NSError errorWithDomain:dataDic[@"msg"] code:[dataDic[@"code"] integerValue] userInfo:nil];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginCompleteWithError:)]) {
        [self.delegate loginCompleteWithError:error];
    }
    
}

#pragma mark - -- Register


- (void)getVerificationCodeWithPhone:(NSString *)phone result:(void(^)(NSError *err))result {
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:phone zone:@"86" result:^(SMS_SDKError *error) {
        //注意区号和手机号码前面都不要加“＋”号，有的开发者喜欢这样写，@“＋86”，这种是错误的写法
        if (!error) {
            NSLog(@"获取验证码成功");
            result(nil);
        } else {
            NSLog(@"错误吗：%zi,错误描述：%@",error.errorCode,error.errorDescription);
            NSError *err = [NSError errorWithDomain:error.errorDescription code:error.errorCode userInfo:nil];
            result(err);
        }
    }];
    
}

- (void)confirmVerificationCode:(NSString *)veryficationCode result:(void(^)(BOOL isSuccess))result {
    
    [SMS_SDK commitVerifyCode:veryficationCode result:^(enum SMS_ResponseState state) {
        //self.verfyCode.text这里传的是获取到的验证码，可以把获取到的验证码填写在文本框里面，然后获取到文本框里面的值传进参数里
        if (1==state) {
            NSLog(@"验证成功");
            result(YES);
        } else if (0==state){
            NSLog(@"验证失败");
            result(NO);
        }
    }];
    
}


- (void)registerWithUserModel:(UserModel *)userModel {
    
    NSDictionary *params = [userModel toDictionary];
    [[PeerNetworkManager shareInstance] securePostWithParams:params apiPath:RegisterApiPath target:self callBack:@selector(registerCompleted:)];
    
}

- (void)registerCompleted:(NSDictionary *)dataDic {
    
    NSDictionary *error = nil;
    if (dataDic[@"errCode"] != 0) {
        error = dataDic;
    } else {
        [self persistUserData:dataDic[@"data"]];
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
    }
    return nil;
    
}


@end











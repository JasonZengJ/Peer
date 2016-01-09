//
//  LoginService.h
//  Peer
//
//  Created by jason on 9/14/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@protocol LoginServiceDelegate <NSObject>

@optional
- (void)loginCompleteWithError:(NSError *)error;
- (void)registerCompleteWithError:(NSError *)error;

@end

@interface LoginService : NSObject


@property(nonatomic,weak) id<LoginServiceDelegate> delegate;

- (void)loginWithUserModel:(UserModel *)userModel ;

- (void)getVerificationCodeWithPhone:(NSString *)phone result:(void(^)(NSError *err))result;
- (void)confirmVerificationCode:(NSString *)veryficationCode result:(void(^)(BOOL isSuccess))result;
- (void)registerWithUserModel:(UserModel *)userModel;
- (void)persistUserData:(NSDictionary *)userData;
- (void)clearUserData;

+ (UserModel *)currentUser;

@end

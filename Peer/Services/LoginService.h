//
//  LoginService.h
//  Peer
//
//  Created by jason on 9/14/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginServiceDelegate <NSObject>

- (void)loginSuccessWithData:(NSDictionary *)data;
- (void)loginFailureWithData:(NSDictionary *)data;

@end

@interface LoginService : NSObject


@property(nonatomic,weak) id<LoginServiceDelegate> delegate;

- (void)loginWithParams:(NSDictionary *)params ;

- (NSDictionary *)currentUserData;

@end

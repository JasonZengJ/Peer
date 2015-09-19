//
//  LoginView.h
//  Peer
//
//  Created by jason on 9/14/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)clickedLoginButtonWithPhone:(NSString *)phone password:(NSString *)password;
- (void)clickedRegisterButton;

@end

@interface LoginView : UIView

@property(nonatomic,weak) id<LoginViewDelegate>delegate;

@end

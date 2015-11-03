//
//  LoginView.h
//  Peer
//
//  Created by jason on 9/14/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)tapForgetPassword;

- (void)clickedLoginButtonWithPhone:(NSString *)phone password:(NSString *)password;
- (void)clickedRegisterButton;

@end

@interface LoginView : UIView

@property(nonatomic) UIView      *loginTextFieldView;
@property(nonatomic) UIImageView *logoImageView;

@property(nonatomic,weak) id<LoginViewDelegate>delegate;

@end

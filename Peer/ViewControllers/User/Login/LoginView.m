//
//  LoginView.m
//  Peer
//
//  Created by jason on 9/14/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "LoginView.h"
#import "UIColor+Hex.h"
#import "UIView+Layout.h"
#import "UIImage+Color.h"

@interface LoginView ()

@property(nonatomic) UIImageView *backgroundImageView;
@property(nonatomic) UIImageView *logoImageView;
@property(nonatomic) UITextField *phoneTextField;
@property(nonatomic) UITextField *passwordTextField;
@property(nonatomic) UIButton    *loginButton;
@property(nonatomic) UIButton    *registerButton;

@property(nonatomic) UIButton    *wechatLoginButton;
@property(nonatomic) UIButton    *weiboLoginButton;
@property(nonatomic) UIButton    *qqLoginButton;

@end

@implementation LoginView

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"background"] stretchableImageWithLeftCapWidth:25 topCapHeight:25]];
        _backgroundImageView.frame = self.frame;
    }
    return _backgroundImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        _logoImageView.centerX = self.centerX;
        _logoImageView.top     = 40;
    }
    return _logoImageView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, self.logoImageView.bottom + 20, self.width - 100, 40)];
        _phoneTextField.textColor   = [UIColor whiteColor];
        NSAttributedString * phone = [[NSAttributedString alloc] initWithString:@"手机号码"
                                                                     attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        _phoneTextField.attributedPlaceholder = phone;
        [_phoneTextField showBottomBorder];
        [_phoneTextField setBorderColor:[UIColor whiteColor] withTag:UIViewBorderBottomLine];
    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, self.phoneTextField.bottom + 10, self.phoneTextField.width, 40)];
        _passwordTextField.textColor   = [UIColor whiteColor];
        NSAttributedString * password = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        _passwordTextField.attributedPlaceholder = password;
        
        [_passwordTextField showBottomBorder];
        [_passwordTextField setBorderColor:[UIColor whiteColor] withTag:UIViewBorderBottomLine];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(50, self.passwordTextField.bottom + 30, self.passwordTextField.width, 40)];
        _loginButton.layer.borderWidth  = 1;
        _loginButton.layer.borderColor  = [UIColor whiteColor].CGColor;
        _loginButton.layer.cornerRadius = 3;
        _loginButton.clipsToBounds      = YES;
        [_loginButton setTitle:@"登 陆" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor colorWithHex:0xFFB100 alpha:1.0] forState:UIControlStateHighlighted];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [_loginButton addTarget:self action:@selector(clickedLoginButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(50, self.loginButton.bottom + 20, self.loginButton.width, 40)];
        _registerButton.layer.borderWidth  = 1;
        _registerButton.layer.borderColor  = [UIColor whiteColor].CGColor;
        _registerButton.layer.cornerRadius = 3;
        _registerButton.clipsToBounds      = YES;
        [_registerButton setTitle:@"注 册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor colorWithHex:0xFFB100 alpha:1.0] forState:UIControlStateHighlighted];
        [_registerButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [_registerButton addTarget:self action:@selector(clickedRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLoginView)];
    tapGR.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGR];
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.logoImageView];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.loginButton];
    [self addSubview:self.registerButton];
    
    
    
}

#pragma mark - -- Action

- (void)tapLoginView {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)clickedLoginButton {
    
    NSString *phone    = self.phoneTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedLoginButtonWithPhone:password:)]) {
        [self.delegate clickedLoginButtonWithPhone:phone password:password];
    }
    
}

- (void)clickedRegisterButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedRegisterButton)]) {
        [self.delegate clickedRegisterButton];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

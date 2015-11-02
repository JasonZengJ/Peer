//
//  LoginView.m
//  Peer
//
//  Created by jason on 9/14/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "LoginView.h"
#import "UIColor+Hex.h"
#import "UIView+Layout.h"
#import "UIImage+Color.h"
#import "SDCycleScrollView.h"

@interface LoginView ()

@property(nonatomic) UIImageView *backgroundImageView;
@property(nonatomic) UIImageView *logoImageView;
@property(nonatomic) UITextField *phoneTextField;
@property(nonatomic) UITextField *passwordTextField;
@property(nonatomic) UIView      *loginTextFieldView;
@property(nonatomic) UIButton    *loginButton;
@property(nonatomic) UIButton    *registerButton;

@property(nonatomic) UIButton    *wechatLoginButton;
@property(nonatomic) UIButton    *weiboLoginButton;
@property(nonatomic) UIButton    *qqLoginButton;
@property(nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation LoginView

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"UserLoginShadowView"] stretchableImageWithLeftCapWidth:25 topCapHeight:25]];
        _backgroundImageView.frame = self.frame;
    }
    return _backgroundImageView;
}


- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _cycleScrollView.localizationImagesGroup = @[[UIImage imageNamed:@"UserLoginBg3"],[UIImage imageNamed:@"UserLoginBg2"],[UIImage imageNamed:@"UserLoginBg1"]];
        _cycleScrollView.autoScrollTimeInterval  = 3.0;
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.userInteractionEnabled = NO;
    }
    return _cycleScrollView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserLoginWaterMark"]];
        _logoImageView.centerX = self.centerX;
        _logoImageView.top     = ConvertiPhone5Or6pSize(190.0f);
    }
    return _logoImageView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.loginTextFieldView.width, ConvertiPhone5Or6pSize(45.0f))];
        _phoneTextField.textColor   = [UIColor colorWithHex:0x4c4c4c];
        [_phoneTextField setFont:[UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]];
        NSAttributedString * phone = [[NSAttributedString alloc] initWithString:@"请输入手机号码"
                                                                     attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:0xe5e5e5],
                                                                                  NSFontAttributeName: [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]}];
        _phoneTextField.attributedPlaceholder = phone;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.leftView     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(38.0f), _phoneTextField.height)];
        UIImageView *leftImageView   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserLoginPhone"]];
        leftImageView.frame   = CGRectMake(10.0, 0, ConvertiPhone5Or6pSize(20.0f), ConvertiPhone5Or6pSize(20.0f));
        leftImageView.centerY = _phoneTextField.height / 2;
        [_phoneTextField.leftView addSubview:leftImageView];
        
    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.phoneTextField.bottom, self.loginTextFieldView.width,self.phoneTextField.height)];
        _passwordTextField.textColor  = [UIColor colorWithHex:0x4c4c4c];
        [_passwordTextField setFont:[UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]];
        NSAttributedString * password = [[NSAttributedString alloc] initWithString:@"请输入密码"
                                                                        attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:0xe5e5e5],
                                                                                     NSFontAttributeName: [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]}];
        _passwordTextField.attributedPlaceholder = password;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.leftView     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(38.0f), _passwordTextField.height)];
        UIImageView *leftImageView      = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserLoginPassword"]];
        leftImageView.frame   = CGRectMake(10.0, 0, ConvertiPhone5Or6pSize(20.0f), ConvertiPhone5Or6pSize(20.0f));
        leftImageView.centerY = _passwordTextField.height / 2;
        [_passwordTextField.leftView addSubview:leftImageView];
        
        _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
        _passwordTextField.rightView     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(30.0f), _passwordTextField.height)];
        UIImageView *rightImageView      = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserLoginForgetPassword"]];
        rightImageView.frame   = CGRectMake(0, 0, ConvertiPhone5Or6pSize(20.0f), ConvertiPhone5Or6pSize(20.0f));
        rightImageView.centerY = _passwordTextField.height / 2;
        rightImageView.userInteractionEnabled = YES;
        [rightImageView addTapGestureWithTarget:self action:@selector(tapForgetPasswordImageView)];
        [_passwordTextField.rightView addSubview:rightImageView];
        
        
    }
    return _passwordTextField;
}

- (UIView *)loginTextFieldView {
    if (!_loginTextFieldView) {
        _loginTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.width - 20.0f, ConvertiPhone5Or6pSize(90.0f))];
        _loginTextFieldView.bottom             = self.loginButton.top - 20.0f;
        _loginTextFieldView.backgroundColor    = [UIColor whiteColor];
//        _loginTextFieldView.clipsToBounds      = YES;
        _loginTextFieldView.layer.cornerRadius = 3;
        _loginTextFieldView.layer.shadowOpacity = 0.1;
        _loginTextFieldView.layer.shadowOffset = CGSizeMake(0, 0);
        _loginTextFieldView.layer.shadowColor = [UIColor blackColor].CGColor;
        
        
    }
    return _loginTextFieldView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.passwordTextField.bottom + 30, (self.width - 30.0f) / 2, ConvertiPhone5Or6pSize(45.0f))];
        _loginButton.bottom = self.height - 15.0f;
        _loginButton.layer.borderWidth  = 1;
        _loginButton.layer.borderColor  = [UIColor whiteColor].CGColor;
        _loginButton.layer.cornerRadius = 4;
        _loginButton.clipsToBounds      = YES;
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor colorWithHex:0xFFB100 alpha:1.0] forState:UIControlStateHighlighted];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2fe000 ]] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(clickedLoginButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(self.loginButton.right + 10.0f, self.loginButton.top , self.loginButton.width, ConvertiPhone5Or6pSize(45.0f))];
        _registerButton.layer.borderWidth  = 1;
        _registerButton.layer.borderColor  = [UIColor whiteColor].CGColor;
        _registerButton.layer.cornerRadius = 4;
        _registerButton.clipsToBounds      = YES;
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor colorWithHex:0xFFB100 alpha:1.0] forState:UIControlStateHighlighted];
        [_registerButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xffb800]] forState:UIControlStateNormal];
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
    
    [self addSubview:self.cycleScrollView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.logoImageView];
    [self addSubview:self.loginTextFieldView];
    [self addSubview:self.loginButton];
    [self addSubview:self.registerButton];
    
    [self.loginTextFieldView addSubview:self.phoneTextField];
    [self.loginTextFieldView addSubview:self.passwordTextField];
    
    [self.loginTextFieldView addLineWithFrame:CGRectMake(5, self.loginTextFieldView.height / 2, self.loginTextFieldView.width - 10.0f, 0.5) border:UIViewBorderBottomLine];
}

#pragma mark - -- Action


- (void)tapLoginView {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)tapForgetPasswordImageView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapForgetPassword)]) {
        [self.delegate tapForgetPassword];
    }
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

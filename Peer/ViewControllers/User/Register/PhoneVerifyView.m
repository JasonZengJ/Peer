//
//  PhoneVerifyView.m
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PhoneVerifyView.h"

@interface PhoneVerifyView ()

@property(nonatomic) UITextField *phoneTextField;
@property(nonatomic) UITextField *verifyCodeTextField;
@property(nonatomic) UITextField *passwordTextField;
@property(nonatomic) UIButton    *getVerifyCodeButton;

@end

@implementation PhoneVerifyView


- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 16.0f, self.width - 20.0f, ConvertiPhone5Or6pSize(45.0f))];
        NSAttributedString * phone = [[NSAttributedString alloc] initWithString:@"请输入手机号码"
                                                                     attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:0xe5e5e5],
                                                                                  NSFontAttributeName: [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]}];
        _phoneTextField.attributedPlaceholder = phone;
        [self configureTextField:_phoneTextField withLeftViewImage:[UIImage imageNamed:@"UserLoginPhone"]];
        
    }
    return _phoneTextField;
}

- (UITextField *)verifyCodeTextField {
    
    if (!_verifyCodeTextField) {
        
        _verifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, self.phoneTextField.bottom + 10.0f, ConvertiPhone5Or6pSize(215.0f), ConvertiPhone5Or6pSize(45.0f))];
        NSAttributedString * phone = [[NSAttributedString alloc] initWithString:@"请输入验证码"
                                                                     attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:0xe5e5e5],
                                                                                  NSFontAttributeName: [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]}];
        _verifyCodeTextField.attributedPlaceholder = phone;
        [self configureTextField:_verifyCodeTextField withLeftViewImage:[UIImage imageNamed:@"UserRegisterVerifyCode"]];
        
    }
    
    return _verifyCodeTextField;
}

- (UITextField *)passwordTextField {
    
    if (!_passwordTextField) {
        
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.verifyCodeTextField.bottom + 10.0f, self.phoneTextField.width,self.phoneTextField.height)];
        _passwordTextField.layer.cornerRadius = 3;
        [_passwordTextField setBackgroundColor:[UIColor whiteColor]];
        NSAttributedString * password = [[NSAttributedString alloc] initWithString:@"请输入密码"
                                                                        attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:0xe5e5e5],
                                                                                     NSFontAttributeName: [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]}];
        _passwordTextField.attributedPlaceholder = password;
        [self configureTextField:_passwordTextField withLeftViewImage:[UIImage imageNamed:@"UserLoginPassword"]];

        
    }
    
    return _passwordTextField;
    
}

- (UIButton *)getVerifyCodeButton {
    if (!_getVerifyCodeButton) {
        _getVerifyCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.verifyCodeTextField.right + 10.0f, self.verifyCodeTextField.top, ConvertiPhone5Or6pSize(130.0f), ConvertiPhone5Or6pSize(45.0f))];
        _getVerifyCodeButton.titleLabel.font    = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        _getVerifyCodeButton.layer.cornerRadius = 3;
        [_getVerifyCodeButton setBackgroundColor:[UIColor colorWithHex:0xffb800]];
        [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return _getVerifyCodeButton;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self addSubview:self.phoneTextField];
    [self addSubview:self.verifyCodeTextField];
    [self addSubview:self.getVerifyCodeButton];
    [self addSubview:self.passwordTextField];
}

- (void)configureTextField:(UITextField *)textField withLeftViewImage:(UIImage *)image {
    textField.textColor           = [UIColor colorWithHex:0x4c4c4c];
    textField.backgroundColor     = [UIColor whiteColor];
    textField.layer.cornerRadius  = 3;
    textField.layer.shadowColor   = [UIColor blackColor].CGColor;
    textField.layer.shadowOffset  = CGSizeMake(0.0, 0.0);
    textField.layer.shadowOpacity = 0.1;
    textField.layer.masksToBounds = NO;
    [textField setFont:[UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(38.0f), textField.height)];
    UIImageView *leftImageView      = [[UIImageView alloc] initWithImage:image];
    leftImageView.frame   = CGRectMake(10.0, 0, ConvertiPhone5Or6pSize(20.0f), ConvertiPhone5Or6pSize(20.0f));
    leftImageView.centerY = textField.height / 2 - 1;
    [textField.leftView addSubview:leftImageView];
}

@end

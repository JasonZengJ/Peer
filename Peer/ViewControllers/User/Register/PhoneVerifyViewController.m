//
//  PhoneVerifyViewController.m
//  Peer
//
//  Created by jason on 9/18/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PhoneVerifyViewController.h"
#import "PhoneVerifyView.h"

#import "RegisterInfoViewController.h"

#import "ValidationService.h"
#import "LoginService.h"
#import "AppService.h"
#import "UserModel.h"

@interface PhoneVerifyViewController () <PhoneVerifyViewDelegate>

@property(nonatomic)PhoneVerifyView *phoneVerifyView;
@property(nonatomic)LoginService *loginService;
@property(nonatomic)UserModel *user;
@property(nonatomic)NSTimer   *timer;
@property(nonatomic)NSInteger countDown; // 倒计时

@end

@implementation PhoneVerifyViewController


- (PhoneVerifyView *)phoneVerifyView {
    if (!_phoneVerifyView) {
        _phoneVerifyView = [[PhoneVerifyView alloc] initWithFrame:CGRectMake(0, 64.0f, self.view.width, self.view.height - 64.0f)];
        _phoneVerifyView.delegate = self;
        _phoneVerifyView.backgroundColor = [UIColor clearColor];
    }
    return _phoneVerifyView;
}

- (LoginService *)loginService {
    if (!_loginService) {
        _loginService = [[LoginService alloc] init];
    }
    return _loginService;
}

- (void)loadView {
    [super loadView];
    self.title = NSLocalizedString(@"Register", nil);
    [self.view addSubview:self.phoneVerifyView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (UIBarButtonItem *)rightBarButtonItem {
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImage *backImage = [UIImage imageNamed:@"UserRegisterNextStep"];
    aButton.frame= CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(rightNavbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    return barButton;
    
}

- (void)rightNavbarButtonAction:(UIButton *)sender {
    
//    
//    RegisterInfoViewController *registerInfoViewController = [[RegisterInfoViewController alloc] init];
//    registerInfoViewController.user = self.user;
//    registerInfoViewController.backActionType = BackActionTypePop;
//    [self.navigationController pushViewController:registerInfoViewController animated:YES];
//    
//    return;
    
    NSString *verifyCode = self.phoneVerifyView.verifyCodeTextField.text;
    NSString *password   = self.phoneVerifyView.passwordTextField.text;
    
    if (![ValidationService checkNumber:verifyCode]) {
        [self alertWithMessage:@"请填写正确的验证码"];
        return;
    }
    
    if (password.length < 6) {
        [self alertWithMessage:@"密码不能少于6位数"];
        return;
    }
    
    [self.loginService confirmVerificationCode:verifyCode result:^(BOOL isSuccess) {
        
        if (isSuccess) {
            self.user.password = password;
            self.user.deviceId = [AppService deviceId];
            [self.loginService persistUserData:[self.user toDictionary]];
            RegisterInfoViewController *registerInfoViewController = [[RegisterInfoViewController alloc] init];
            registerInfoViewController.user = self.user;
            registerInfoViewController.backActionType = BackActionTypePop;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:registerInfoViewController animated:YES];
            });
        } else {
            [self alertWithMessage:@"验证码验证失败"];
        }
        
    }];
    

    
}

#pragma mark - -- <PhoneVerifyViewDelegate>

- (void)clickedGetVerifyCodeButtonWithPhone:(NSString *)phone {
    
    if (![ValidationService checkPhoneNumber:phone]) {
        [self alertWithMessage:@"请填写正确的手机号码"];
        return;
    }
    
    DLog(@"开始发送验证码");
    [self.loginService getVerificationCodeWithPhone:phone result:^(NSError *error) {
        DLog(@"发送验证码接收到回调");
        if (error) {
            [self alertWithMessage:error.domain];
        } else {
            self.user = [[UserModel alloc] init];
            self.user.phone = phone;
        }
    }];
    [self.phoneVerifyView disableGetVerifyCodeButtonForSeconds:60];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

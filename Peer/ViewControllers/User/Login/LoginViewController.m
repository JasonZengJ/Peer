//
//  LoginViewController.m
//  Peer
//
//  Created by jason on 9/9/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "LoginViewController.h"
#import "PhoneVerifyViewController.h"

#import "LoginView.h"
#import "SDCycleScrollView.h"

#import "LoginService.h"
#import "ValidationService.h"
#import "UserModel.h"


@interface LoginViewController () <LoginViewDelegate,LoginServiceDelegate>

@property(nonatomic) LoginView *loginView;
@property(nonatomic) LoginService* loginService;
@property(nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation LoginViewController


- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _cycleScrollView.localizationImagesGroup = @[[UIImage imageNamed:@"UserLoginBg3"],[UIImage imageNamed:@"UserLoginBg2"],[UIImage imageNamed:@"UserLoginBg1"]];
        _cycleScrollView.autoScrollTimeInterval  = 3.0;
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.userInteractionEnabled = NO;
    }
    return _cycleScrollView;
}



- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _loginView.delegate = self;
    }
    return _loginView;
}

- (LoginService *)loginService {
    if (!_loginService) {
        _loginService = [[LoginService alloc] init];
        _loginService.delegate = self;
    }
    return _loginService;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cycleScrollView];
    [self.view addSubview:self.loginView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
   
}

- (void)back {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (UIBarButtonItem *)leftBackBarButtonItem {
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImage *backImage = [UIImage imageNamed:@"UserLoginClose"];
    aButton.frame = CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    return barButton;
    
}


- (UIBarButtonItem *)rightBarButtonItem {
    return nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - -- KeybordNotification

- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration     = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curve     = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGFloat animateDistance = keyboardRect.size.height - (self.loginView.height - self.loginView.loginTextFieldView.bottom);
    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
        
        self.loginView.logoImageView.hidden = YES;
        self.loginView.top = -animateDistance;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    double duration     = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curve     = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
        
        self.loginView.logoImageView.hidden = NO;
        self.loginView.top = 0;
        
    } completion:^(BOOL finished) {
    }];
}


#pragma mark - -- <LoginViewDelegate>


- (void)tapForgetPassword {
    
}

- (void)clickedLoginButtonWithPhone:(NSString *)phone password:(NSString *)password {
    
    //TODO: phone 和 password 校验
    
    if (![ValidationService checkPhoneNumber:phone]) {
        [self alertMessage:@"请输入正确的手机号码"];
        return;
    }
    
    if (!password || password.length < 6) {
        [self alertMessage:@"请输入至少6位数密码"];
        return;
    }
    
    UserModel *model = [[UserModel alloc] init];
    model.phone      = phone;
    model.password   = password;
    [self.loginService loginWithUserModel:model];
    
    
}

- (void)clickedRegisterButton {
    
    PhoneVerifyViewController *phoneVerifyViewController = [[PhoneVerifyViewController alloc] init];
    phoneVerifyViewController.backActionType = BackActionTypePop;
    [self.navigationController pushViewController:phoneVerifyViewController animated:YES];
}

- (void)alertMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - -- <LoginServiceDelegate>

- (void)loginCompleteWithError:(NSError *)error {
    
    if (error) {
        [self alertMessage:error.domain];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
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

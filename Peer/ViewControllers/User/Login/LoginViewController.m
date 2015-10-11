//
//  LoginViewController.m
//  Peer
//
//  Created by jason on 9/9/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginService.h"
#import "PeerNetworkManager.h"
#import "PhoneVerifyViewController.h"
#import "UserModel.h"

@interface LoginViewController () <LoginViewDelegate>

@property(nonatomic) LoginView *loginView;
@property(nonatomic) LoginService* loginService;

@end

@implementation LoginViewController



- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:self.view.frame];
        _loginView.delegate = self;
    }
    return _loginView;
}

- (LoginService *)loginService {
    if (!_loginService) {
        _loginService = [[LoginService alloc] init];
    }
    return _loginService;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [[PeerNetworkManager shareInstance] securePostWithParams:@{} apiPath:@"user/login" target:self callBack:@selector(back)];
   
}

- (void)back {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


#pragma mark - -- <LoginViewDelegate>

- (void)clickedLoginButtonWithPhone:(NSString *)phone password:(NSString *)password {
    
    //TODO: phone 和 password 校验
    
    UserModel *model = [[UserModel alloc] init];
    model.phone      = phone;
    model.password   = password;
//    [self.loginService loginWithParams:@{@"phone":phone,@"password":password}];
    
    
}

- (void)clickedRegisterButton {
    
//    NSString *phone = @"18501638736";
    
//    UINavigationController *nav = [[PhoneVerifyViewController alloc] init];
    
//    [self presentViewController:nav animated:YES completion:^{
//        
//    }];
}


#pragma mark - -- <LoginServiceDelegate>

- (void)loginCompleteWithError:(NSDictionary *)error {
    
    if (error) {
        
    } else {
        
    }
    
}

- (void)loginSuccessWithData:(NSDictionary *)data {
    
    DLog(@"Login success:\n%@",data);
}

- (void)loginFailureWithData:(NSDictionary *)data {
    DLog(@"Login falure:\n%@",data);
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

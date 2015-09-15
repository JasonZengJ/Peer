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
#import "OpenUDID.h"

@interface LoginViewController () <LoginViewDelegate,LoginServiceDelegate>

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginView];

    
    DLog(@"%@",[OpenUDID value]);
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    
    NSString *version = infoDictionary[@"CFBundleShortVersionString"];
    NSString *name  = infoDictionary[(NSString*)kCFBundleNameKey];
    
    
    DLog(@"");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


#pragma mark - -- <LoginViewDelegate>

- (void)clickedLoginButtonWithPhone:(NSString *)phone password:(NSString *)password {
    
    //TODO: phone 和 password 校验
    [self.loginService loginWithParams:@{@"phone":phone,@"password":password}];
    
    
}


#pragma mark - -- <LoginServiceDelegate>

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

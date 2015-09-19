//
//  TestViewController.m
//  Peer
//
//  Created by jason on 9/19/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "TestViewController.h"
#import "LoginService.h"
#import "UserModel.h"

@interface TestViewController ()


@property(nonatomic)LoginService *loginService;

@end

@implementation TestViewController


- (LoginService *)loginService {
    if (!_loginService) {
        _loginService = [[LoginService alloc] init];
    }
    return _loginService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testUserRegister];
}

- (void)testUserRegister {
    
    UserModel *userModel = [[UserModel alloc] init];
    userModel.phone    = @"18511111112";
    userModel.password = @"123456";
    userModel.nickname = @"jason";
    userModel.sex      = @1;
    userModel.city     = @"深圳";
    userModel.avatar   = @"http://img3.imgtn.bdimg.com/it/u=2117727038,2641018931&fm=21&gp=0.jpg";
    
    [self.loginService registerWithUserModel:userModel];
    
}

- (void)testUserLogin {
    
    UserModel *userModel = [[UserModel alloc] init];
    userModel.phone = @"18512341238";
    userModel.password = @"123456";
    [self.loginService loginWithUserModel:userModel];
    
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

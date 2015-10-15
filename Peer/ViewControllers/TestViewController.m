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
#import "UIView+Layout.h"
#import "AppService.h"
#import "OSSFileManager.h"
#import <ALBB_OSS_IOS_SDK/OSSTool.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 219, 202)];
    [imageView setImageWithURL:[NSURL URLWithString:@"http://peer-love.oss-cn-shenzhen.aliyuncs.com/E91E747403024DC0E4963A1C9872D147.png"] placeholderImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:imageView];
    
    
}

- (void)addLabelToView:(UIView *)view text:(NSString *)text {
    UILabel *label  = [[UILabel alloc] initWithFrame:view.bounds];
    label.text      = text;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
}

- (void)testUploadFileToOSS {
    
    NSURL *imgUrl = [[NSBundle mainBundle] URLForResource:@"background" withExtension:@"png"];
    NSData *data  = [NSData dataWithContentsOfURL:imgUrl];
    
    OSSFileManager *fileManager = [[OSSFileManager alloc] init];
    [fileManager uploadImageData:data  callback:^(BOOL isSuccess, NSError *error,NSString *fileUrl) {
        NSLog(@"file:%@ %@",fileUrl,isSuccess ? @"YES" : @"NO");
    } progressCallback:^(float progress) {
        DLog(@"uploaded : %f",progress);
    }];
    
    
    
}

- (void)testAutoresize {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    leftView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:leftView];
    [self addLabelToView:leftView text:@"LeftView"];
    
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(leftView.left, leftView.bottom + 20, 100, 100)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomView];
    [self addLabelToView:bottomView text:@"BottomView"];
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(leftView.right + 20, leftView.top, 100, 100)];
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    [self addLabelToView:rightView text:@"RightView"];
}

- (void)testGetVerificationCode {
    [self.loginService getVerificationCodeWithPhone:@"18501638736" result:^(BOOL isSuccess) {
        
    }];
}

- (void)testConfirmVerificationCode {
    [self.loginService confirmVerificationCode:@"3299" result:^(BOOL isSuccess) {
        
    }];
}


- (void)testUserRegister {
    
    UserModel *userModel = [[UserModel alloc] init];
    userModel.phone    = @"18511111112";
    userModel.password = @"123456";
    userModel.nickname = @"jason";
    userModel.sex      = @1;
    userModel.city     = @"深圳";
    userModel.avatar   = @"http://img3.imgtn.bdimg.com/it/u=2117727038,2641018931&fm=21&gp=0.jpg";
    
    
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

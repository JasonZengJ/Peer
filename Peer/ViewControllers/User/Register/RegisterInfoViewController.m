//
//  RegisterInfoViewController.m
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RegisterInfoViewController.h"
#import "RegisterInfoView.h"
#import "LoginService.h"

#import "FillRegisterInfoViewController.h"

@interface RegisterInfoViewController () <RegisterInfoViewDelegate,LoginServiceDelegate,FillRegisterInfoViewControllerDelegate>

@property(nonatomic)RegisterInfoView *registerInfoView;
@property(nonatomic)LoginService *loginService;

@end

@implementation RegisterInfoViewController

- (RegisterInfoView *)registerInfoView {
    if (!_registerInfoView) {
        _registerInfoView = [[RegisterInfoView alloc] initWithFrame:self.view.frame];
        _registerInfoView.delegate = self;
    }
    return _registerInfoView;
}

- (LoginService *)loginService {
    if (!_loginService) {
        _loginService = [[LoginService alloc] init];
    }
    return _loginService;
}

- (void)loadView {
    [super loadView];
    self.title = NSLocalizedString(@"RegisterFillInUserProfile", nil);
    [self.view addSubview:self.registerInfoView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.registerInfoView setNickname:@"Duan.c.z"];
    [self.registerInfoView setSex:UserSexGirl];
    [self.registerInfoView setAge:@"18"];
    [self.registerInfoView setArea:@"广州－白云"];
    [self.registerInfoView setUserDescription:@"我叫陈柱端，今年18，性别女～"];
    
    [self.registerInfoView.userAvatarImageView setImage:[UIImage imageNamed:@"DuanAvatar"]];
    
}

- (UIBarButtonItem *)rightBarButtonItem {
    return nil;
}

#pragma mark - -- <RegisterInfoViewDelegate>

- (void)tapCellWithCellTag:(NSInteger)tag {
    
    
    switch (tag) {
        case RegisterInfoAge: {
        }
            break;
        case RegisterInfoArea: {
        }
            break;
        case RegisterInfoNickname: {
            FillRegisterInfoViewController *fillRegisterInfoViewController = [[FillRegisterInfoViewController alloc] init];
            fillRegisterInfoViewController.title = NSLocalizedString(@"RegisterNickname", nil);
            fillRegisterInfoViewController.registerInfoFillType = RegisterInfoFillTypeNickname;
            fillRegisterInfoViewController.delegate = self;
            [self.navigationController pushViewController:fillRegisterInfoViewController animated:YES];
        }
            break;
        case RegisterInfoSex: {
        }
            break;
        case RegisterInfoDescription: {
            FillRegisterInfoViewController *fillRegisterInfoViewController = [[FillRegisterInfoViewController alloc] init];
            fillRegisterInfoViewController.title = NSLocalizedString(@"RegisterIntroduction", nil);
            fillRegisterInfoViewController.registerInfoFillType = RegisterInfoFillTypeUserDescription;
            fillRegisterInfoViewController.delegate = self;
            [self.navigationController pushViewController:fillRegisterInfoViewController animated:YES];
        }
            break;
        default:
            break;
    }
    
    
}

- (void)clickedDoneButton {
    [self.loginService registerWithUserModel:self.user];
}

#pragma mark - -- <LoginServiceDelegate>

- (void)registerCompleteWithError:(NSDictionary *)error {
    
}

#pragma mark - -- <FillRegisterInfoViewControllerDelegate>

- (void)fillNickname:(NSString *)nickname {
    [self.registerInfoView setNickname:nickname];
    self.user.nickname = nickname;
}

- (void)fillUserDescription:(NSString *)userDescription {
    [self.registerInfoView setUserDescription:userDescription];
    self.user.userDescription = userDescription;
}

@end

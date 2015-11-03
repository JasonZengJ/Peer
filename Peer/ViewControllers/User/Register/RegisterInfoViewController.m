//
//  RegisterInfoViewController.m
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RegisterInfoViewController.h"
#import "RegisterInfoView.h"

@interface RegisterInfoViewController () <RegisterInfoViewDelegate>

@property(nonatomic)RegisterInfoView *registerInfoView;

@end

@implementation RegisterInfoViewController

- (RegisterInfoView *)registerInfoView {
    if (!_registerInfoView) {
        _registerInfoView = [[RegisterInfoView alloc] initWithFrame:self.view.frame];
        _registerInfoView.delegate = self;
    }
    return _registerInfoView;
}


- (void)loadView {
    [super loadView];
    self.title = @"填写个人信息";
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
        case RegisterInfoCellAge: {
            
        }
            break;
        case RegisterInfoCellArea: {
            
        }
            break;
        case RegisterInfoCellNickname: {
            
        }
            break;
        case RegisterInfoCellSex: {
            
        }
            break;
        default:
            break;
    }
    
}

@end

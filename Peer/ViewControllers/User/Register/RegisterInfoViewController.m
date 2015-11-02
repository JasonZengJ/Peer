//
//  RegisterInfoViewController.m
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RegisterInfoViewController.h"
#import "RegisterInfoView.h"

@interface RegisterInfoViewController ()

@property(nonatomic)RegisterInfoView *registerInfoView;

@end

@implementation RegisterInfoViewController

- (RegisterInfoView *)registerInfoView {
    if (!_registerInfoView) {
        _registerInfoView = [[RegisterInfoView alloc] initWithFrame:self.view.frame];
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
}

@end

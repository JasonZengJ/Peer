//
//  LoginViewController.m
//  Peer
//
//  Created by jason on 9/9/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property(nonatomic) UIImageView *backgroundImageView;

@end

@implementation LoginViewController


- (UIImageView *)backgroundImageView {
    if (_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundimage"]];
    }
    return _backgroundImageView;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
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

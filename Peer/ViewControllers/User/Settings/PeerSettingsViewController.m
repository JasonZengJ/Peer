//
//  PeerSettingsViewController.m
//  Peer
//
//  Created by jason on 3/3/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "PeerSettingsViewController.h"
#import "PeerInfoTableView.h"
#import "UIView+RoundBorderShadow.h"

typedef NS_ENUM(NSInteger,SettingSection) {
    SettingSectionSecurity,
    SettingSectionSystem,
    SettingSectionFeed,
    SECTION_NUMS,
};

typedef NS_ENUM(NSInteger,SecurityRow) {
    SecurityRowAccount,
    SecurityRowNotification,
    SECURITYROW_NUMS,
};

typedef NS_ENUM(NSInteger,SystemRow) {
    SystemRowInvitation,
    SystemRowAbout,
    SYSTEMROW_NUMS,
};

typedef NS_ENUM(NSInteger,FeedRow) {
    FeedRowFeedBack,
    
    FEEDROW_NUMS,
};



@interface PeerSettingsViewController () <PeerInfoTableViewDelegate>

@property(nonatomic,strong)UIButton *logoutButton;
@property(nonatomic,strong)PeerInfoTableView *peerInfoTableView;


@end

@implementation PeerSettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置"];
    
    
    [self.view addSubview:self.peerInfoTableView];
    [self.view addSubview:self.logoutButton];
    [self.peerInfoTableView reloadDataWithCompletionBlock:nil];
    
}

- (UIBarButtonItem *)rightBarButtonItem {
    return nil;
}

- (void)logoutAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要退出登陆吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"log out");
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - -- <PeerInfoTableViewDelegate>


- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case SettingSectionSecurity:
            return SECURITYROW_NUMS;
        case SettingSectionSystem:
            return SYSTEMROW_NUMS;
        case SettingSectionFeed:
            return FEEDROW_NUMS;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSection {
    return SECTION_NUMS;
}


- (PeerInfoTableViewCell *)tableView:(PeerInfoTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PeerInfoTableViewCell *infoCell = [[PeerInfoTableViewCell alloc] init];
    
    switch (indexPath.section) {
        case SettingSectionSecurity:
            switch (indexPath.row) {
                case SecurityRowAccount:
                    infoCell.leftTitleLabel.text = @"账号与安全";
                    infoCell.needBottomLine = YES;
                    break;
                case SecurityRowNotification:
                    infoCell.leftTitleLabel.text = @"通知";
                    break;
                    
                default:
                    break;
            }
            
            break;
        case SettingSectionSystem:
            switch (indexPath.row) {
                case SystemRowInvitation:
                    infoCell.leftTitleLabel.text = @"邀请好友";
                    infoCell.needBottomLine = YES;
                    break;
                case SystemRowAbout:
                    infoCell.leftTitleLabel.text = @"关于peer";
                    break;
                default:
                    break;
            }
            break;
        case SettingSectionFeed:
            switch (indexPath.row) {
                case FeedRowFeedBack:
                    infoCell.leftTitleLabel.text = @"意见反馈";
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    
    return infoCell;
}


- (void)tableView:(PeerInfoTableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath {
    
}

- (PeerInfoTableView *)peerInfoTableView {
    if (!_peerInfoTableView) {
        _peerInfoTableView = [[PeerInfoTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64.0f)];
        _peerInfoTableView.tableViewDelegate = self;
        _peerInfoTableView.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 15.0f)];
    }
    return _peerInfoTableView;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, self.view.height - 45.0f - 10.0f, self.view.width - 20.0f, 45.0f)];
        _logoutButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_logoutButton configRoundBorderShadow];
        [_logoutButton setTitle:@"退出登陆" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor colorWithHex:0xFFB802] forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _logoutButton;
}


@end

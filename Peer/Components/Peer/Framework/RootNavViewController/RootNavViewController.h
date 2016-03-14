//
//  RootNavViewController.h
//  Peer
//
//  Created by jason on 10/25/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BackActionType) {
    BackActionTypePop = 1,
    BackActionTypeDismiss,
};

@interface RootNavViewController : UIViewController

@property(nonatomic,strong)UIView *navbarBgView;
@property(nonatomic,assign)BackActionType backActionType;
@property(nonatomic,strong)UIButton *rightBarButton;

- (UIBarButtonItem *)rightBarButtonItem;

- (UIBarButtonItem *)leftBackBarButtonItem;

- (void)backButtonAction:(UIButton *)sender;

- (void)rightNavbarButtonAction:(UIButton *)sender;
- (void)alertWithMessage:(NSString *)message;
- (void)alertWithMessage:(NSString *)message callback:(void(^)())callback;

@end

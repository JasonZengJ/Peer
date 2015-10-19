//
//  HomeBottomView.m
//  Peer
//
//  Created by jason on 15/10/18.
//  Copyright © 2015年 peers. All rights reserved.
//

#import "HomeBottomView.h"


@interface HomeBottomView ()

@property(nonatomic) UIImageView *userInfoImageView;
@property(nonatomic) UIImageView *sendMomentImageView;

@end

@implementation HomeBottomView


- (UIImageView *)userInfoImageView {
    if (!_userInfoImageView) {
        _userInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25))];
        _userInfoImageView.image = [UIImage imageNamed:@"HomeUser"];
        
    }
    
    return _userInfoImageView;
}

- (UIImageView *)sendMomentImageView {
    if (!_sendMomentImageView) {
        _sendMomentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(50.0f), ConvertiPhone5Or6pSize(50.0f))];
        _sendMomentImageView.image = [UIImage imageNamed:@"HomeSendMoment"];
        
    }
    return _sendMomentImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
    
}

- (void)initSubviews {
    
    [self addSubview:self.userInfoImageView];
    [self addSubview:self.sendMomentImageView];
    
}

- (void)layoutSubviews {
    self.userInfoImageView.centerY  = self.height / 2;
    self.sendMomentImageView.centerX = self.width / 2;
    self.sendMomentImageView.centerY = self.height / 2;
}

@end

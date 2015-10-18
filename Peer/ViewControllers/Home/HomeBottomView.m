//
//  HomeBottomView.m
//  Peer
//
//  Created by jason on 15/10/18.
//  Copyright © 2015年 peers. All rights reserved.
//

#import "HomeBottomView.h"


@interface HomeBottomView ()

@property(nonatomic) UIImageView *userInfoImage;
@property(nonatomic) UIImageView *sendMoment;

@end

@implementation HomeBottomView


- (UIImageView *)userInfoImage {
    if (!_userInfoImage) {
        _userInfoImage = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 0, ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25))];
        _userInfoImage.image = [UIImage imageNamed:@"HomeUser"];
        
    }
    
    return _userInfoImage;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
    
}

- (void)initSubviews {
    
    [self addSubview:self.userInfoImage];
    
}

- (void)layoutSubviews {
    self.userInfoImage.centerY = self.height / 2;
}

@end

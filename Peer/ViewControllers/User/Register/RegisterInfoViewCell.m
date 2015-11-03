//
//  RegisterInfoViewCell.m
//  Peer
//
//  Created by jason on 11/3/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RegisterInfoViewCell.h"
#import "NSString+Size.h"


@implementation RegisterInfoViewCell


- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0, 0, self.height)];
        _leftTitleLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        _leftTitleLabel.textColor = [UIColor colorWithHex:0x808080];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
        _rightTitleLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        _rightTitleLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
    }
    return _rightTitleLabel;
}

- (UIView *)accessoryView {
    if (!_accessoryView) {
        _accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserRegisterInfoRightAccessory"]];
        _accessoryView.centerY = self.height / 2;
        _accessoryView.right   = self.width - 10.0f;
    }
    return _accessoryView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self addSubview:self.leftTitleLabel];
    [self addSubview:self.rightTitleLabel];
    [self addSubview:self.accessoryView];
    
}

- (void)layoutSubviews {
    
    self.leftTitleLabel.width  = [self.leftTitleLabel.text widthWithFont:self.leftTitleLabel.font];
    
    if (self.rightView && ![self.subviews containsObject:self.rightView]) {
        self.rightView.right   = self.accessoryView.left - 10.0f;
        self.rightView.centerY = self.height / 2;
        [self addSubview:self.rightView];
        [self.rightTitleLabel removeFromSuperview];
    } else {
        self.rightTitleLabel.width = [self.rightTitleLabel.text widthWithFont:self.rightTitleLabel.font];
        self.rightTitleLabel.right = self.accessoryView.left - 10.0f;
    }
    
}

@end













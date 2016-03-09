//
//  PeerInfoTableViewCell.m
//  Peer
//
//  Created by jason on 3/6/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "PeerInfoTableViewCell.h"
#import "NSString+Size.h"

@implementation PeerInfoTableViewCell


- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0, 0, self.height)];
        _leftTitleLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        _leftTitleLabel.textColor = [UIColor colorWithHex:0x808080];
        [self addSubview:_leftTitleLabel];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
        _rightTitleLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        _rightTitleLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
        [self addSubview:_rightTitleLabel];
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
        self.needAccessoryView = YES;
    }
    return self;
}

- (void)layoutSubviews {
    
    if (_leftTitleLabel) {
        self.leftTitleLabel.width  = [self.leftTitleLabel.text widthWithFont:self.leftTitleLabel.font];
        self.leftTitleLabel.height = self.height;
    }
    
    if (self.needAccessoryView && (!_accessoryView || ![self.subviews containsObject:_accessoryView])) {
        [self addSubview:self.accessoryView];
    }
    
    if (self.needBottomLine && (![self viewWithTag:UIViewBorderBottomLine])) {
        [self addLineWithFrame:CGRectMake(self.leftTitleLabel.left, self.height - 0.5, self.width - self.leftTitleLabel.left * 2, 0.5) border:UIViewBorderBottomLine];
    }
    
    if (self.rightView && ![self.subviews containsObject:self.rightView]) {
        self.rightView.right   = self.accessoryView.left - 10.0f;
        self.rightView.centerY = self.height / 2;
        [self addSubview:self.rightView];
        [self.rightTitleLabel removeFromSuperview];
    } else {
        self.rightTitleLabel.width = [self.rightTitleLabel.text widthWithFont:self.rightTitleLabel.font];
        self.rightTitleLabel.right = self.accessoryView.left - 10.0f;
        self.rightTitleLabel.height = self.height;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

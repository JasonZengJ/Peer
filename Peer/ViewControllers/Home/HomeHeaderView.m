//
//  HomeHeaderView.m
//  Peer
//
//  Created by jason on 15/10/18.
//  Copyright © 2015年 peers. All rights reserved.
//

#import "HomeHeaderView.h"
#import "NSString+Size.h"

#define HighlightColor [UIColor colorWithHex:0xffb800 alpha:1.0]
#define DefaultColor   [UIColor colorWithHex:0x808080 alpha:1.0]
#define DefaultFont    15.0

@interface HomeHeaderView ()

@property(nonatomic) UILabel *recomandLabel;
@property(nonatomic) UIView  *bottomLineView;
@property(nonatomic) UILabel *followedLabel;
@property(nonatomic) UIImageView *messagesImageView;
@property(nonatomic) CurrentMoments currentMoments;


@end

@implementation HomeHeaderView


- (UILabel *)recomandLabel {
    if (!_recomandLabel) {
        _recomandLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 0,0)];
        _recomandLabel.text = @"推荐";
        _recomandLabel.font = [UIFont boldSystemFontOfSize:ConvertiPhone5Or6pSize(DefaultFont)];
        _recomandLabel.textColor = HighlightColor;
        [_recomandLabel sizeToFit];
//        _recomandLabel.width = [self.recomandLabel.text widthWithFont:self.recomandLabel.font];
    }
    return _recomandLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.recomandLabel.bottom + 3, ConvertiPhone5Or6pSize(35), ConvertiPhone5Or6pSize(3))];
        _bottomLineView.backgroundColor = HighlightColor;
        _bottomLineView.centerX = _recomandLabel.centerX;
    }
    return _bottomLineView;
}

- (UILabel *)followedLabel {
    if (!_followedLabel) {
        _followedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.recomandLabel.right + 25, self.recomandLabel.top, self.recomandLabel.width, self.recomandLabel.height)];
        _followedLabel.text = @"关注";
        _followedLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(DefaultFont)];
        _followedLabel.textColor = DefaultColor;
        [_followedLabel sizeToFit];
    }
    return _followedLabel;
}

- (UIImageView *)messagesImageView {
    if (!_messagesImageView) {
        _messagesImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(25.0f), ConvertiPhone5Or6pSize(25.0f))];
        _messagesImageView.image   = [UIImage imageNamed:@"HomeMessages"];
        _messagesImageView.left    = self.width - _messagesImageView.width - 20;
        _messagesImageView.centerY = self.recomandLabel.centerY;
    }
    return _messagesImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    
    self.currentMoments = CurrentMomentsRecomand;
    
    [self addSubview:self.recomandLabel];
    [self addSubview:self.bottomLineView];
    [self addSubview:self.followedLabel];
    [self addSubview:self.messagesImageView];
    
}


@end

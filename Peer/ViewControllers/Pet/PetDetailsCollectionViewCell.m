//
//  PetDetailsCollectionViewCell.m
//  Peer
//
//  Created by jason on 10/29/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PetDetailsCollectionViewCell.h"
#import "MomentModel.h"
#import "PeerDateFormatter.h"
#import "NSString+Size.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PetDetailsCollectionViewCell ()

@property(nonatomic) UILabel *monthLabel;
@property(nonatomic) UILabel *daysLabel;
@property(nonatomic) UIImageView *weatherImageView;
@property(nonatomic) UIImageView *dateWeatherView;

@property(nonatomic) UIImageView *photoImageView;
@property(nonatomic) UIImageView *photoBackgroundImageView;

@property(nonatomic) UILabel *commentTitleLabel;
@property(nonatomic) UILabel *commentAmountLabel;
@property(nonatomic) UILabel *likeTitleLabel;
@property(nonatomic) UILabel *likeAmountLabel;

@end

@implementation PetDetailsCollectionViewCell


- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 0, ConvertiPhone5Or6pSize(14))];
        _monthLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(10)];
        _monthLabel.textColor = [UIColor whiteColor];
    }
    return _monthLabel;
}

- (UILabel *)daysLabel {
    if (!_daysLabel) {
        _daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ConvertiPhone5Or6pSize(13), 0, ConvertiPhone5Or6pSize(15))];
        _daysLabel.font = [UIFont boldSystemFontOfSize:ConvertiPhone5Or6pSize(14)];
        _daysLabel.textColor = [UIColor whiteColor];
    }
    return _daysLabel;
}

- (UIImageView *)weatherImageView {
    if (!_weatherImageView) {
        _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, ConvertiPhone5Or6pSize(23), ConvertiPhone5Or6pSize(23))];
        _weatherImageView.centerY = self.dateWeatherView.height / 2;
    }
    return _weatherImageView;
}

- (UIImageView *)dateWeatherView {
    if (!_dateWeatherView) {
        _dateWeatherView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, ConvertiPhone5Or6pSize(60), ConvertiPhone5Or6pSize(30))];
        _dateWeatherView.left = self.photoImageView.width - _dateWeatherView.width;
        _dateWeatherView.image = [UIImage imageNamed:@"HomeWeatherDateBg"];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, _dateWeatherView.width, _dateWeatherView.height);
        gradientLayer.startPoint   = CGPointMake(0, 0);
        gradientLayer.endPoint     = CGPointMake(1, 0);
        gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHex:0x000000 alpha:0.0].CGColor,
                                (id)[UIColor blackColor].CGColor,nil];
        [_dateWeatherView.layer addSublayer:gradientLayer];
        
    }
    return _dateWeatherView;
    
}

- (UIImageView *)photoImageView {
    
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, self.width - 8 , (self.width - 8) * 1.2)];
        //        _photoImageView.autoresizingMask  = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _photoImageView;
}

- (UIImageView *)photoBackgroundImageView {
    if (!_photoBackgroundImageView) {
        _photoBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.photoImageView.width + 8, self.photoImageView.height + 8)];
        _photoBackgroundImageView.layer.borderWidth = 0.5;
        _photoBackgroundImageView.layer.borderColor = [UIColor colorWithHex:0xe4e4e4 alpha:1.0].CGColor;
        _photoBackgroundImageView.backgroundColor = [UIColor whiteColor];
    }
    return _photoBackgroundImageView;
}

- (UILabel *)commentTitleLabel {
    if (!_commentTitleLabel) {
        _commentTitleLabel = [self labelWithText:NSLocalizedString(@"PetDetailsComments", nil)];
        _commentTitleLabel.right = self.width / 2 + 10.0f;
    }
    return _commentTitleLabel;
}

- (UILabel *)commentAmountLabel {
    if (!_commentAmountLabel) {
        _commentAmountLabel = [self labelWithText:@"0"];
    }
    return _commentAmountLabel;
    
}

- (UILabel *)likeTitleLabel {
    if (!_likeTitleLabel) {
        _likeTitleLabel = [self labelWithText:NSLocalizedString(@"PetDetailsLikes", nil)];
        _likeTitleLabel.right = self.width - 10.0f;
    }
    return _likeTitleLabel;
}

- (UILabel *)likeAmountLabel {
    if (!_likeAmountLabel) {
        _likeAmountLabel = [self labelWithText:@"0"];
    }
    return _likeAmountLabel;
}

- (UILabel *)labelWithText:(NSString *)text {
    
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20.0f)];
    label.text      = text;
    label.font      = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(13.0f)];
    label.width     = [text widthWithFont:label.font];
    label.textColor = [UIColor colorWithHex:0x4c4c4c alpha:1.0];
    label.top       = self.photoBackgroundImageView.bottom + 15.0f;
    
    return label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.photoBackgroundImageView];
    [self.contentView addSubview:self.daysLabel];
    [self.contentView addSubview:self.commentTitleLabel];
    [self.contentView addSubview:self.commentAmountLabel];
    [self.contentView addSubview:self.likeTitleLabel];
    [self.contentView addSubview:self.likeAmountLabel];
    
    [self.photoBackgroundImageView addSubview:self.photoImageView];
    
    [self.photoImageView addSubview:self.dateWeatherView];
    
    [self.dateWeatherView addSubview:self.weatherImageView];
    [self.dateWeatherView addSubview:self.monthLabel];
    [self.dateWeatherView addSubview:self.daysLabel];
}

- (void)configureWithMoments:(MomentModel *)momentModel {
    
    [[PeerDateFormatter shareInstance] formateDateString:momentModel.createdAt];
    NSInteger month = [[PeerDateFormatter shareInstance] month];
    NSInteger day   = [[PeerDateFormatter shareInstance] day];
    
    self.weatherImageView.image = [UIImage imageNamed:momentModel.weather];
    self.monthLabel.text  = [NSString stringWithFormat:@"%ld月",month];
    self.monthLabel.width = [self.monthLabel.text widthWithFont:self.monthLabel.font];
    self.monthLabel.left  = self.weatherImageView.right + 10;
    
    self.daysLabel.text  = [NSString stringWithFormat:@"%ld",day];
    self.daysLabel.width = [self.daysLabel.text widthWithFont:self.daysLabel.font];
    self.daysLabel.left  = self.monthLabel.left;
    
    if ([momentModel.momentType integerValue] == 1) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:momentModel.momentTargetUrl]];
    } else {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:momentModel.momentThumbnailUrl]];
    }
    
    self.commentAmountLabel.text  = momentModel.commentsAmount.stringValue;
    self.commentAmountLabel.right = self.commentTitleLabel.left - 5;
    
    self.likeAmountLabel.text    = momentModel.likeAmount.stringValue;
    self.likeAmountLabel.right   = self.likeTitleLabel.left - 5;
    
}

@end

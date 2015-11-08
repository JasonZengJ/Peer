//
//  CardCollectionViewCell.m
//  Peer
//
//  Created by jason on 10/16/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "CardCollectionViewCell.h"
#import "MomentModel.h"
#import "UIColor+Hex.h"
#import "UIView+Layout.h"
#import "LayoutUtil.h"
#import "NSString+Size.h"
#import "PeerDateFormatter.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <POP.h>

@interface CardCollectionViewCell ()

@property(nonatomic) UILabel *monthLabel;
@property(nonatomic) UILabel *daysLabel;
@property(nonatomic) UIImageView *weatherImageView;
@property(nonatomic) UIImageView *dateWeatherView;

@property(nonatomic) UIImageView *photoImageView;
@property(nonatomic) UIImageView *petsAvatarImageView;
@property(nonatomic) UIView      *petsAvatarImageBgView;

@property(nonatomic) UILabel     *detailsLabel;
@property(nonatomic) UILabel     *contentLabel;

@property(nonatomic) UIView      *bottomView;
@property(nonatomic) UIImageView *locationIcon;
@property(nonatomic) UILabel     *locationLabel;

@property(nonatomic) UIImageView *commentsIcon;
@property(nonatomic) UILabel     *commentsAmountLabel;
@property(nonatomic) UIButton    *likeButton;

@property(nonatomic,assign) BOOL isLiked;

@end

@implementation CardCollectionViewCell


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
        _dateWeatherView.left = self.width - _dateWeatherView.width;
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
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 1.2)];
//        _photoImageView.autoresizingMask  = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _photoImageView;
}

- (UIImageView *)petsAvatarImageView {
    if (!_petsAvatarImageView) {
        _petsAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(55), ConvertiPhone5Or6pSize(55))];
        _petsAvatarImageView.backgroundColor =[UIColor clearColor];
        _petsAvatarImageView.clipsToBounds = YES;
        _petsAvatarImageView.centerX = self.petsAvatarImageBgView.width / 2;
        _petsAvatarImageView.centerY = self.petsAvatarImageBgView.height / 2;
        _petsAvatarImageView.layer.cornerRadius = _petsAvatarImageView.width / 2;
        
    }
    
    return _petsAvatarImageView;
}

- (UIView *)petsAvatarImageBgView {
    if (!_petsAvatarImageBgView) {
        _petsAvatarImageBgView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(59), ConvertiPhone5Or6pSize(59))];
        _petsAvatarImageBgView.backgroundColor = [UIColor whiteColor];
        _petsAvatarImageBgView.centerX = self.photoImageView.centerX;
        _petsAvatarImageBgView.centerY = self.photoImageView.bottom;
        _petsAvatarImageBgView.layer.cornerRadius = _petsAvatarImageBgView.width / 2;
        [_petsAvatarImageBgView addTapGestureWithTarget:self action:@selector(tapPetAvatar)];
    }
    return _petsAvatarImageBgView;
}


- (UILabel *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.petsAvatarImageBgView.bottom + 3, self.width, ConvertToiPhone6XYZ(20))];
        _detailsLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12)];
        _detailsLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1.0];
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.backgroundColor = [UIColor clearColor];
    }
    return _detailsLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.detailsLabel.bottom + 10, self.width - 20, ConvertToiPhone6XYZ(20))];
        _contentLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(15)];
        _contentLabel.textColor = [UIColor colorWithHex:0x4c4c4c alpha:1.0];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(10,  self.height - ConvertiPhone5Or6pSize(35), self.width - 20, ConvertiPhone5Or6pSize(35.0f))];
        [_bottomView addLineWithFrame:CGRectMake(0, 0 , _bottomView.width, 0.5) border:UIViewBorderBottomLine];
    }
    return _bottomView;
}

- (UIImageView *)locationIcon {
    if (!_locationIcon) {
        _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomeLocation"]];
        _locationIcon.width  = ConvertiPhone5Or6pSize(15.0);
        _locationIcon.height = ConvertiPhone5Or6pSize(15.0);
        _locationIcon.centerY = self.bottomView.height / 2;
    }
    return _locationIcon;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.locationIcon.right + 3, 0, 0, self.bottomView.height)];
        _locationLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12)];
        _locationLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1.0];
    }
    return _locationLabel;
}

- (UIImageView *)commentsIcon {
    if (!_commentsIcon) {
        _commentsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomeComments"]];
        _commentsIcon.width  = ConvertiPhone5Or6pSize(15.0);
        _commentsIcon.height = ConvertiPhone5Or6pSize(15.0);
        _commentsIcon.centerY = self.locationIcon.centerY;
    }
    return _commentsIcon;
}

- (UILabel *)commentsAmountLabel {
    if (!_commentsAmountLabel) {
        _commentsAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.commentsIcon.right, 0, 140, self.bottomView.height)];
        _commentsAmountLabel.font = self.locationLabel.font;
        _commentsAmountLabel.text = @"0";
        _commentsAmountLabel.textColor = self.locationLabel.textColor;
        
    }
    return _commentsAmountLabel;
}

- (UIButton *)likeButton {
    if (!_likeButton) {
        _likeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bottomView.width - ConvertiPhone5Or6pSize(25), 0, ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25))];
        _likeButton.centerY = self.bottomView.height / 2;
        _likeButton.userInteractionEnabled = YES;
//        [_likeButton addTapGestureWithTarget:self action:@selector(tapLikePets)];
        [_likeButton addTarget:self action:@selector(likeButtonTouchDown) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        [_likeButton addTarget:self action:@selector(likeButtonTouchUp) forControlEvents:UIControlEventTouchUpInside];
        [_likeButton addTarget:self action:@selector(likeButtonDragExit) forControlEvents:UIControlEventTouchDragExit];
    }
    return _likeButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowColor   = [UIColor blackColor].CGColor;
    self.layer.shadowOffset  = CGSizeMake(0, 0);
    self.layer.cornerRadius  = 6;
    
    self.contentView.layer.cornerRadius = 6;
    self.contentView.clipsToBounds = YES;
    
    [self.contentView addSubview:self.photoImageView];
    [self.contentView addSubview:self.petsAvatarImageBgView];
    [self.contentView addSubview:self.detailsLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.daysLabel];
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.dateWeatherView];
    
    [self.petsAvatarImageBgView addSubview:self.petsAvatarImageView];
    
    [self.dateWeatherView addSubview:self.weatherImageView];
    [self.dateWeatherView addSubview:self.monthLabel];
    [self.dateWeatherView addSubview:self.daysLabel];
    
    [self.bottomView addSubview:self.locationIcon];
    [self.bottomView addSubview:self.locationLabel];
    [self.bottomView addSubview:self.commentsIcon];
    [self.bottomView addSubview:self.commentsAmountLabel];
    [self.bottomView addSubview:self.likeButton];
    
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
    }
    
    [self.petsAvatarImageView sd_setImageWithURL:[NSURL URLWithString:momentModel.pet.petsAvatar]];
    
    NSString  *sex = momentModel.pet.petsSex.integerValue == 1 ? @"DD" : @"MM";
    self.detailsLabel.text   = [NSString stringWithFormat:@"%@ - %@ - %@个月",momentModel.pet.petsName,sex,momentModel.pet.petsMonth];
    
    self.contentLabel.text   = momentModel.momentDescription;
    self.contentLabel.height = [self.contentLabel.text sizeWithFont:self.contentLabel.font constraintsSize:CGSizeMake(self.contentLabel.width, 45.0f)].height;
    
    self.locationLabel.text  = [NSString stringWithFormat:@"%@ - %@",momentModel.city,momentModel.area];
    self.locationLabel.width = [self.locationLabel.text sizeWithFont:self.locationLabel.font constraintsSize:CGSizeMake(self.width, self.bottomView.height)].width;
    
    self.commentsIcon.left = self.locationLabel.right + 10;
    
    self.commentsAmountLabel.text = [momentModel.commentsAmount stringValue];
    self.commentsAmountLabel.left = self.commentsIcon.right + 3;
    
    [self.likeButton setBackgroundImage:[UIImage imageNamed:@"HomeUnlikeHeart"] forState:UIControlStateNormal];
    [self.likeButton setBackgroundImage:[UIImage imageNamed:@"HomeUnlikeHeart"] forState:UIControlStateHighlighted];
    
    
}

- (void)layoutSubviews {
    
    self.bottomView.top = self.height - self.bottomView.height;
    
}

- (void)tapPetAvatar {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapPetAvatarWithIndex:)]) {
        [self.delegate tapPetAvatarWithIndex:self.index];
    }
    
}

- (void)likeButtonTouchDown {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.7f, 0.7f)];
    [self.likeButton.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)likeButtonTouchUp {
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    if (!self.isLiked) {
        self.isLiked = YES;
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"HomeLikeHeart"] forState:UIControlStateNormal];
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"HomeLikeHeart"] forState:UIControlStateHighlighted];
        scaleAnimation.springBounciness = 20.0f;
        
    } else {
        self.isLiked = NO;
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"HomeUnlikeHeart"] forState:UIControlStateNormal];
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"HomeUnlikeHeart"] forState:UIControlStateHighlighted];
        scaleAnimation.springBounciness = 8.0f;
    }
    [self.likeButton.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)likeButtonDragExit {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.likeButton.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}


- (void)tapLikePets {
    
    if (!self.isLiked) {
        self.isLiked = YES;
//        self.likeButton.image = [UIImage imageNamed:@"HomeLikeHeart"];
    } else {
        self.isLiked = NO;
//        self.likeButton.image = [UIImage imageNamed:@"HomeUnlikeHeart"];
    }
    
}

- (CGFloat)heightWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font {
    
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
}

@end

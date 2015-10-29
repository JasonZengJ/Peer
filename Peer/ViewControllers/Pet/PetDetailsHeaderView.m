//
//  PetDetailsHeaderView.m
//  Peer
//
//  Created by jason on 10/29/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PetDetailsHeaderView.h"
#import "PetsModel.h"
#import <UIImageView+AFNetworking.h>

@interface PetDetailsHeaderView ()

@property(nonatomic) UIImageView *petsAvatarImageView;
@property(nonatomic) UILabel     *detailsLabel;
@property(nonatomic) UILabel     *recordedDaysLabel;
@property(nonatomic) UIButton    *followPetButton;

@property(nonatomic) UIView      *petStatisticsView;
@property(nonatomic) UILabel     *petPhotosTitleLabel;
@property(nonatomic) UILabel     *petPhotosAmountLabel;
@property(nonatomic) UILabel     *petFollowersTitleLabel;
@property(nonatomic) UILabel     *petFollowersAmountLabel;
@property(nonatomic) UILabel     *petLikesTitleLabel;
@property(nonatomic) UILabel     *petLikesAmountLabel;




@end

@implementation PetDetailsHeaderView

- (UIImageView *)petsAvatarImageView {
    if (!_petsAvatarImageView) {
        _petsAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 83.0f, ConvertiPhone5Or6pSize(80.0), ConvertiPhone5Or6pSize(80.0))];
        _petsAvatarImageView.backgroundColor =[UIColor clearColor];
        _petsAvatarImageView.clipsToBounds = YES;
        _petsAvatarImageView.layer.cornerRadius = _petsAvatarImageView.width / 2;
        _petsAvatarImageView.centerX = self.width / 2;
    }
    
    return _petsAvatarImageView;
}

- (UILabel *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.petsAvatarImageView.bottom + 16, self.width, ConvertToiPhone6XYZ(20))];
        _detailsLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(15)];
        _detailsLabel.textColor = [UIColor colorWithHex:0x4c4c4c alpha:1.0];
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailsLabel;
}

- (UILabel *)recordedDaysLabel {
    if (!_recordedDaysLabel) {
        _recordedDaysLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.detailsLabel.bottom + 6, self.width, ConvertiPhone5Or6pSize(20))];
        _recordedDaysLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12.0f)];
        _recordedDaysLabel.textColor = [UIColor colorWithHex:0x808080 alpha:1.0];
        _recordedDaysLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _recordedDaysLabel;
}

- (UIButton *)followPetButton {
    if (!_followPetButton) {
        _followPetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.recordedDaysLabel.bottom + 15, ConvertiPhone5Or6pSize(80.0f), ConvertiPhone5Or6pSize(30.0f))];
        [_followPetButton setBackgroundImage:[UIImage imageNamed:@"PetsDetailsFollow"] forState:UIControlStateNormal];
        [_followPetButton addTarget:self action:@selector(followPet) forControlEvents:UIControlEventTouchUpInside];
        _followPetButton.centerX = self.width / 2;
    }
    return _followPetButton;
}

- (UIView *)petStatisticsView {
    if (!_petStatisticsView) {
        _petStatisticsView = [[UIView alloc] initWithFrame:CGRectMake(10, self.followPetButton.bottom + 25.0f, self.width - 20.0f, ConvertiPhone5Or6pSize(60.0f))];
        _petStatisticsView.layer.cornerRadius = 5;
        _petStatisticsView.layer.borderWidth  = 0.5;
        _petStatisticsView.layer.borderColor  = [UIColor colorWithHex:0xE4E4E4 alpha:1.0].CGColor;
        _petStatisticsView.backgroundColor    = [UIColor whiteColor];
        
        CGFloat lineGap = _petStatisticsView.width / 3;
        [_petStatisticsView addLineWithFrame:CGRectMake(lineGap, (_petStatisticsView.height - ConvertiPhone5Or6pSize(33.0f)) / 2, 0.5,ConvertiPhone5Or6pSize(33.0f)) border:UIViewBorderLeftLine];
        [_petStatisticsView addLineWithFrame:CGRectMake(lineGap * 2, (_petStatisticsView.height - ConvertiPhone5Or6pSize(33.0f)) / 2, 0.5,ConvertiPhone5Or6pSize(33.0f)) border:UIViewBorderRightLine];
        
    }
    return _petStatisticsView;
}

- (UILabel *)petPhotosTitleLabel {
    if (!_petPhotosTitleLabel) {
        _petPhotosTitleLabel = [self titleLabelWithText:@"图片" left:0];
    }
    return _petPhotosTitleLabel;
}

- (UILabel *)petPhotosAmountLabel {
    if (!_petPhotosAmountLabel) {
        _petPhotosAmountLabel = [self amountLabelWithLeft:self.petPhotosTitleLabel.left];
    }
    return _petPhotosAmountLabel;
}

- (UILabel *)petFollowersTitleLabel {
    if (!_petFollowersTitleLabel) {
        _petFollowersTitleLabel = [self titleLabelWithText:@"粉丝" left:self.petStatisticsView.width / 3];
    }
    return _petFollowersTitleLabel;
}

- (UILabel *)petFollowersAmountLabel {
    if (!_petFollowersAmountLabel) {
        _petFollowersAmountLabel = [self amountLabelWithLeft:self.petFollowersTitleLabel.left];
    }
    return _petFollowersAmountLabel;
}

- (UILabel *)petLikesTitleLabel {
    if (!_petLikesTitleLabel) {
        _petLikesTitleLabel = [self titleLabelWithText:@"赞" left:self.petStatisticsView.width * 2 / 3];
    }
    return _petLikesTitleLabel;
}

- (UILabel *)petLikesAmountLabel {
    if (!_petLikesAmountLabel) {
        _petLikesAmountLabel = [self amountLabelWithLeft:self.petLikesTitleLabel.left];
    }
    return _petLikesAmountLabel;
}


- (UILabel *)amountLabelWithLeft:(CGFloat)left {
    UILabel *label = [self titleLabelWithText:@"0" left:left];
    label.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(14.0f)];
    label.top  = self.petPhotosTitleLabel.bottom;
    
    return label;
}

- (UILabel *)titleLabelWithText:(NSString *)text left:(CGFloat)left {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, 8, self.petStatisticsView.width / 3, ConvertiPhone5Or6pSize(22.0f))];
    label.text = text;
    label.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12.0f)];
    label.textColor = [UIColor colorWithHex:0x808080 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    
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
    
    [self addSubview:self.petsAvatarImageView];
    [self addSubview:self.detailsLabel];
    [self addSubview:self.recordedDaysLabel];
    [self addSubview:self.followPetButton];
    [self addSubview:self.petStatisticsView];
    
    [self.petStatisticsView addSubview:self.petPhotosTitleLabel];
    [self.petStatisticsView addSubview:self.petPhotosAmountLabel];
    [self.petStatisticsView addSubview:self.petFollowersTitleLabel];
    [self.petStatisticsView addSubview:self.petFollowersAmountLabel];
    [self.petStatisticsView addSubview:self.petLikesTitleLabel];
    [self.petStatisticsView addSubview:self.petLikesAmountLabel];
    
    
    self.height = self.petStatisticsView.bottom;
}


- (void)configureWithPetsModel:(PetsModel *)pet {
    
    [self.petsAvatarImageView setImageWithURL:[NSURL URLWithString:pet.petsAvatar]];
    NSString  *sex = pet.petsSex.integerValue == 1 ? @"DD" : @"MM";
    self.detailsLabel.text      = [NSString stringWithFormat:@"%@ - %@ - %@个月",pet.petsName,sex,pet.petsMonth];
    
    self.recordedDaysLabel.text = [NSString stringWithFormat:@"记录第%d天",33];
}

- (void)followPet {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(followPet)]) {
        [self.delegate followPet];
    }
    
}

@end









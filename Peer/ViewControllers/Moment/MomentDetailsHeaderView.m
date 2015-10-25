//
//  MomentDetailsHeaderView.m
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentDetailsHeaderView.h"
#import "MomentModel.h"
#import <UIImageView+AFNetworking.h>

@interface MomentDetailsHeaderView ()


@property(nonatomic) UIImageView *photoImageView;

@property(nonatomic) UIImageView *petsAvatarImageView;

@property(nonatomic) UILabel *detailsLabel;



@end

@implementation MomentDetailsHeaderView

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 1.2)];
    }
    return _photoImageView;
}


- (UIImageView *)petsAvatarImageView {
    if (!_petsAvatarImageView) {
        _petsAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(55), ConvertiPhone5Or6pSize(55))];
        _petsAvatarImageView.backgroundColor =[UIColor clearColor];
        _petsAvatarImageView.clipsToBounds = YES;
        _petsAvatarImageView.centerX = self.photoImageView.centerX;
        _petsAvatarImageView.centerY = self.photoImageView.bottom;
        _petsAvatarImageView.layer.cornerRadius = _petsAvatarImageView.width / 2;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(59), ConvertiPhone5Or6pSize(59))];
        view.backgroundColor = [UIColor whiteColor];
        view.center = _petsAvatarImageView.center;
        view.layer.cornerRadius = view.width / 2;
        [self addSubview:view];
    }
    
    return _petsAvatarImageView;
}


- (UILabel *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.petsAvatarImageView.bottom + 3, self.width, ConvertToiPhone6XYZ(20))];
        _detailsLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12)];
        _detailsLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1.0];
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.backgroundColor = [UIColor clearColor];
    }
    return _detailsLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.photoImageView];
    [self addSubview:self.petsAvatarImageView];
}

- (void)configureWithMomentModel:(MomentModel *)momentModel {
    
    if ([momentModel.momentType integerValue] == 1) {
        [self.photoImageView setImageWithURL:[NSURL URLWithString:momentModel.momentTargetUrl]];
    }
    self.petsAvatarImageView.image = [UIImage imageNamed:@"avatar"];
    
    
}

@end

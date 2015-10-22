//
//  MomentDetailsHeaderView.m
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentDetailsHeaderView.h"
#import "MomentModel.h"

@interface MomentDetailsHeaderView ()


@property(nonatomic) UIImageView *petAvatarImageView;


@end

@implementation MomentDetailsHeaderView


- (UIImageView *)petAvatarImageView {
    if (!_petAvatarImageView) {
        _petAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 1.2)];
    }
    return _petAvatarImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.petAvatarImageView];
}

- (void)configureWithMomentModel:(MomentModel *)momentModel {
    
    
    
}

@end

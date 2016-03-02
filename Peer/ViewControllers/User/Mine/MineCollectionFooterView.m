//
//  MineCollectionFooterView.m
//  Peer
//
//  Created by jason on 1/23/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "MineCollectionFooterView.h"
#import "NSString+Size.h"

@interface MineCollectionFooterView ()

@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIImageView *addPeerImageView;
@property(nonatomic,strong)UILabel *addPeerLabel;

@end

@implementation MineCollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.addPeerImageView];
    [self.contentView addSubview:self.addPeerLabel];
    
}

- (void)layoutSubviews {
    
    self.addPeerImageView.left = (self.contentView.width - 20.0f - self.addPeerLabel.width - self.addPeerImageView.width) / 2.0f;
    self.addPeerImageView.centerY = self.contentView.height / 2.0f;
    
    self.addPeerLabel.height   = self.contentView.height;
    self.addPeerLabel.left     = self.addPeerImageView.right + 20.0f;
    
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20.0f, 50)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.shadowColor   = [UIColor blackColor].CGColor;
        _contentView.layer.shadowOffset  = CGSizeMake(0.0, 0.0);
        _contentView.layer.shadowOpacity = 0.1;
        _contentView.layer.cornerRadius  = 3;
    }
    return _contentView;
}

- (UIImageView *)addPeerImageView {
    if (!_addPeerImageView) {
        _addPeerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30.0f, 30.0f)];
        _addPeerImageView.image = [UIImage imageNamed:@"MineAddPeer"];
    }
    return _addPeerImageView;
}

- (UILabel *)addPeerLabel {
    if (!_addPeerLabel) {
        _addPeerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _addPeerLabel.font = [UIFont systemFontOfSize:14.0f];
        _addPeerLabel.text  = @"添加Peer";
        _addPeerLabel.width = [_addPeerLabel.text widthWithFont:_addPeerLabel.font];
        _addPeerLabel.textColor = [UIColor colorWithHex:0x999999];
        
        
    }
    return _addPeerLabel;
}


@end

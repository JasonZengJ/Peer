//
//  RegisterInfoView.m
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RegisterInfoView.h"
#import "RegisterInfoViewCell.h"
#import "UIImage+Color.h"
#import "NSString+Size.h"


@interface RegisterInfoView ()

@property(nonatomic) UIView *baseInfoView;
@property(nonatomic) RegisterInfoViewCell *nicknameCell;
@property(nonatomic) RegisterInfoViewCell *sexCell;
@property(nonatomic) RegisterInfoViewCell *ageCell;
@property(nonatomic) RegisterInfoViewCell *areaCell;
@property(nonatomic) UIView   *userDescriptionView;
@property(nonatomic) UILabel  *userDescriptionTitleLabel;
@property(nonatomic) UILabel  *userDescriptionLabel;
@property(nonatomic) UIButton *doneButton;




@end

@implementation RegisterInfoView

- (UIImageView *)userAvatarImageView {
    if (!_userAvatarImageView) {
        _userAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90.0f, ConvertiPhone5Or6pSize(100.0f), ConvertiPhone5Or6pSize(100.0f))];
        _userAvatarImageView.image = [UIImage imageNamed:@"UserRegisterInfoAvatar"];
        _userAvatarImageView.centerX = self.width / 2;
        _userAvatarImageView.layer.cornerRadius  = _userAvatarImageView.height / 2;
        _userAvatarImageView.layer.masksToBounds = YES;
    }
    return _userAvatarImageView;
}

- (UIView *)baseInfoView {
    if (!_baseInfoView) {
        _baseInfoView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, self.userAvatarImageView.bottom + 35.0f, self.width - 20.0f, ConvertiPhone5Or6pSize(180.0f))];
        [self configureInfoBgView:_baseInfoView];
    }
    return _baseInfoView;
}

- (RegisterInfoViewCell *)nicknameCell {
    if (!_nicknameCell) {
        _nicknameCell = [self registerInfoCellWithLeftTitle:NSLocalizedString(@"RegisterNickname", nil)];
        _nicknameCell.tag = RegisterInfoNickname;
        [_nicknameCell addLineWithFrame:CGRectMake(10.0f, _nicknameCell.height - 0.5, _nicknameCell.width - 20.0f,0.5) border:UIViewBorderBottomLine];
        
    }
    return _nicknameCell;
}

- (RegisterInfoViewCell *)sexCell {
    if (!_sexCell) {
        _sexCell = [self registerInfoCellWithLeftTitle:NSLocalizedString(@"RegisterSex", nil)];
        _sexCell.tag = RegisterInfoSex;
        _sexCell.top = self.nicknameCell.bottom;
        _sexCell.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserRegisterInfoBoy"]];
        [_sexCell addLineWithFrame:CGRectMake(10.0f, _nicknameCell.height - 0.5, _nicknameCell.width - 20.0f, 0.5) border:UIViewBorderBottomLine];
        
    }
    return _sexCell;
}

- (RegisterInfoViewCell *)ageCell {
    if (!_ageCell) {
        _ageCell = [self registerInfoCellWithLeftTitle:NSLocalizedString(@"RegisterAge", nil)];
        _ageCell.tag = RegisterInfoAge;
        _ageCell.top = self.sexCell.bottom;
        [_ageCell addLineWithFrame:CGRectMake(10.0f, _nicknameCell.height - 0.5, _nicknameCell.width - 20.0f, 0.5) border:UIViewBorderBottomLine];
    }
    return _ageCell;
}

- (RegisterInfoViewCell *)areaCell {
    if (!_areaCell) {
        _areaCell = [self registerInfoCellWithLeftTitle:NSLocalizedString(@"RegisterArea", nil)];
        _areaCell.tag = RegisterInfoArea;
        _areaCell.top = self.ageCell.bottom;
    }
    return _areaCell;
}

- (UIView *)userDescriptionView {
    if (!_userDescriptionView) {
        _userDescriptionView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, self.baseInfoView.bottom + 15.0f, self.width - 20.0f, ConvertiPhone5Or6pSize(80.0f))];
        [self configureInfoBgView:_userDescriptionView];
        _userDescriptionView.tag = RegisterInfoDescription;
        [_userDescriptionView addTapGestureWithTarget:self action:@selector(tapCell:)];
        
    }
    return _userDescriptionView;
}

- (UILabel *)userDescriptionTitleLabel {
    if (!_userDescriptionTitleLabel) {
        _userDescriptionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0, self.userDescriptionView.width - 20.0f, ConvertiPhone5Or6pSize(35.0f))];
        _userDescriptionTitleLabel.text = NSLocalizedString(@"RegisterIntroduction", nil);
        _userDescriptionTitleLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        _userDescriptionTitleLabel.textColor = [UIColor colorWithHex:0x808080];
        [_userDescriptionTitleLabel addLineWithFrame:CGRectMake(0, _userDescriptionTitleLabel.height - 0.5, _userDescriptionTitleLabel.width, 0.5) border:UIViewBorderBottomLine];
    }
    return _userDescriptionTitleLabel;
}

- (UILabel *)userDescriptionLabel {
    if (!_userDescriptionLabel) {
        _userDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, self.userDescriptionTitleLabel.bottom, self.userDescriptionView.width - 20.0f, ConvertiPhone5Or6pSize(45.0f))];
        _userDescriptionLabel.text = NSLocalizedString(@"RegisterIntroductionPlaceHolder", nil);
        _userDescriptionLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        _userDescriptionLabel.textColor = [UIColor colorWithHex:0xe5e5e5];
        _userDescriptionLabel.numberOfLines = 0;
        
        
    }
    return _userDescriptionLabel;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 0, self.width - 20.0f, ConvertiPhone5Or6pSize(45.0f))];
        _doneButton.bottom = self.bottom - 10.0f;
        _doneButton.layer.cornerRadius  = 3;
        _doneButton.layer.masksToBounds = YES;
        [_doneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
        [_doneButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xffb800]] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (void)configureInfoBgView:(UIView *)view {
    view.layer.cornerRadius  = 3;
    view.layer.shadowOpacity = 0.1;
    view.layer.shadowOffset  = CGSizeMake(0, 0);
    view.layer.shadowColor   = [UIColor blackColor].CGColor;
    view.backgroundColor     = [UIColor whiteColor];
 
}

- (RegisterInfoViewCell *)registerInfoCellWithLeftTitle:(NSString *)leftTitle  {
    
    RegisterInfoViewCell *cell = [[RegisterInfoViewCell alloc] initWithFrame:CGRectMake(0, 0, self.baseInfoView.width, ConvertiPhone5Or6pSize(45.0f))];
    cell.leftTitleLabel.text  = leftTitle;
    [cell addTapGestureWithTarget:self action:@selector(tapCell:)];
    
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self addSubview:self.userAvatarImageView];
    [self addSubview:self.baseInfoView];
    [self addSubview:self.userDescriptionView];
    [self addSubview:self.doneButton];
    
    [self.baseInfoView addSubview:self.nicknameCell];
    [self.baseInfoView addSubview:self.sexCell];
    [self.baseInfoView addSubview:self.ageCell];
    [self.baseInfoView addSubview:self.areaCell];
    
    [self.userDescriptionView addSubview:self.userDescriptionTitleLabel];
    [self.userDescriptionView addSubview:self.userDescriptionLabel];
    
}

- (void)tapCell:(UITapGestureRecognizer *)tapGR {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCellWithCellTag:)]) {
        [self.delegate tapCellWithCellTag:tapGR.view.tag];
    }
    
}

- (void)doneButtonClickAction {
    
}

- (void)setUserDescription:(NSString *)userDescription {
    
    if (!userDescription && [userDescription isEqualToString:@""]) {
        self.userDescriptionLabel.textColor = [UIColor colorWithHex:0xe5e5e5];
    } else {
        self.userDescriptionLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
    }
    
    if (!userDescription || [userDescription isEqualToString:@""]) {
        self.userDescriptionLabel.height = ConvertiPhone5Or6pSize(45.0f);
    } else {
        
        CGFloat height = [userDescription heightWithFont:self.userDescriptionLabel.font width:self.userDescriptionLabel.width];
        self.userDescriptionLabel.height = ConvertiPhone5Or6pSize(26.0f + height);
    }
    
    self.userDescriptionLabel.text  = userDescription;
    self.userDescriptionView.height = self.userDescriptionLabel.bottom;
    
    
}

- (void)setNickname:(NSString *)nickname {
    self.nicknameCell.rightTitleLabel.text  = nickname;
    [self.nicknameCell layoutSubviews];
    
}

- (void)setSex:(UserSex)sex {
    ((UIImageView *)self.sexCell.rightView).image = [UIImage imageNamed: sex == UserSexBoy ? @"UserRegisterInfoBoy" : @"UserRegisterInfoGirl" ];
}

- (void)setAge:(NSString *)age {
    self.ageCell.rightTitleLabel.text = age;
}

- (void)setArea:(NSString *)area {
    self.areaCell.rightTitleLabel.text = area;
}

@end

//
//  AddPeerView.m
//  Peer
//
//  Created by jason on 1/31/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "AddPeerView.h"
#import "RegisterInfoViewCell.h"
#import "UIImage+Color.h"


@interface AddPeerView ()

@property(nonatomic,strong)UIImageView *petsAvatarImageView;
@property(nonatomic) UIView *baseInfoView;
@property(nonatomic) RegisterInfoViewCell *nicknameCell;
@property(nonatomic) RegisterInfoViewCell *sexCell;
@property(nonatomic) RegisterInfoViewCell *birthCell;

@property(nonatomic) RegisterInfoViewCell *petsSpecies;
@property(nonatomic) RegisterInfoViewCell *petsBreed;

@property(nonatomic) UIView   *detailsInfoView;
@property(nonatomic) UIButton *doneButton;



@end

@implementation AddPeerView




- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self addSubview:self.petsAvatarImageView];
    [self addSubview:self.baseInfoView];
    
    [self.baseInfoView addSubview:self.nicknameCell];
    [self.baseInfoView addSubview:self.sexCell];
    [self.baseInfoView addSubview:self.birthCell];
    
    [self addSubview:self.detailsInfoView];
    [self.detailsInfoView addSubview:self.petsSpecies];
    [self.detailsInfoView addSubview:self.petsBreed];
    
    [self addSubview:self.doneButton];
    
}

#pragma mark - -- Action

- (void)doneButtonClickAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedDoneButton)]) {
        [self.delegate clickedDoneButton];
    }
}


- (void)tapCell:(UITapGestureRecognizer *)tapGR {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCellWithCellTag:)]) {
        [self.delegate tapCellWithCellTag:tapGR.view.tag];
    }
    
}


#pragma mark - -- Data Set

- (void)setNickName:(NSString *)nickName {
    self.nicknameCell.rightTitleLabel.text = nickName;
    [self.nicknameCell layoutSubviews];
}


- (void)setSex:(NSInteger)sex {
    
    if (sex == PetsSexBoy) {
        [(UIImageView *)self.sexCell.rightView setImage:[UIImage imageNamed:@"UserRegisterInfoBoy"]];
    } else {
        [(UIImageView *)self.sexCell.rightView setImage:[UIImage imageNamed:@"UserRegisterInfoGirl"]];
    }
    
}

- (void)setBirth:(NSString *)birth {
    
    self.birthCell.rightTitleLabel.text = birth;
    [self.birthCell layoutSubviews];
    
}

- (void)setSpecies:(NSString *)species {
    self.petsSpecies.rightTitleLabel.text = species;
    [self.petsSpecies layoutSubviews];
}

- (void)setBreed:(NSString *)breed {
    self.petsBreed.rightTitleLabel.text = breed;
    [self.petsBreed layoutSubviews];
}

#pragma mark - -- View init

- (UIImageView *)petsAvatarImageView {
    if (!_petsAvatarImageView) {
        _petsAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30.0f, 90.0f, 90.0f)];
        _petsAvatarImageView.image = [UIImage imageNamed:@"AddPeerDefaultAvatar"];
        _petsAvatarImageView.centerX = self.width / 2;
        _petsAvatarImageView.layer.cornerRadius  = _petsAvatarImageView.height / 2;
        _petsAvatarImageView.layer.masksToBounds = YES;
    }
    return _petsAvatarImageView;
}


- (UIView *)baseInfoView {
    if (!_baseInfoView) {
        _baseInfoView = [self shadowViewWithFrame:CGRectMake(10, self.petsAvatarImageView.bottom + 40.0, ScreenWidth - 20.0f, 135.0f)];
        
    }
    return _baseInfoView;
}


- (RegisterInfoViewCell *)nicknameCell {
    if (!_nicknameCell) {
        _nicknameCell = [self registerInfoCellWithLeftTitle:NSLocalizedString(@"RegisterNickname", nil)];
        _nicknameCell.tag = AddPeerNickname;
        [_nicknameCell addLineWithFrame:CGRectMake(10.0f, _nicknameCell.height - 1, _nicknameCell.width - 20.0f,1) border:UIViewBorderBottomLine];
    }
    return _nicknameCell;
}


- (RegisterInfoViewCell *)sexCell {
    if (!_sexCell) {
        _sexCell = [self registerInfoCellWithLeftTitle:NSLocalizedString(@"RegisterSex", nil)];
        _sexCell.tag = AddPeerSex;
        _sexCell.top = self.nicknameCell.bottom;
        _sexCell.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserRegisterInfoBoy"]];
        [_sexCell addLineWithFrame:CGRectMake(10.0f, _nicknameCell.height - 1, _nicknameCell.width - 20.0f, 1) border:UIViewBorderBottomLine];
        
    }
    return _sexCell;
}

- (RegisterInfoViewCell *)birthCell {
    if (!_birthCell) {
        _birthCell = [self registerInfoCellWithLeftTitle:@"生日"];
        _birthCell.tag = AddPeerBirth;
        _birthCell.top = self.sexCell.bottom;
    }
    return _birthCell;
}


- (UIView *)detailsInfoView {
    if (!_detailsInfoView) {
        _detailsInfoView = [self shadowViewWithFrame:CGRectMake(10.0, self.baseInfoView.bottom + 15.0f, ScreenWidth - 20.0f, 90.0)];
        
    }
    return _detailsInfoView;
}

- (RegisterInfoViewCell *)petsSpecies {
    if (!_petsSpecies) {
        _petsSpecies = [self registerInfoCellWithLeftTitle:@"种类"];
        _petsSpecies.tag = AddPeerSpecies;
        [_petsSpecies addLineWithFrame:CGRectMake(10.0f, _petsSpecies.height - 1, _petsSpecies.width - 20.0f, 1) border:UIViewBorderBottomLine];
    }
    return _petsSpecies;
}

- (RegisterInfoViewCell *)petsBreed {
    if (!_petsBreed) {
        _petsBreed = [self registerInfoCellWithLeftTitle:@"品种"];
        _petsBreed.tag = AddPeerBreed;
        _petsBreed.top = self.petsSpecies.bottom;
        
    }
    return _petsBreed;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 0.0f, ScreenWidth - 20.0f  , 45.0f)];
        _doneButton.bottom = self.height - 10.0f;
        _doneButton.layer.cornerRadius  = 3;
        _doneButton.layer.masksToBounds = YES;
        [_doneButton setTitle:@"添加" forState:UIControlStateNormal];
        [_doneButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xffb800]] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (UIView *)shadowViewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.cornerRadius  = 3;
    view.layer.shadowOpacity = 0.1;
    view.layer.shadowOffset  = CGSizeMake(0, 0);
    view.layer.shadowColor   = [UIColor blackColor].CGColor;
    view.backgroundColor     = [UIColor whiteColor];
    
    return view;
}

- (RegisterInfoViewCell *)registerInfoCellWithLeftTitle:(NSString *)leftTitle  {
    
    RegisterInfoViewCell *cell = [[RegisterInfoViewCell alloc] initWithFrame:CGRectMake(0, 0, self.baseInfoView.width, ConvertiPhone5Or6pSize(45.0f))];
    cell.leftTitleLabel.text  = leftTitle;
    [cell addTapGestureWithTarget:self action:@selector(tapCell:)];
    
    return cell;
}






@end

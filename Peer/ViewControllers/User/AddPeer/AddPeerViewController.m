//
//  AddPeerViewController.m
//  Peer
//
//  Created by jason on 1/31/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "AddPeerViewController.h"
#import "AddPeerView.h"
#import "FillRegisterInfoViewController.h"
#import "PetsModel.h"


#import "NSString+Size.h"
#import "NSDate+Calendar.h"

@interface AddPeerViewController () <AddPeerViewDelegate,FillRegisterInfoViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong) AddPeerView *addPeerView;
@property(nonatomic) UIView       *pickerContainerView;
@property(nonatomic) UIPickerView *pickerView;
@property(nonatomic,assign) AddPeer addPeerTag;
@property(nonatomic,strong) NSArray *speciesArray; // 物种
@property(nonatomic,strong) NSArray *breedsArray;  // 品种
@property(nonatomic,strong) PetsModel *pet;
@property(nonatomic,assign) NSInteger currentYear;
//@property(nonatomic,strong) NSArray *sexImageViewArray;

@end

@implementation AddPeerViewController


- (AddPeerView *)addPeerView {
    if (!_addPeerView) {
        _addPeerView = [[AddPeerView alloc] initWithFrame:CGRectMake(0, 64.0f, ScreenWidth, ScreenHeight - 64.0f)];
        _addPeerView.delegate = self;
    }
    return _addPeerView;
}

- (UIView *)pickerContainerView {
    
    if (!_pickerContainerView) {
        _pickerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ConvertiPhone5Or6pSize(180.0f))];
        _pickerContainerView.backgroundColor = [UIColor whiteColor];
        _pickerContainerView.top = self.view.height - _pickerContainerView.height;
        [_pickerContainerView addLineWithFrame:CGRectMake(0, 0, self.view.width, 0.5) border:UIViewBorderBottomLine];
        
        UILabel *doneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 35.0f)];
        doneLabel.text     = NSLocalizedString(@"Done", nil);
        doneLabel.font     = [UIFont systemFontOfSize:14.0f];
        doneLabel.width    = [doneLabel.text widthWithFont:doneLabel.font];
        doneLabel.right    = self.view.width - 10.0f;
        doneLabel.userInteractionEnabled = YES;
        [doneLabel addTapGestureWithTarget:self action:@selector(tapPickerViewDone)];
        [_pickerContainerView addSubview:doneLabel];
        [_pickerContainerView addSubview:self.pickerView];
        
    }
    return _pickerContainerView;
}

- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 35.0f, self.view.width,ConvertiPhone5Or6pSize(145.0f))];
        _pickerView.delegate   = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.clipsToBounds   = NO;
    }
    
    return _pickerView;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.addPeerView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加Peer";
    self.pet = [[PetsModel alloc] init];
    self.currentYear = [NSDate currentYear];
    
    
#warning Test
    
    self.breedsArray  = @[@{@"breedId":@1,@"breedName":@"阿拉斯加"},@{@"breedId":@2,@"breedName":@"萨摩耶"}];
    self.speciesArray = @[@{@"speciesId":@1,@"speciesName":@"狗狗"},@{@"speciesId":@2,@"speciesName":@"喵咪"}];
    
}


- (UIBarButtonItem *)rightBarButtonItem {
    return nil;
}


#pragma mark - -- <AddPeerViewDelegate>

- (void)tapCellWithCellTag:(NSInteger)tag {
    
    if (tag == AddPeerNickname) {
        
        FillRegisterInfoViewController *fillRegister = [[FillRegisterInfoViewController alloc] init];
        fillRegister.delegate = self;
        fillRegister.registerInfoFillType = RegisterInfoFillTypeNickname;
        [self.navigationController pushViewController:fillRegister animated:YES];
        
    } else {
        
        self.addPeerTag = tag;
        if (![self.view.subviews containsObject:self.pickerContainerView]) {
            [self.view addSubview:self.pickerContainerView];
        }
        [self.pickerView reloadAllComponents];
        
    }
    
    
}

- (void)clickedDoneButton {
    
}

- (void)tapPickerViewDone {
    [self.pickerContainerView removeFromSuperview];
}


#pragma mark - -- <FillRegisterInfoViewControllerDelegate>

- (void)fillNickname:(NSString *)nickname {
    self.pet.petsName = nickname;
    [self.addPeerView setNickName:nickname];
}

#pragma mark - -- <UIPickerViewDataSource>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.addPeerTag == AddPeerBirth) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (self.addPeerTag == AddPeerSex ) {
        return 2;
    } else if (self.addPeerTag == AddPeerSpecies) {
        return [self.speciesArray count];
    } else if (self.addPeerTag == AddPeerBreed) {
        return [self.breedsArray count];
    } else if (self.addPeerTag == AddPeerBirth) {
        return component == 0 ? 80 : 12;
    }
    
    return 0;
}

#pragma mark - -- <UIPickerViewDelegate>

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.addPeerTag) {
        case AddPeerSex: {
            
            self.pet.petsSex = @(row + 1);
            [self.addPeerView setSex:(row + 1)];
            
        }
            break;
        case AddPeerBirth: {
            
            if (component == 0) {
                self.pet.petsYear  = @(self.currentYear - row - 1);
            } else if (component == 1) {
                self.pet.petsMonth = @(row + 1);
            }
            [self.addPeerView setBirth:[NSString stringWithFormat:@"%@年%@月",self.pet.petsYear,self.pet.petsMonth]];
            
        }
            break;
        case AddPeerSpecies: {
            [self.addPeerView setSpecies:self.speciesArray[row][@"speciesName"]];
        }
            break;
        case AddPeerBreed: {
            [self.addPeerView setBreed:self.breedsArray[row][@"breedName"]];
            
        }
            break;
        default:
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if (self.addPeerTag == AddPeerSex) {
        
        UIImageView *imageView = (UIImageView *)view;
        NSString *imageName = row == 0 ? @"UserRegisterInfoBoy" : @"UserRegisterInfoGirl";
        if (!imageView) {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        } else {
            imageView.image = [UIImage imageNamed:imageName];
        }
        return imageView;
        
    } else if (self.addPeerTag == AddPeerBirth) {
        
        
        UILabel *label = (UILabel *)view;
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width / 2, 20)];
            label.textAlignment = NSTextAlignmentCenter;
        }
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%ld年",self.currentYear - row - 1];
        } else if (component == 1) {
            label.text = [NSString stringWithFormat:@"%ld月",row + 1];
        }
        return label;
        
    } else if (self.addPeerTag == AddPeerSpecies) {
        
        UILabel *label = (UILabel *)view;
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
            label.textAlignment = NSTextAlignmentCenter;
        }
        label.text = self.speciesArray[row][@"speciesName"];
        
        return label;
        
    } else if (self.addPeerTag == AddPeerBreed) {
        
        UILabel *label = (UILabel *)view;
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
            label.textAlignment = NSTextAlignmentCenter;
        }
        label.text = self.breedsArray[row][@"breedName"];
        return label;
        
    }
    
    return nil;
}

@end

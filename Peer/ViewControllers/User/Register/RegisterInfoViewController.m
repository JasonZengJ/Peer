//
//  RegisterInfoViewController.m
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RegisterInfoViewController.h"
#import "RegisterInfoView.h"
#import "LoginService.h"
#import "NSString+Size.h"
#import "UIAlertView+AlertMessage.h"
#import "FileUploadService.h"
#import <UIImageView+WebCache.h>

#import "FillRegisterInfoViewController.h"

@interface RegisterInfoViewController () <RegisterInfoViewDelegate,LoginServiceDelegate,FillRegisterInfoViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic)RegisterInfoView *registerInfoView;
@property(nonatomic)UIView       *pickerContainerView;
@property(nonatomic)UIPickerView *pickerView;
@property(nonatomic)LoginService *loginService;
@property(nonatomic)FileUploadService *uploadService;
@property(nonatomic)RegisterInfo registerInfo;
@property(nonatomic)NSArray *pickerViewDataArray;
@property(nonatomic)NSArray *provinceArray;
@property(nonatomic)NSArray *cityArray;
@property(nonatomic,assign)NSInteger provinceRow;

@end

@implementation RegisterInfoViewController

- (RegisterInfoView *)registerInfoView {
    if (!_registerInfoView) {
        _registerInfoView = [[RegisterInfoView alloc] initWithFrame:self.view.frame];
        _registerInfoView.delegate = self;
    }
    return _registerInfoView;
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

- (LoginService *)loginService {
    if (!_loginService) {
        _loginService = [[LoginService alloc] init];
        _loginService.delegate = self;
    }
    return _loginService;
}

- (FileUploadService *)uploadService {
    if (!_uploadService) {
        _uploadService = [[FileUploadService alloc] init];
    }
    return _uploadService;
}

- (void)loadView {
    [super loadView];
    self.title = NSLocalizedString(@"RegisterFillInUserProfile", nil);
    [self.view addSubview:self.registerInfoView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.registerInfoView setAge:@"0"];
    [self.registerInfoView.userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:@"http://jasonlife.oss-cn-shenzhen.aliyuncs.com/DoNRiuquSFFLTQjxV2NimM7FvrM%3D/image/xjQFFtwb2X5gCUXAFqIdMFrCj3w%3D"]];
    
    if (!self.user) {
        self.user = [[UserModel alloc] init];
    }
    
    self.pickerViewDataArray = @[@"UserRegisterInfoBoy",@"UserRegisterInfoGirl"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadAreaData];
    });
}

- (void)loadAreaData {
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"address_CN" withExtension:@"plist"];
    NSDictionary *areaDataDic = [NSDictionary dictionaryWithContentsOfURL:path];
    self.provinceArray = [areaDataDic allKeys];
    self.user.area     = self.provinceArray[0];
    NSMutableArray *cityArray = [NSMutableArray array];
    
    for (NSString *province in self.provinceArray) {
        
        NSArray *cityKeys = [[areaDataDic objectForKey:province][0] allKeys];
        if ([cityKeys count] == 1) {
           cityKeys = [[areaDataDic objectForKey:province][0] objectForKey:cityKeys[0]];
        }
        [cityArray addObject:cityKeys];
        
    }
    self.cityArray = [cityArray copy];
    
}

- (UIBarButtonItem *)rightBarButtonItem {
    return nil;
}

- (void)tapPickerViewDone {
    [self.pickerContainerView removeFromSuperview];
}

#pragma mark - -- <RegisterInfoViewDelegate>

- (void)tapCellWithCellTag:(NSInteger)tag {
    
    
    
    if (tag == RegisterInfoAge || tag == RegisterInfoArea || tag == RegisterInfoSex) {
        self.registerInfo = tag;
        if (![self.view.subviews containsObject:self.pickerContainerView]) {
            [self.view addSubview:self.pickerContainerView];
        }
        [self.pickerView reloadAllComponents];
    } else if (tag == RegisterInfoNickname) {
        FillRegisterInfoViewController *fillRegisterInfoViewController = [[FillRegisterInfoViewController alloc] init];
        fillRegisterInfoViewController.title = NSLocalizedString(@"RegisterNickname", nil);
        fillRegisterInfoViewController.registerInfoFillType = RegisterInfoFillTypeNickname;
        fillRegisterInfoViewController.delegate = self;
        [self.navigationController pushViewController:fillRegisterInfoViewController animated:YES];
    } else if (tag == RegisterInfoDescription) {
        FillRegisterInfoViewController *fillRegisterInfoViewController = [[FillRegisterInfoViewController alloc] init];
        fillRegisterInfoViewController.title = NSLocalizedString(@"RegisterIntroduction", nil);
        fillRegisterInfoViewController.registerInfoFillType = RegisterInfoFillTypeUserDescription;
        fillRegisterInfoViewController.delegate = self;
        [self.navigationController pushViewController:fillRegisterInfoViewController animated:YES];
    }
    
}

- (void)clickedDoneButton {
    
    if (!self.user.nickname || [self.user.nickname isEqualToString:@""]) {
        [UIAlertView alertWithMessage:@"请输入昵称"];
        return;
    }
    
    if (!self.user.sex || [self.user.sex isEqualToNumber:@(0)]) {
        [UIAlertView alertWithMessage:@"请选择性别"];
        return;
    }
    
    NSData *avatarImageData = UIImageJPEGRepresentation(self.registerInfoView.userAvatarImageView.image, 0.6);
    [self.uploadService uploadImageData:avatarImageData callback:^(BOOL isSuccess, NSError *error, NSString *fileUrl) {
        
        if (error) {
            DLog(@"%@",error);
        } else {
            DLog(@"upload success");
            self.user.avatar = fileUrl;
            [self.loginService registerWithUserModel:self.user];
        }
        
    }];
    
    
}

#pragma mark - -- <LoginServiceDelegate>

- (void)registerCompleteWithError:(NSError *)error {
    
    if (!error) {
        [UIAlertView alertWithMessage:@"注册成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [UIAlertView alertWithMessage:error.domain];
    }
    
}

#pragma mark - -- <FillRegisterInfoViewControllerDelegate>

- (void)fillNickname:(NSString *)nickname {
    [self.registerInfoView setNickname:nickname];
    self.user.nickname = nickname;
}

- (void)fillUserDescription:(NSString *)userDescription {
    [self.registerInfoView setUserDescription:userDescription];
    self.user.userDescription = userDescription;
}


#pragma mark - -- <UIPickerViewDataSource>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.registerInfo == RegisterInfoArea) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (self.registerInfo == RegisterInfoSex ) {
        return [self.pickerViewDataArray count];
    } else if (self.registerInfo == RegisterInfoAge) {
        return 80;
    } else if (self.registerInfo == RegisterInfoArea) {
        return component == 0 ? [self.provinceArray count] : [self.cityArray[self.provinceRow] count];
    }
    
    return 0;
}

#pragma mark - -- <UIPickerViewDelegate>

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.registerInfo) {
        case RegisterInfoSex: {
            
            self.user.sex = @(row + 1);
            [self.registerInfoView setSex:(row + 1)];
            
        }
            break;
        case RegisterInfoAge: {
            
            self.user.age = @(row);
            [self.registerInfoView setAge:[NSString stringWithFormat:@"%ld",row]];
            
        }
            break;
        case RegisterInfoArea: {
            if (component == 0) {
                self.provinceRow = row;
                self.user.area = self.provinceArray[row];
                self.user.city = self.cityArray[row][0];
                [self.pickerView reloadComponent:1];
            } else if (component == 1) {
                self.user.city = [[self.cityArray objectAtIndex:self.provinceRow] objectAtIndex:row];
            }
            [self.registerInfoView setArea:[NSString stringWithFormat:@"%@ － %@",self.user.area,self.user.city]];
        }
            break;
        default:
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if (self.registerInfo == RegisterInfoSex) {
        
        UIImageView *imageView = (UIImageView *)view;
        if (!imageView) {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.pickerViewDataArray[row]]];
        }
        imageView.image = [UIImage imageNamed:self.pickerViewDataArray[row]];
        return imageView;
        
    } else if (self.registerInfo == RegisterInfoAge) {
        
        UILabel *label = (UILabel *)view;
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
            label.textAlignment = NSTextAlignmentCenter;
        }
        label.text = [NSString stringWithFormat:@"%ld",row];
        return label;
        
    } else if (self.registerInfo == RegisterInfoArea) {
        UILabel *label = (UILabel *)view;
        if (!label) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width / 2, 20)];
            label.textAlignment = NSTextAlignmentCenter;
        }
        if (component == 0) {
            label.text = self.provinceArray[row];
        } else if (component == 1) {
            label.text = [[self.cityArray objectAtIndex:self.provinceRow] objectAtIndex:row];
        }
        return label;
        
    }
    
    return nil;
}

@end

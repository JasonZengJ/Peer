//
//  AddPeerViewController.m
//  Peer
//
//  Created by jason on 1/31/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "AddPeerViewController.h"
#import "MineViewController.h"
#import "AddPeerView.h"
#import "FillRegisterInfoViewController.h"
#import "PetsModel.h"

#import "VPImageCropperViewController.h"

#import "NSString+Size.h"
#import "NSDate+Calendar.h"
#import "NSString+Check.h"

#import "FileUploadService.h"
#import "PetsService.h"
#import "LoginService.h"
#import "UserModel.h"


#import <MobileCoreServices/MobileCoreServices.h>

@interface AddPeerViewController () <AddPeerViewDelegate,FillRegisterInfoViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate>

@property(nonatomic,strong) AddPeerView *addPeerView;
@property(nonatomic) UIView       *pickerContainerView;
@property(nonatomic) UIPickerView *pickerView;
@property(nonatomic,assign) AddPeer addPeerTag;
@property(nonatomic,strong) NSArray *speciesArray; // 物种
@property(nonatomic,strong) NSArray *breedsArray;  // 品种
@property(nonatomic,strong) PetsModel *pet;
@property(nonatomic,strong) FileUploadService *fileUploadService;
@property(nonatomic,assign) NSInteger currentYear;
@property(nonatomic,assign) BOOL chosedPetsAvatar;
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
    self.pet.petsSex = @(PetsSexBoy);
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
    
    if (!self.chosedPetsAvatar) {
        [self alertWithMessage:@"请选择Peer的头像"];
        return;
    }
    
    if (![self.pet.petsName isNotEmpty]) {
        [self alertWithMessage:@"请输入Peer的昵称"];
        return;
    }
    
    if (!self.pet.petsYear || !self.pet.petsMonth) {
        [self alertWithMessage:@"请选择Peer的生日"];
        return;
    }
    
    if (![self.pet.petsSpeciesId integerValue]) {
        [self alertWithMessage:@"请选择Peer的物种,如猫猫，狗狗..."];
        return;
    }
    
    if (![self.pet.petsBreedId integerValue]) {
        [self alertWithMessage:@"请选择Peer的品种"];
        return;
    }
    
    FileUploadService *fileUploadService = [[FileUploadService alloc] init];
    NSData *avatarImageData = UIImageJPEGRepresentation(self.addPeerView.petsAvatarImageView.image, 0.6);
    
    DefineWeakSelf;
    [fileUploadService uploadImageData:avatarImageData callback:^(BOOL isSuccess, NSError *error, NSString *fileUrl) {
        DefineStrongSelf;
        if (isSuccess) {
            strongSelf.pet.petsAvatar = fileUrl;
            strongSelf.pet.userId = [LoginService currentUser].userId;
            PetsService *petsService = [[PetsService alloc] init];
            [petsService addOrUpdatePets:strongSelf.pet callBack:^(NSDictionary *responseObject) {
                
                if ([responseObject objectForKey:@"code"] && ![[responseObject objectForKey:@"code"] integerValue]) {
                    [MineViewController needReloadMineViewControllerData];
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [strongSelf alertWithMessage:responseObject[@"msg"]];
                }
                
            }];
        }
    }];
    
    
}

- (void)tapPickerViewDone {
    [self.pickerContainerView removeFromSuperview];
}

- (void)tapToChoosePetsAvatar {
    
    if ([self isPhotoLibraryAvailable]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
    } else {
        [self alertWithMessage:@"相册访问权限暂未开启，去设置－隐私－照片，然后找到Peer并点击右边的按钮开启权限"];
    }
    
}

#pragma mark - -- VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.addPeerView.petsAvatarImageView.image = editedImage;
    self.chosedPetsAvatar = YES;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - -- <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // present the cropper view controller
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - -- image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ScreenWidth) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ScreenWidth;
        btWidth = sourceImage.size.width * (ScreenWidth / sourceImage.size.height);
    } else {
        btWidth = ScreenWidth;
        btHeight = sourceImage.size.height * (ScreenWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - -- camera utility

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
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
            self.pet.petsSpeciesId = self.speciesArray[row][@"speciesId"];
            [self.addPeerView setSpecies:self.speciesArray[row][@"speciesName"]];
        }
            break;
        case AddPeerBreed: {
            self.pet.petsBreedId = self.breedsArray[row][@"breedId"];
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

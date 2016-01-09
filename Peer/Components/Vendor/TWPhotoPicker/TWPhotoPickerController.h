//
//  TWPhotoPickerController.h
//  InstagramPhotoPicker
//
//  Created by Emar on 12/4/14.
//  Copyright (c) 2014 wenzhaot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavViewController.h"
#import "TWImageScrollView.h"

@interface TWPhotoPickerController : RootNavViewController

@property (nonatomic, copy) void(^cropBlock)(UIImage *image);
@property (strong, nonatomic) TWImageScrollView *imageScrollView;

@end

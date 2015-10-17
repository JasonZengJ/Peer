//
//  SendPhotoMomentViewController.m
//  Peer
//
//  Created by jason on 10/15/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "SendPhotoMomentViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface SendPhotoMomentViewController ()


@property(nonatomic) NSMutableArray *groupArrays;
@property(nonatomic) NSMutableArray *imagesArray;
@property(nonatomic) NSMutableArray *videoArray;

@end

@implementation SendPhotoMomentViewController


- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupArrays = [NSMutableArray array];
    self.videoArray  = [NSMutableArray array];
    
    [self loadVideos];
}

- (void)reloadView {
    
    
    [self.videoArray enumerateObjectsUsingBlock:^(id  _Nonnull result, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate   *date= [result valueForProperty:ALAssetPropertyDate];
        NSString *fileName = [[result defaultRepresentation] filename];
        NSURL   *url = [[result defaultRepresentation] url];
        int64_t fileSize = [[result defaultRepresentation] size];
        
        NSLog(@"date = %@",date);
        NSLog(@"fileName = %@",fileName);
        NSLog(@"url = %@",url);
        NSLog(@"fileSize = %lld",fileSize);
    }];
    
}

- (void)loadVideos {
    __weak SendPhotoMomentViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
            if (group != nil) {
                [weakSelf.groupArrays addObject:group];
            } else {
                [weakSelf.groupArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [obj enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                        if ([result thumbnail] != nil) {
                            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
                                // 照片
                                
                            } else if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo] ){
                                
                                // 视频
                               
                                [weakSelf.videoArray addObject:result];
                                // 和图片方法类似
                            }
                        }
                    }];
                }];
                
                NSLog(@"enumeration complete");
                
                [self reloadView];
                
            }
        };
        
        
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
            
            NSString *errorMessage = nil;
            
            switch ([error code]) {
                case ALAssetsLibraryAccessUserDeniedError:
                case ALAssetsLibraryAccessGloballyDeniedError:
                    errorMessage = @"用户拒绝访问相册,请在<隐私>中开启";
                    break;
                default:
                    errorMessage = @"Reason unknown.";
                    break;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误,无法访问!"
                                                                   message:errorMessage
                                                                  delegate:self
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                [alertView show];
            });
        };
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]  init];
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                     usingBlock:listGroupBlock
                                   failureBlock:failureBlock];
    });
}

@end

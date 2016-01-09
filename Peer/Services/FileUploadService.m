//
//  FileUploadService.m
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "FileUploadService.h"
#import "OSSFileManager.h"

@interface FileUploadService ()

@property(nonatomic)OSSFileManager *fileManager;

@end

@implementation FileUploadService


- (OSSFileManager *)fileManager {
    if (!_fileManager) {
        _fileManager = [[OSSFileManager alloc] init];
    }
    return _fileManager;
}

- (void)uploadImageData:(NSData *)imageData callback:(void (^)(BOOL, NSError *, NSString *))callback {
    [self uploadImageData:imageData callback:callback progressCallback:nil];
}

- (void)uploadImageData:(NSData *)imageData callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback {
    [self.fileManager uploadImageData:imageData callback:callback progressCallback:progressCallback];
}

- (void)uploadVideoData:(NSData *)videoData callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback {
    [self.fileManager uploadVideoData:videoData callback:callback progressCallback:progressCallback];
}

- (void)uploadVoiceData:(NSData *)voiceData callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback {
    [self.fileManager uploadVoiceData:voiceData callback:callback progressCallback:progressCallback];
}
@end

//
//  FileUploadService.h
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUploadService : NSObject

- (void)uploadImageData:(NSData *)imageData callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback;

- (void)uploadImageData:(NSData *)imageData callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback;

- (void)uploadVideoData:(NSData *)videoData callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback;

- (void)uploadVoiceData:(NSData *)voiceData callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback;

@end

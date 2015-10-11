//
//  OSSFileManager.h
//  Peer
//
//  Created by jason on 10/4/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSFileManager : NSObject

- (void)uploadImageData:(NSData *)imageData key:(NSString *)key callback:(void(^)(BOOL isSuccess,NSError *error))callback progressCallback:(void(^)(float progress))progressCallback;

- (void)uploadVideoData:(NSData *)videoData key:(NSString *)key callback:(void(^)(BOOL isSuccess,NSError *error))callback progressCallback:(void(^)(float progress))progressCallback;

- (void)uploadVoiceData:(NSData *)voiceData key:(NSString *)key callback:(void(^)(BOOL isSuccess,NSError *error))callback progressCallback:(void(^)(float progress))progressCallback;

@end

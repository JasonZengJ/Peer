//
//  OSSFileManager.m
//  Peer
//
//  Created by jason on 10/4/15.
//  Copyright © 2015 peers. All rights reserved.
//


#import "OSSFileManager.h"
#import "LoginService.h"
#import "UserModel.h"
#import <ALBB_OSS_IOS_SDK/OSSService.h>

NSString *const OSSHostId   = @"oss-cn-shenzhen.aliyuncs.com";
NSString *const Bucket      = @"jasonlife";
//NSString *const VideoBucket = @"jasonlife-video";

#if DEBUG


#else


#endif


@interface OSSFileManager ()


@property(nonatomic) TaskHandler *taskHandler;
@property(nonatomic) OSSBucket *imgBucket;
@property(nonatomic) OSSBucket *videoBucket;
@property(nonatomic) OSSBucket *voiceBucket;
@property(nonatomic) id<ALBBOSSServiceProtocol> ossService;

@end

@implementation OSSFileManager

- (id<ALBBOSSServiceProtocol>)ossService {
    if (!_ossService) {
        _ossService = [ALBBOSSServiceProvider getService];
        [_ossService setGlobalDefaultBucketAcl:PUBLIC_READ];
        [_ossService setGlobalDefaultBucketHostId:OSSHostId];
        [_ossService setAuthenticationType:ORIGIN_AKSK];
        [_ossService setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
            NSString *signature = nil;
            NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
            signature = [OSSTool calBase64Sha1WithData:content withKey:[self SecretKey]];
            signature = [NSString stringWithFormat:@"OSS %@:%@", [self AccessKey], signature];
            NSLog(@"Signature:%@", signature);
            return signature;
        }];

    }
    return _ossService;
}

- (OSSBucket *)imgBucket {
    if (!_imgBucket) {
        _imgBucket = [self.ossService getBucket:Bucket];
    }
    return _imgBucket;
}

- (OSSBucket *)videoBucket {
    if (!_videoBucket) {
        _videoBucket = [self.ossService getBucket:Bucket];
    }
    return _videoBucket;
}

- (OSSBucket *)voiceBucket {
    if (!_voiceBucket) {
        _voiceBucket = [self.ossService getBucket:Bucket];
    }
    return _voiceBucket;
}

- (NSString *)AccessKey {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"AccessKey"];
}

- (NSString *)SecretKey {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"SecretKey"];
}


- (void)uploadImageData:(NSData *)imageData key:(NSString *)key callback:(void(^)(BOOL isSuccess,NSError *error))callback progressCallback:(void(^)(float progress))progressCallback   {
    
    NSString *uploadKey = [NSString stringWithFormat:@"%@/image/%@",[[LoginService currentUser] phone],key];
    OSSData *uploadImageData = [self.ossService getOSSDataWithBucket:self.imgBucket key:uploadKey];
    [uploadImageData setData:imageData withType:@"image/png"];
    [uploadImageData enableUploadCheckMd5sum:YES];
    [uploadImageData uploadWithUploadCallback:^(BOOL isSuccess,  NSError *error) {
        callback(isSuccess,error);
    } withProgressCallback:^(float progress) {
        progressCallback(progress);
    }];
    
}

- (void)uploadVideoData:(NSData *)videoData key:(NSString *)key callback:(void(^)(BOOL isSuccess,NSError *error))callback progressCallback:(void(^)(float progress))progressCallback {
    
    NSString *uploadKey = [NSString stringWithFormat:@"%@/video/%@",[[LoginService currentUser] phone],key];
    OSSData *uploadVideoData = [self.ossService getOSSDataWithBucket:self.videoBucket key:uploadKey];
    [uploadVideoData setData:videoData withType:@"image/png"];
    [uploadVideoData enableUploadCheckMd5sum:YES];
     [uploadVideoData uploadWithUploadCallback:^(BOOL isSuccess,  NSError *error) {
        callback(isSuccess,error);
    } withProgressCallback:^(float progress) {
        progressCallback(progress);
    }];
    
    
    
}

- (void)uploadVoiceData:(NSData *)voiceData key:(NSString *)key callback:(void(^)(BOOL isSuccess,NSError *error))callback progressCallback:(void(^)(float progress))progressCallback {
    
    NSString *uploadKey = [NSString stringWithFormat:@"%@/voice/%@",[[LoginService currentUser] phone],key];
    OSSData *uploadVideoData = [self.ossService getOSSDataWithBucket:self.voiceBucket key:uploadKey];
    [uploadVideoData setData:voiceData withType:@"image/png"];
    [uploadVideoData enableUploadCheckMd5sum:YES];
    [uploadVideoData uploadWithUploadCallback:^(BOOL isSuccess,  NSError *error) {
        callback(isSuccess,error);
    } withProgressCallback:^(float progress) {
        progressCallback(progress);
    }];
    
}

@end

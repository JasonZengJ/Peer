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


- (void)uploadImageData:(NSData *)imageData  callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback   {
    
    NSString *phone = [[LoginService currentUser] phone];
    if (!phone || [phone isEqualToString:@""]) {
        return;
    }
    NSString *uploadKey = [NSString stringWithFormat:@"%@/image/%@",[self userKey],[self uniqueFileKey]];
    DLog(@"upload key : %@",uploadKey);
    OSSData *uploadImageData = [self.ossService getOSSDataWithBucket:self.imgBucket key:uploadKey];
    [uploadImageData setData:imageData withType:@"image/png"];
    [uploadImageData enableUploadCheckMd5sum:YES];
    [uploadImageData uploadWithUploadCallback:^(BOOL isSuccess,  NSError *error) {
        callback(isSuccess,error,[uploadImageData getResourceURL]);
    } withProgressCallback:^(float progress) {
        if (progressCallback) {
            progressCallback(progress);
        }
    }];
    
}

- (void)uploadVideoData:(NSData *)videoData callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback {
    
    if ([LoginService currentUser]) {
        return;
    }
    NSString *uploadKey = [NSString stringWithFormat:@"%@/video/%@",[self userKey],[self uniqueFileKey]];
    DLog(@"upload key : %@",uploadKey);
    OSSData *uploadVideoData = [self.ossService getOSSDataWithBucket:self.videoBucket key:uploadKey];
    [uploadVideoData setData:videoData withType:@"image/mp4"];
    [uploadVideoData enableUploadCheckMd5sum:YES];
     [uploadVideoData uploadWithUploadCallback:^(BOOL isSuccess,  NSError *error) {
        callback(isSuccess,error,[uploadVideoData getResourceURL]);
    } withProgressCallback:^(float progress) {
        if (progressCallback) {
            progressCallback(progress);
        }
    }];
    
    
}

- (void)uploadVoiceData:(NSData *)voiceData  callback:(void(^)(BOOL isSuccess,NSError *error,NSString *fileUrl))callback progressCallback:(void(^)(float progress))progressCallback {
    
    NSString *phone = [[LoginService currentUser] phone];
    if (!phone || [phone isEqualToString:@""]) {
        return;
    }
    NSString *uploadKey = [NSString stringWithFormat:@"%@/voice/%@",[self userKey],[self uniqueFileKey]];
    DLog(@"upload key : %@",uploadKey);
    OSSData *uploadVideoData = [self.ossService getOSSDataWithBucket:self.voiceBucket key:uploadKey];
    [uploadVideoData setData:voiceData withType:@"image/mp3"];
    [uploadVideoData enableUploadCheckMd5sum:YES];
    [uploadVideoData uploadWithUploadCallback:^(BOOL isSuccess,  NSError *error) {
        callback(isSuccess,error,[uploadVideoData getResourceURL]);
    } withProgressCallback:^(float progress) {
        if (progressCallback) {
            progressCallback(progress);
        }
    }];
    
}

- (NSString *)userKey {
   return  [[[OSSTool calBase64Sha1WithData:[[LoginService currentUser] phone] withKey:[self AccessKey]] stringByReplacingOccurrencesOfString:@"/" withString:@"-"] stringByReplacingOccurrencesOfString:@"+" withString:@"_"];
}

- (NSString *)uniqueFileKey {
    
    return [[[OSSTool calBase64Sha1WithData:[[NSUUID UUID] UUIDString]  withKey:@"peer"] stringByReplacingOccurrencesOfString:@"/" withString:@"-"] stringByReplacingOccurrencesOfString:@"+" withString:@"_"];
}

@end

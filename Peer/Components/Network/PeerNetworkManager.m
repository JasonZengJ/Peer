//
//  PeerNetworkManager.m
//  Peer
//
//  Created by jason on 9/9/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "PeerNetworkManager.h"
#import "NSData+JSON.h"
#import "OpenUDID.h"
#import "AppService.h"

#import <AFNetworking.h>


#ifdef DEBUG

 NSString *HostName = @"http://localhost";

// 本机环境
 NSString *SecureHostName = @"http://localhost";

// 局域网环境
// NSString *SecureHostName = @"https://192.168.1.101";

// 测试服务器环境
// NSString *SecureHostName = @"https://api.jasonlife.me";

#else

 NSString *HostName = @"http://localhost";
 NSString *SecureHostName = @"https://api.jasonlife.me";

#endif


 NSString *device  = @"mobile";

@implementation PeerNetworkManager


+ (PeerNetworkManager *)shareInstance {
    
    return [[PeerNetworkManager alloc] init];
}


#pragma mark - -- HTTP POST
- (void)postWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    
//    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:HostName];
//    params = [self encapsulationParams:params];
//    [self postWithParams:params url:url target:target callBack:callBack];
}

- (void)postWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath callBackBlock:(void(^)(id responseObject))callBackBlock {
    
//    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:HostName];
//    params = [self encapsulationParams:params];
//    [self postWithParams:params url:url callBackBlock:callBackBlock];
    
}

#pragma mark - -- HTTPS POST

- (void)securePostWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:SecureHostName];
    params = [self encapsulationParams:params];
    [self postWithParams:params url:url target:target callBack:callBack];
}

- (void)securePostWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath callBackBlock:(void(^)(id responseObject))callBackBlock {
    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:SecureHostName];
    params = [self encapsulationParams:params];
    [self postWithParams:params url:url callBackBlock:callBackBlock];
}


#pragma mark - -- HTTP GET

- (void)getWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
//    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:HostName];
//    params = [self encapsulationParams:params];
//    [self getWithParams:params apiPath:url target:target callBack:callBack];
}

#pragma mark - -- HTTPS GET

- (void)secureGetWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:SecureHostName];
    params = [self encapsulationParams:params];
    [self getWithParams:params apiPath:url target:target callBack:callBack];
}


#pragma mark - -- URL Encapsulation

- (NSString *)encapsulationUrlWithApiPath:(NSString *)apiPath host:(NSString *)host {
    return [NSString stringWithFormat:@"%@/%@/%@?appVer=%@&sysVer=%@",
            SecureHostName,device,apiPath,[AppService appVersion],[AppService systemVersion]];
}

- (NSDictionary *)encapsulationParams:(NSDictionary *)params {
    
    if ([AppService token]) {
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:params];
        [mutableDic setObject:[AppService token] forKey:@"token"];
        params = [mutableDic copy];
    }
    
    if ([AppService udid]) {
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:params];
        [mutableDic setObject:[AppService udid] forKey:@"udid"];
        params = [mutableDic copy];
    }
    
    return params;
}

#pragma mark - -- Low Level


- (void)postWithParams:(NSDictionary *)params url:(NSString *)url callBackBlock:(void(^)(id responseObject))callBackBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setValue:@(YES) forKey:@"removesKeysWithNullValues"];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [self printStartRequestWithUrl:url params:params];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self printSuccessResponseData:responseObject url:operation.request.URL.absoluteString];
        callBackBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString *errorString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        [self printFailedResponseData:errorString ? errorString : error url:operation.request.URL.absoluteString];
        callBackBlock(@{@"code":@(error.code),@"msg":errorString,@"data":error});
        
    }];
}


- (void)postWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setValue:@(YES) forKey:@"removesKeysWithNullValues"];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [self printStartRequestWithUrl:url params:params];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        [self printSuccessResponseData:responseObject url:operation.request.URL.absoluteString];
        [self performCallBack:callBack withTarget:target data:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString *errorString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        [self printFailedResponseData:errorString && ![errorString isEqualToString:@""] ? errorString : error url:operation.request.URL.absoluteString];
        [self performCallBack:callBack withTarget:target data:@{@"code":@(error.code),@"msg":errorString,@"data":error}];
        
    }];
}

- (void)getWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [self printStartRequestWithUrl:url params:params];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self printSuccessResponseData:responseObject url:operation.request.URL.absoluteString];
        [self performCallBack:callBack withTarget:target data:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString *errorString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        [self printFailedResponseData:errorString ? errorString : error url:operation.request.URL.absoluteString];
        [self performCallBack:callBack withTarget:target data:@{@"code":@(error.code),@"msg":errorString,@"data":error}];
        
    }];
}



- (void)printStartRequestWithUrl:(NSString *)url params:(NSDictionary *)params {
    
    DLog(@"\n\n============ Request start   =============\nurl:  %@\nparams:  %@\n============================================",url,params);

    
}

- (void)printSuccessResponseData:(id)responseData url:(NSString *)url {
    DLog(@"\n\n============ Request Success   =============\nreqeust url:%@\nresponse: %@\n============================================",url,responseData);
}

- (void)printFailedResponseData:(id)responseData url:(NSString *)url {
    DLog(@"\n\n============ Request Failed   ==============\nreqeust url:%@\nresponse: %@\n============================================",url,responseData);
}

- (void)performCallBack:(SEL)selector withTarget:(id)target data:(NSDictionary *)data
{
    if ([target respondsToSelector:selector]) {
        [target performSelector:selector withObject:data];
    }
}


@end

//
//  PeerNetworkManager.m
//  Peer
//
//  Created by jason on 9/9/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "PeerNetworkManager.h"
#import "NSData+JSON.h"
#import "NSDictionary+AddObject.h"
#import "OpenUDID.h"
#import "AppService.h"

#import <AFNetworking.h>


#ifdef DEBUG

 NSString *HostName = @"http://localhost";
 NSString *SecureHostName = @"https://192.168.1.103";

#else

 NSString *HostName = @"http://localhost";
 NSString *SecureHostName = @"https://192.168.1.107";

#endif


 NSString *device  = @"mobile";

@implementation PeerNetworkManager


+ (PeerNetworkManager *)shareInstance {
    
    static dispatch_once_t onceToken;
    static PeerNetworkManager *peerNetworkManager;
    dispatch_once(&onceToken, ^{
        peerNetworkManager = [[PeerNetworkManager alloc] init];
    });
    
    return peerNetworkManager;
}


#pragma mark - -- HTTP POST
- (void)postWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    
    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:HostName];
    [self postWithParams:params url:url target:target callBack:callBack];
}

- (void)postWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath callBackBlock:(void(^)(id responseObject))callBackBlock {
    
    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:HostName];
    [self postWithParams:params url:url callBackBlock:callBackBlock];
    
}

#pragma mark - -- HTTPS POST

- (void)securePostWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:SecureHostName];
    [self postWithParams:params url:url target:target callBack:callBack];
}

- (void)securePostWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath callBackBlock:(void(^)(id responseObject))callBackBlock {
    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:SecureHostName];
    [self postWithParams:params url:url callBackBlock:callBackBlock];
}


#pragma mark - -- HTTP GET

- (void)getWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    NSString *url = [self encapsulationUrlWithApiPath:apiPath host:HostName];
    [self getWithParams:params apiPath:url target:target callBack:callBack];
}

#pragma mark - -- URL Encapsulation

- (NSString *)encapsulationUrlWithApiPath:(NSString *)apiPath host:(NSString *)host {
    return [NSString stringWithFormat:@"%@/%@/%@?udid=%@&appVer=%@&sysVer=%@",
            SecureHostName,device,apiPath,[AppService udid],[AppService appVersion],[AppService systemVersion]];
}


//- (NSString *)encapsulationUrlWithApiPath:(NSString *)apiPath {
//    NSString *appVer = [AppService  appVersion];
//    return [NSString stringWithFormat:@"%@/%@/%@/%@?udid=%@&appVer=%@",HostName,device,version,apiPath,[AppService udid],appVer];
//}

#pragma mark - -- Low Level


- (void)postWithParams:(NSDictionary *)params url:(NSString *)url callBackBlock:(void(^)(id responseObject))callBackBlock {
    
    params = [params addObject:[AppService token] forKey:@"token"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setValue:@(YES) forKey:@"removesKeysWithNullValues"];
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
    
    params = [params addObject:[AppService token] forKey:@"token"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setValue:@(YES) forKey:@"removesKeysWithNullValues"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [self printStartRequestWithUrl:url params:params];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        [self printSuccessResponseData:responseObject url:operation.request.URL.absoluteString];
        [self performCallBack:callBack withTarget:target data:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString *errorString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        [self printFailedResponseData:errorString ? errorString : error url:operation.request.URL.absoluteString];
        [self performCallBack:callBack withTarget:target data:@{@"code":@(error.code),@"msg":errorString,@"data":error}];
        
    }];
}

- (void)getWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack {
    
    params = [params addObject:[AppService token] forKey:@"token"];
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
    
    DLog(@"============ Request start   =============");
    DLog(@"url:  %@",url);
    DLog(@"params:  %@",params);
    
    DLog(@"============================================");
    
}

- (void)printSuccessResponseData:(id)responseData url:(NSString *)url {
    DLog(@"============ Request Success   =============");
    DLog(@"reqeust url:%@",url);
    DLog(@"response: %@",responseData);
    DLog(@"============================================");
}

- (void)printFailedResponseData:(id)responseData url:(NSString *)url {
    DLog(@"============ Request Failed   ==============");
    DLog(@"reqeust url:%@",url);
    DLog(@"response: %@",responseData);
    DLog(@"============================================");
}

- (void)performCallBack:(SEL)selector withTarget:(id)target data:(NSDictionary *)data
{
    if ([target respondsToSelector:selector]) {
        [target performSelector:selector withObject:data];
    }
}


@end

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

const NSString *HostName = @"http://localhost";
const NSString *SecureHostName = @"https://localhost";

#else

const NSString *HostName = @"http://localhost";
const NSString *SecureHostName = @"https://192.168.1.107";

#endif


const NSString *device  = @"mobile";
const NSString *version = @"v1";

@implementation PeerNetworkManager


+ (PeerNetworkManager *)shareInstance {
    
    static dispatch_once_t onceToken;
    static PeerNetworkManager *peerNetworkManager;
    dispatch_once(&onceToken, ^{
        peerNetworkManager = [[PeerNetworkManager alloc] init];
    });
    
    return peerNetworkManager;
}

- (void)postWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    
    NSString *url = [self encapsulationUrlWithApiPath:apiPath];
    [self postWithParams:params url:url target:target callBack:callBack];
}

- (void)getWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    NSString *url = [self encapsulationUrlWithApiPath:apiPath];
    [self getWithParams:params apiPath:url target:target callBack:callBack];
}


- (void)securePostWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    NSString *url = [self encapsulationSecureUrlWithApiPath:apiPath];
    [self postWithParams:params url:url target:target callBack:callBack];
}

- (NSString *)encapsulationSecureUrlWithApiPath:(NSString *)apiPath {
    NSString *appVer = [[AppService shareInstance] appVersion];
    return [NSString stringWithFormat:@"%@/%@/%@/%@?udid=%@&appVer=%@",SecureHostName,device,version,apiPath,[OpenUDID value],appVer];
}


- (NSString *)encapsulationUrlWithApiPath:(NSString *)apiPath {
    NSString *appVer = [[AppService shareInstance] appVersion];
    return [NSString stringWithFormat:@"%@/%@/%@/%@?udid=%@&appVer=%@",HostName,device,version,apiPath,[OpenUDID value],appVer];
}


- (void)postWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setValue:@(YES) forKey:@"removesKeysWithNullValues"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        [self printSuccessResponseData:responseObject url:operation.request.URL.absoluteString];
        [self performCallBack:callBack withTarget:target data:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        [self performCallBack:callBack withTarget:target data:@{@"code":@(-1000),@"msg":errorString,@"data":error}];
    }];
}

- (void)getDataWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self printSuccessResponseData:responseObject url:operation.request.URL.absoluteString];
        [self performCallBack:callBack withTarget:target data:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        [self performCallBack:callBack withTarget:target data:@{@"code":@(-1000),@"msg":errorString,@"data":error}];
    }];
}

- (void)printSuccessResponseData:(id)responseData url:(NSString *)url {
    DLog(@"============ Request Success   =============");
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

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

#import <AFNetworking.h>


const NSString *TestHostName = @"http://localhost";
const NSString *TestSecureHostName = @"https://localhost";


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
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@/?udid=%@&appVer=%@",TestHostName,apiPath,device,version,[OpenUDID value]];
    [self postWithParams:params url:url target:target callBack:callBack];
}

- (void)getWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack {
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@/?udid=%@appVer=%@",TestHostName,apiPath,device,version,[OpenUDID value]];
    [self getWithParams:params apiPath:url target:target callBack:callBack];
}




- (void)postWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self performCallBack:callBack withTarget:target data:[responseObject jsonObject]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self performCallBack:callBack withTarget:target data:@{@"error":error}];
    }];
}

- (void)getDataWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self performCallBack:callBack withTarget:target data:[responseObject jsonObject]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *responseString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Error: %@", error);
        NSLog(@"-------\n %@",responseString);
        [self performCallBack:callBack withTarget:target data:@{@"error":error}];
    }];
}

- (void)performCallBack:(SEL)selector withTarget:(id)target data:(NSDictionary *)data
{
    if ([target respondsToSelector:selector]) {
        [target performSelector:selector withObject:data];
    }
}


@end

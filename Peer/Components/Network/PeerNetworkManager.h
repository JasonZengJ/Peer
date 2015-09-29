//
//  PeerNetworkManager.h
//  Peer
//
//  Created by jason on 9/9/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeerNetworkManager : NSObject

+ (PeerNetworkManager *)shareInstance;

- (void)securePostWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack;
- (void)securePostWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath callBackBlock:(void(^)(id responseObject))callBackBlock;


- (void)postWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack;
- (void)postWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath callBackBlock:(void(^)(id responseObject))callBackBlock;


- (void)getWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack;

//- (void)secureGetWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack;
//- (void)secureGetWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath callBackBlock:(void(^)(id responseObject))callBackBlock;


- (void)postWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack;
- (void)getWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack;

@end

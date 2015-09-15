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

- (void)postWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack;
- (void)getWithParams:(NSDictionary *)params apiPath:(NSString *)apiPath target:(id)target callBack:(SEL)callBack;


- (void)postWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack;
- (void)getDataWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack;

@end

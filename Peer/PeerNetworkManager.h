//
//  PeerNetworkManager.h
//  Peer
//
//  Created by jason on 9/9/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeerNetworkManager : NSObject

- (void)postWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack;
- (void)getDataWithParams:(NSDictionary *)params url:(NSString *)url target:(id)target callBack:(SEL)callBack;

@end

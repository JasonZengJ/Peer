//
//  PeerNetworkManager.m
//  Peer
//
//  Created by jason on 9/9/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "PeerNetworkManager.h"

@implementation PeerNetworkManager


+ (PeerNetworkManager *)shareInstance {
    
    static dispatch_once_t onceToken;
    static PeerNetworkManager *peerNetworkManager;
    dispatch_once(&onceToken, ^{
        
    });
    
    return peerNetworkManager;
}

@end

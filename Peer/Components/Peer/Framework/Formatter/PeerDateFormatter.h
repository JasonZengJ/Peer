//
//  PeerDateFormatter.h
//  Peer
//
//  Created by jason on 10/27/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeerDateFormatter : NSObject

+ (PeerDateFormatter *)shareInstance;

- (void)formateDateString:(NSString *)dateString;

- (NSInteger)day;

- (NSInteger)month;

@end

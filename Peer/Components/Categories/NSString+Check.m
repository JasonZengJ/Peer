//
//  NSString+Check.m
//  Peer
//
//  Created by jason on 3/2/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)


- (BOOL)isNotEmpty {
	
    return ![self isEqualToString:@""];
}

@end

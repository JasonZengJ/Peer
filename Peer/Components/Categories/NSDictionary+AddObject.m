//
//  NSDictionary+AddObject.m
//  Peer
//
//  Created by jason on 9/22/15.
//  Copyright (c) 2015 peers. All rights reserved.
//

#import "NSDictionary+AddObject.h"

@implementation NSDictionary (AddObject)

- (NSDictionary *)addObject:(id)object forKey:(NSString *)key {
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:self];
    [mutableDic addObject:object forKey:key];
    return [mutableDic copy];
    
}

@end

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
    [mutableDic setObject:object forKey:key];
    return [mutableDic copy];
    
}

- (NSDictionary *)addDictionary:(NSDictionary *)dictionary {
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:self];
    
    for (NSString *key in dictionary) {
        [mutableDic setObject:dictionary[key] forKey:key];
    }
    
    return [mutableDic copy];
}

@end

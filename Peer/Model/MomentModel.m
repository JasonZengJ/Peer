//
//  MomentModel.m
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentModel.h"

@implementation MomentModel

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    
    self = [super init];
    if (self) {
        
        self.momentId = [dict objectForKey:@"id"];
        
        
        
    }
    
    return self;
    
}

@end

//
//  BaseModel.m
//  Peer
//
//  Created by jason on 11/6/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    return [super initWithDictionary:dict error:err];
}

- (NSDictionary *)toDictionary {
    return [super toDictionary];
}


@end

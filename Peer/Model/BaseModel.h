//
//  BaseModel.h
//  Peer
//
//  Created by jason on 11/6/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "JSONModel.h"

@interface BaseModel : JSONModel

- (NSDictionary *)toDictionary;


- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err;

@end

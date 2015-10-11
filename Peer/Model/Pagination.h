//
//  Pagination.h
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "JSONModel.h"

@interface Pagination : JSONModel

@property(nonatomic)NSInteger page;  // 第几页，默认为0
@property(nonatomic)NSInteger limit; // 每页多少条数据，默认为10 ,最多15

@end

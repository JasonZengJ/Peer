//
//  MomentsService.h
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pagination.h"

@interface MomentsService : NSObject


- (void)getAllMomentsWithPagination:(Pagination *)pagination callback

@end

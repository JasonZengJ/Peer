//
//  MomentModel.h
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "JSONModel.h"

@interface MomentModel : JSONModel

@property(nonatomic) NSNumber *momentId;
@property(nonatomic) NSNumber *petsId;
@property(nonatomic) NSNumber *userId;
@property(nonatomic) NSString<Optional> *momentTitle;
@property(nonatomic) NSString<Optional> *momentDescription;
@property(nonatomic) NSString *momentType;
@property(nonatomic) NSString *momentTargetUrl;
@property(nonatomic) NSNumber *viewAmount;
@property(nonatomic) NSNumber *commentsAmount;
@property(nonatomic) NSNumber *likeAmount;
@property(nonatomic) NSString *createdAt;

@end

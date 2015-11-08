//
//  CommentModel.h
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"

@interface CommentModel : BaseModel

@property(nonatomic)NSNumber *commentId;
@property(nonatomic)NSString *content;
@property(nonatomic)NSNumber *userId;
@property(nonatomic)NSNumber *momentId;
@property(nonatomic)NSNumber *parentId;
@property(nonatomic)NSString *createdAt;
@property(nonatomic)UserModel *user;

@end

//
//  MomentsService.h
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pagination.h"

@class MomentModel;
@class CommentModel;

@interface MomentsService : NSObject


- (void)getAllMomentsWithPagination:(Pagination *)pagination callBackBlock:(void(^)(NSArray *moments))callBackBlock;

/**
 * 获取某个宠物的所有状态
 */
- (void)getAllMomentsWithPetsId:(NSNumber *)petsId callBackBlock:(void(^)(NSArray *moments))callBackBlock;

- (void)sendMoment:(MomentModel *)moment callBackBlock:(void(^)(MomentModel *moment))callBackBlock;

- (void)deleteMomentWithMomentId:(NSNumber *)momentId callBackBlock:(void(^)(BOOL isSuccess))callBackBlock;

- (void)likeMomentWithMomentId:(NSNumber *)momentId userId:(NSNumber *)userId;
/**
 * 统计moment的浏览次数
 */
- (void)incrementMomentViewAmountWithMomentId:(NSNumber *)momentId;



- (void)getCommentsWithMomentId:(NSNumber *)momentId pagination:(Pagination *)pagination callBackBlock:(void(^)(NSArray *comments))callBackBlock;
- (void)sendComment:(CommentModel *)comment callBackBlock:(void(^)(CommentModel *moment))callBackBlock;


@end

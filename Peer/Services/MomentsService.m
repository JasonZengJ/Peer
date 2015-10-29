//
//  MomentsService.m
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentsService.h"
#import "MomentModel.h"
#import "CommentModel.h"
#import "PeerNetworkManager.h"
#import "NSDictionary+AddObject.h"

#define MomentsAllPath           @"v1/moments/moments-all"
#define ViewPetsMomentCountPath  @"v1/moments/view-pets-moment-count"
#define PetMomentsPath           @"v1/moments/pet-moments"
#define SendMomentPath           @"v1/moments/send-moment"
#define DeleteMomentPath         @"v1/moments/delete-moment"
#define LikeMomentPath           @"v1/moments/like-moment"
#define UnlikeMomentPath         @"v1/moments/unlike-moment"

#define CommentsPath             @"v1/moments/comments"
#define SendCommentPath          @"v1/moments/send-comment"
#define DeleteCommentPath        @"v1/moments/delete-comment"



@interface MomentsService ()

@property(nonatomic)PeerNetworkManager *peerNetworkManager;

@end


@implementation MomentsService

- (PeerNetworkManager *)peerNetworkManager {
    if (!_peerNetworkManager) {
        _peerNetworkManager = [[PeerNetworkManager alloc] init];
    }
    return _peerNetworkManager;
}


#pragma mark - -- Moments

- (void)getAllMomentsWithPagination:(Pagination *)pagination callBackBlock:(void(^)(NSArray *moments))callBackBlock {
    
    [self.peerNetworkManager securePostWithParams:[pagination toDictionary] apiPath:MomentsAllPath callBackBlock:^(id responseObject) {
        
        if (responseObject && ![[responseObject objectForKey:@"code"] integerValue]) {
            
            NSArray *momentsArray = [self makeMommentsArrayWithData:[responseObject objectForKey:@"data"]];
            callBackBlock(momentsArray);
            
        } else {
            callBackBlock(nil);
        }
        
    }];
    
}



- (void)getAllMomentsWithPetsId:(NSNumber *)petsId callBackBlock:(void(^)(NSArray *moments))callBackBlock {
    
    [self.peerNetworkManager securePostWithParams:@{@"petsId":petsId} apiPath:PetMomentsPath callBackBlock:^(id responseObject) {
        
        if (responseObject && ![[responseObject objectForKey:@"code"] integerValue]) {
            
            NSArray *momentsArray = [self makeMommentsArrayWithData:[responseObject objectForKey:@"data"]];
            callBackBlock(momentsArray);
            
        } else {
            callBackBlock(nil);
        }
        
    }];
    
}


- (void)sendMoment:(MomentModel *)moment callBackBlock:(void(^)(MomentModel *moment))callBackBlock {
    
    [self.peerNetworkManager securePostWithParams:[moment toDictionary] apiPath:SendMomentPath callBackBlock:^(id responseObject) {
        
        if (responseObject && ![[responseObject objectForKey:@"code"] integerValue]) {
            
            MomentModel *moment = [[MomentModel alloc] initWithDictionary:[responseObject objectForKey:@"data"] error:nil];
            callBackBlock(moment);
            
        } else {
            callBackBlock(nil);
        }
    }];
    
}

- (void)deleteMomentWithMomentId:(NSNumber *)momentId callBackBlock:(void(^)(BOOL isSuccess))callBackBlock {
    [self.peerNetworkManager securePostWithParams:@{@"momentId":momentId} apiPath:DeleteMomentPath callBackBlock:^(id responseObject) {
        
        if (responseObject && ![[responseObject objectForKey:@"code"] integerValue]) {
            callBackBlock(YES);
        } else {
            callBackBlock(NO);
        }
        
    }];
}


- (void)likeMomentWithMomentId:(NSNumber *)momentId userId:(NSNumber *)userId {
    
    [self.peerNetworkManager securePostWithParams:@{@"momentId":momentId,@"userId":userId} apiPath:LikeMomentPath callBackBlock:^(id responseObject) {
        
    }];
    
}

- (void)unlikeMomentWithMomentId:(NSNumber *)momentId userId:(NSNumber *)userId {
    
    [self.peerNetworkManager securePostWithParams:@{@"momentId":momentId,@"userId":userId} apiPath:UnlikeMomentPath callBackBlock:^(id responseObject) {
        
    }];
    
}


- (void)incrementMomentViewAmountWithMomentId:(NSNumber *)momentId {
    
    [self.peerNetworkManager securePostWithParams:@{@"momentId":momentId} apiPath:ViewPetsMomentCountPath callBackBlock:^(id responseObject) {
    
    }];
    
}

- (NSArray *)makeMommentsArrayWithData:(NSDictionary *)data {
    NSMutableArray *momentsArray = [NSMutableArray array];
    for (NSDictionary *momentData in data) {
        MomentModel *momentModel = [[MomentModel alloc] initWithDictionary:momentData error:nil];
        if (momentModel) {
            [momentsArray addObject:momentModel];
        }
    }
    return momentsArray;
}

#pragma mark - -- Comments


- (void)getCommentsWithMomentId:(NSNumber *)momentId pagination:(Pagination *)pagination callBackBlock:(void(^)(NSArray *comments))callBackBlock {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[pagination toDictionary]];
    [params setObject:momentId forKey:@"momentId"];
    [self.peerNetworkManager securePostWithParams:params apiPath:CommentsPath callBackBlock:^(id responseObject) {
        if (responseObject && ![[responseObject objectForKey:@"code"] integerValue]) {
            
            NSArray *commentsArray = [self makeCommentsArrayWithData:[responseObject objectForKey:@"data"]];
            callBackBlock(commentsArray);
            
        } else {
            callBackBlock(nil);
        }
    }];
    
}

- (void)sendComment:(CommentModel *)comment callBackBlock:(void(^)(CommentModel *moment))callBackBlock {
    
    [self.peerNetworkManager securePostWithParams:[comment toDictionary] apiPath:SendCommentPath callBackBlock:^(id responseObject) {
        if (responseObject && ![[responseObject objectForKey:@"code"] integerValue]) {
            
            CommentModel *comment = [[CommentModel alloc] initWithDictionary:[responseObject objectForKey:@"data"] error:nil];
            callBackBlock(comment);
            
        } else {
            callBackBlock(nil);
        }
    }];
    
}

- (void)deleteCommentWithComentId:(NSNumber *)commentId callBackBlock:(void(^)(BOOL isSuccess))callBackBlock{
    
    [self.peerNetworkManager securePostWithParams:@{@"commentId":commentId} apiPath:DeleteMomentPath callBackBlock:^(id responseObject) {
        if (responseObject && ![[responseObject objectForKey:@"code"] integerValue]) {
            callBackBlock(YES);
        } else {
            callBackBlock(NO);
        }
    }];
    
}

- (NSArray *)makeCommentsArrayWithData:(NSDictionary *)data {
    NSMutableArray *commentsArray = [NSMutableArray array];
    for (NSDictionary *commentData in data) {
        CommentModel *commentModel = [[CommentModel alloc] initWithDictionary:commentData error:nil];
        if (commentModel) {
            [commentsArray addObject:commentModel];
        }
    }
    return commentsArray;
}

@end

//
//  CommentModel.m
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel


- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    
    self = [super init];
    if (self) {
        
        self.commentId = [dict objectForKey:@"id"];
        self.content   = [dict objectForKey:@"content"];
        self.userId    = [dict objectForKey:@"user_id"];
        self.momentId  = [dict objectForKey:@"moment_id"];
        self.parentId  = [dict objectForKey:@"parent_id"];
        self.createdAt = [dict objectForKey:@"created_at"];
        self.user      = [dict objectForKey:@"user"] ? [[UserModel alloc] initWithDictionary:dict[@"user"] error:nil] : nil;
        
    }
    
    return self;
}

@end

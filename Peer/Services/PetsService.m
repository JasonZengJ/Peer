//
//  PetsService.m
//  Peer
//
//  Created by jason on 9/22/15.
//  Copyright (c) 2015 peers. All rights reserved.
//

#import "PetsService.h"
#import "LoginService.h"
#import "PeerNetworkManager.h"
#import "PetsModel.h"
#import "UserModel.h"

#define AddPetsPath           @"v1/pets/add-pets"
#define PetsByIdPath          @"v1/pets/pets-by-id"
#define AllPetsPath           @"v1/pets/all-pets"
#define AllPetsAndMomentsPath @"v1/pets/all-pets-and-moments"
#define PetsWithBreedIdPath   @"v1/pets/pets-with-breed-id"
#define LikePetsPath          @"v1/pets/like-pets"
#define UnlikePetsPath        @"v1/pets/unlike-pets"
#define FollowPetsPath        @"v1/pets/follow-pets"
#define UnfollowPetsPath      @"v1/pets/unfollow-pets"


@implementation PetsService


- (void)likePetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock {
    [[PeerNetworkManager shareInstance] securePostWithParams:@{@"userId":userId,@"petsId":petsId} apiPath:LikePetsPath callBackBlock:^(id responseObject) {
        if ([responseObject objectForKey:@"code"] && ![[responseObject objectForKey:@"code"] integerValue]) {
            callBackBlock(true);
        } else {
            callBackBlock(false);
        }
    }];
}

- (void)unlikePetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock {
    [[PeerNetworkManager shareInstance] securePostWithParams:@{@"userId":userId,@"petsId":petsId} apiPath:UnlikePetsPath callBackBlock:^(id responseObject) {
        if ([responseObject objectForKey:@"code"] && ![[responseObject objectForKey:@"code"] integerValue]) {
            callBackBlock(true);
        } else {
            callBackBlock(false);
        }
    }];
}

- (void)followPetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock {
    
    [[PeerNetworkManager shareInstance] securePostWithParams:@{@"userId":userId,@"petsId":petsId} apiPath:FollowPetsPath callBackBlock:^(id responseObject) {
        if ([responseObject objectForKey:@"code"] && ![[responseObject objectForKey:@"code"] integerValue]) {
            callBackBlock(true);
        } else {
            callBackBlock(false);
        }
    }];
    
}

- (void)unfollowPetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock {
    
    [[PeerNetworkManager shareInstance] securePostWithParams:@{@"userId":userId,@"petsId":petsId} apiPath:UnfollowPetsPath callBackBlock:^(id responseObject) {
        if ([responseObject objectForKey:@"code"] && ![[responseObject objectForKey:@"code"] integerValue]) {
            callBackBlock(true);
        } else {
            callBackBlock(false);
        }
    }];
    
}


- (void)addOrUpdatePets:(PetsModel *)petsModel callBack:(void(^)(NSDictionary* responseObject))callBackBlock {
    
    NSDictionary *params = [petsModel toDictionary];
    [[PeerNetworkManager shareInstance] securePostWithParams:params apiPath:AddPetsPath callBackBlock:^(id responseObject) {
        callBackBlock(responseObject);
    }];
    
}

#pragma mark - -- Get pets data

- (void)getPetsArrayWithBreedId:(NSNumber *)breedId callBackBlock:(void (^)(NSArray *petsArray))callBackBlock {
    
    DefineWeakSelf;
    [[PeerNetworkManager shareInstance] securePostWithParams:@{@"breedId":breedId} apiPath:PetsWithBreedIdPath callBackBlock:^(id responseObject) {
        DefineStrongSelf;
        [strongSelf commomResolveWithResponseData:responseObject callBackBlock:callBackBlock];
    }];
    
}


- (void)getPetWithPetsId:(NSNumber *)petsId callBackBlock:(void(^)(PetsModel *pets))callBackBlock {
    
    NSString *apiPath = [NSString stringWithFormat:@"%@/%@",PetsByIdPath,petsId];
    [[PeerNetworkManager shareInstance] securePostWithParams:nil apiPath:apiPath callBackBlock:^(id responseObject) {
        
        PetsModel *pets = nil;
        if ([responseObject objectForKey:@"code"] && [[responseObject objectForKey:@"code"] integerValue] == 0) {
            pets = [[PetsModel alloc] initWithDictionary:[responseObject objectForKey:@"data"] error:nil];
        }
        callBackBlock(pets);
        
    }];
    
    
}

- (void)getAllPetsWithCallBackBlock:(void(^)(NSArray *allPets))callBackBlock {
    
    UserModel *userModel = [LoginService currentUser];
    if (!userModel) {
        callBackBlock(nil);
    }
    
    NSDictionary *params = @{@"userId":userModel.userId};
    DefineWeakSelf;
    [[PeerNetworkManager shareInstance] securePostWithParams:params apiPath:AllPetsPath callBackBlock:^(id responseObject) {
        DefineStrongSelf;
        [strongSelf commomResolveWithResponseData:responseObject callBackBlock:callBackBlock];
    }];
    
}

- (void)getAllPetsWithMomentsCount:(NSInteger)momentsCount callBackBlock:(void (^)(NSArray *))callBackBlock {
    
    UserModel *userModel = [LoginService currentUser];
    if (!userModel) {
        callBackBlock(nil);
    }
    NSDictionary *params = @{@"userId":userModel.userId,@"momentsCount":@(momentsCount)};
    DefineWeakSelf;
    [[PeerNetworkManager manager] securePostWithParams:params apiPath:AllPetsAndMomentsPath callBackBlock:^(id responseObject) {
        DefineStrongSelf;
        [strongSelf commomResolveWithResponseData:responseObject callBackBlock:callBackBlock];
    }];
    
    
}


#pragma mark - -- Common method

- (NSArray *)makePetsModelArrayWithResponseData:(NSDictionary *)responseData {
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[[responseData objectForKey:@"data"] count]];
    for (NSDictionary *dic in [responseData objectForKey:@"data"]) {
        PetsModel *pets = [[PetsModel alloc] initWithDictionary:dic error:nil];
        [mutableArray addObject:pets];
    }
    return [mutableArray copy];
    
}

- (void)commomResolveWithResponseData:(NSDictionary *)responseObject callBackBlock:(void (^)(NSArray *))callBackBlock {
    if ([responseObject objectForKey:@"code"] && [[responseObject objectForKey:@"code"] integerValue] == 0) {
        
        NSArray *petsArray = [self makePetsModelArrayWithResponseData:responseObject];
        if ([petsArray count]) {
            callBackBlock(petsArray);
        } else {
            callBackBlock(nil);
        }
        
    } else {
        callBackBlock(nil);
    }
}

@end

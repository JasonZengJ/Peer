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

#define AddPetsPath            @"v1/pets/add-pets"
#define GetPetsByIdPath        @"v1/pets/pets-by-id"
#define GetAllPetsPath         @"v1/pets/all-pets"
#define GetPetsWithBreedIdPath @"v1/pets/pets-with-breed-id"
#define LikePetsPath           @"v1/pets/like-pets"
#define FollowPetsPath         @"v1/pets/follow-pets"


@implementation PetsService


- (void)likePetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock {
    [[PeerNetworkManager shareInstance] postWithParams:@{@"userId":userId,@"petsId":petsId} apiPath:LikePetsPath callBackBlock:^(id responseObject) {
        if (![[responseObject objectForKey:@"code"] integerValue]) {
            callBackBlock(true);
        } else {
            callBackBlock(false);
        }
    }];
}

- (void)followPetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock {
    
    [[PeerNetworkManager shareInstance] postWithParams:@{@"userId":userId,@"petsId":petsId} apiPath:FollowPetsPath callBackBlock:^(id responseObject) {
        if (![[responseObject objectForKey:@"code"] integerValue]) {
            callBackBlock(true);
        } else {
            callBackBlock(false);
        }
    }];
    
}

- (void)getPetsArrayWithBreedId:(NSNumber *)breedId callBackBlock:(void (^)(NSArray *petsArray))callBackBlock {
    
    [[PeerNetworkManager shareInstance] postWithParams:@{@"breedId":breedId} apiPath:GetPetsWithBreedIdPath callBackBlock:^(id responseObject) {
        
        if ([responseObject objectForKey:@"code"] == 0) {
            
            NSArray *petsArray = [self makePetsModelArrayWithResponseData:responseObject];
            if ([petsArray count]) {
                callBackBlock(petsArray);
            } else {
                callBackBlock(nil);
            }
            
        } else {
            callBackBlock(nil);
        }
        
        
    }];
    
}


- (void)getPetWithPetsId:(NSNumber *)petsId callBackBlock:(void(^)(PetsModel *pets))callBackBlock {
    
    NSString *apiPath = [NSString stringWithFormat:@"%@/%@",GetPetsByIdPath,petsId];
    [[PeerNetworkManager shareInstance] postWithParams:nil apiPath:apiPath callBackBlock:^(id responseObject) {
        
        PetsModel *pets = nil;
        if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
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
    
    NSDictionary *params = @{@"userId":userModel.id};
    [[PeerNetworkManager shareInstance] postWithParams:params apiPath:GetAllPetsPath callBackBlock:^(id responseObject) {
        
        if ([responseObject objectForKey:@"code"] == 0) {
            
            NSArray *petsArray = [self makePetsModelArrayWithResponseData:responseObject];
            
            if ([petsArray count]) {
                callBackBlock(petsArray);
            } else {
                callBackBlock(nil);
            }
            
        } else {
            callBackBlock(nil);
        }
        
    }];
    
}

- (void)addOrUpdatePets:(PetsModel *)petsModel callBack:(void(^)(NSDictionary* responseObject))callBackBlock {
    
    NSDictionary *params = [petsModel toDictionary];
    [[PeerNetworkManager shareInstance] postWithParams:params apiPath:AddPetsPath callBackBlock:^(id responseObject) {
        callBackBlock(responseObject);
    }];
    
}


- (NSArray *)makePetsModelArrayWithResponseData:(NSDictionary *)responseData {
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[[responseData objectForKey:@"data"] count]];
    for (NSDictionary *dic in [responseData objectForKey:@"data"]) {
        PetsModel *pets = [[PetsModel alloc] initWithDictionary:dic error:nil];
        [mutableArray addObject:pets];
    }
    return [mutableArray copy];
    
}

@end

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

#define AddPetsPath @"v1/add-pets"
#define GetPetsByIdPath @"v1/pets-by-id"
#define GetAllPetsPath @"v1/all-pets"


@implementation PetsService


- (void)getPetsWithPetsId:(NSNumber *)petsId callBackBlock:(void(^)(PetsModel *pets))callBackBlock {
    
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
            
            NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[[responseObject objectForKey:@"data"] count]];
            for (NSDictionary *dic in [responseObject objectForKey:@"data"]) {
                PetsModel *pets = [[PetsModel alloc] initWithDictionary:dic error:nil];
                [mutableArray addObject:pets];
            }
            if ([mutableArray count]) {
                callBackBlock([mutableArray copy]);
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

@end

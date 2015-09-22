//
//  PetsService.m
//  Peer
//
//  Created by jason on 9/22/15.
//  Copyright (c) 2015 peers. All rights reserved.
//

#import "PetsService.h"
#import "PeerNetworkManager.h"
#import "PetsModel.h"

#define AddPetsPath @"v1/pets"

@implementation PetsService


- (void)addPets:(PetsModel *)petsModel callBack:(void(^)(NSDictionary* responseObject))callBackBlock {
    
    NSDictionary *params = [petsModel toDictionary];
    [[PeerNetworkManager shareInstance] postWithParams:params apiPath:AddPetsPath callBackBlock:^(id responseObject) {
        callBackBlock(responseObject);
    }];
    
    
}

@end

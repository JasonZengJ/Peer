//
//  PetsService.h
//  Peer
//
//  Created by jason on 9/22/15.
//  Copyright (c) 2015 peers. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PetsModel;

@interface PetsService : NSObject


- (void)likePetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock;

- (void)unlikePetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock;

- (void)followPetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock;

- (void)unfollowPetsWithPetsId:(NSString *)petsId userId:(NSString *)userId callBackBlock:(void (^)(bool success))callBackBlock;

- (void)getPetsArrayWithBreedId:(NSNumber *)breedId callBackBlock:(void (^)(NSArray *petsArray))callBackBlock;

- (void)getPetWithPetsId:(NSNumber *)petsId callBackBlock:(void(^)(PetsModel *pets))callBackBlock;

- (void)getAllPetsWithCallBackBlock:(void(^)(NSArray* allPets))callBackBlock;

- (void)addOrUpdatePets:(PetsModel *)petsModel callBack:(void(^)(NSDictionary* responseObject))callBackBlock;

@end

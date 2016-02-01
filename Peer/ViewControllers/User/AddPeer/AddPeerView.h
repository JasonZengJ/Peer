//
//  AddPeerView.h
//  Peer
//
//  Created by jason on 1/31/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AddPeer) {
    AddPeerNickname = 1,
    AddPeerSex,
    AddPeerBirth,
    AddPeerSpecies,
    AddPeerBreed,
};

typedef NS_ENUM(NSInteger,PetsSex) {
    PetsSexBoy = 1,
    PetsSexGirl,
};

@protocol AddPeerViewDelegate <NSObject>

- (void)clickedDoneButton;

@optional
- (void)tapCellWithCellTag:(NSInteger)tag;

@end

@interface AddPeerView : UIView

@property(nonatomic,weak)id<AddPeerViewDelegate> delegate;

- (void)setNickName:(NSString *)nickName;
- (void)setSex:(NSInteger)sex;
- (void)setBirth:(NSString *)birth;
- (void)setSpecies:(NSString *)species;
- (void)setBreed:(NSString *)breed;

@end

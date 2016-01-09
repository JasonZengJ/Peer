//
//  HomeBottomView.h
//  Peer
//
//  Created by jason on 15/10/18.
//  Copyright © 2015年 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeBottomViewDelegate <NSObject>

- (void)tapUserInfo;
- (void)tapSendMoment;

@end

@interface HomeBottomView : UIView


@property(nonatomic,weak) id<HomeBottomViewDelegate> delegate;

@end

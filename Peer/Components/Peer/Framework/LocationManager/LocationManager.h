//
//  LocationManager.h
//  WeatherApp
//
//  Created by jason on 8/26/15.
//  Copyright (c) 2015 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

@property (nonatomic) NSString *currentCity;

+ (LocationManager *)sharedLocationManager;

+ (BOOL)canLocate;

- (void)locateCurrentCityWithLocateCompletionBlock:(void (^)(NSString *currentCity))locateCompletionBlock;

@end

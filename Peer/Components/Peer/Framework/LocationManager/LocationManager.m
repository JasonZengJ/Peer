//
//  LocationManager.m
//  WeatherApp
//
//  Created by jason on 8/26/15.
//  Copyright (c) 2015 jason. All rights reserved.
//

#import "LocationManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *cLLocationManager;
@property (nonatomic,copy) void(^locateCompletionBlock)(NSString *currentCity);

@end

@implementation LocationManager

+ (LocationManager *)sharedLocationManager
{
    static dispatch_once_t onceToken;
    static LocationManager *locationManager;
    dispatch_once(&onceToken, ^{
        locationManager = [[LocationManager alloc] init];
    });
    
    return locationManager;
}

- (CLLocationManager *)cLLocationManager
{
    if (!_cLLocationManager) {
        _cLLocationManager = [[CLLocationManager alloc] init];
        _cLLocationManager.delegate = self;
        _cLLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _cLLocationManager.distanceFilter  = kCLDistanceFilterNone;
    }
    return _cLLocationManager;
}

+ (BOOL)canLocate {
    return [CLLocationManager locationServicesEnabled] && [LocationManager sharedLocationManager].currentCity && ![[LocationManager sharedLocationManager].currentCity isEqualToString:@""];
}

- (void)locateCurrentCityWithLocateCompletionBlock:(void (^)(NSString *currentCity))locateCompletionBlock
{
    if (self.currentCity) {
        locateCompletionBlock(self.currentCity);
        return;
    }
    self.locateCompletionBlock = locateCompletionBlock;
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.cLLocationManager requestAlwaysAuthorization];
        [self.cLLocationManager startUpdatingLocation];
    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"home_cannot_locate", comment:@"无法进行定位") message:NSLocalizedString(@"home_cannot_locate_message", comment:@"请检查您的设备是否开启定位功能") delegate:self cancelButtonTitle:NSLocalizedString(@"common_confirm",comment:@"确定") otherButtonTitles:nil, nil];
//        
//
//        
//        [alert show];
        NSLog(@"无法进行定位，请检查设备是否开启定位功能");
        locateCompletionBlock(nil);
    }
}


#pragma mark - -- CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    if (self.locateCompletionBlock) {
        self.locateCompletionBlock(nil);
    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"pause update");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            // ? placeMark.locality : placeMark.administrativeArea;
            if (!self.currentCity) {
                self.currentCity = NSLocalizedString(@"home_cannot_locate_city", comment:@"无法定位当前城市");
            }
            // 获取城市信息后, 异步更新界面信息.
            dispatch_async(dispatch_get_main_queue(), ^{
                self.locateCompletionBlock(self.currentCity);
            });
    
        } else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error returned");
        } else if (error) {
            NSLog(@"Location error: %@", error);
        }
     }];
    
    [manager stopUpdatingLocation];
}

@end










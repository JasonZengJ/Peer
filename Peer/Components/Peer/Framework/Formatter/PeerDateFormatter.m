//
//  PeerDateFormatter.m
//  Peer
//
//  Created by jason on 10/27/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PeerDateFormatter.h"

@interface PeerDateFormatter ()

@property(nonatomic)NSCalendar *calendar;
@property(nonatomic)NSDateFormatter *dateFormatter;
@property(nonatomic)NSDateComponents *dateComponents;

@end

@implementation PeerDateFormatter


+ (PeerDateFormatter *)shareInstance {
    
    static dispatch_once_t onceToken;
    static PeerDateFormatter *peerDateFormatter;
    dispatch_once(&onceToken, ^{
        peerDateFormatter = [[PeerDateFormatter alloc] init];
    });
    
    return peerDateFormatter;
    
}

- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _dateFormatter;
}

- (NSDateComponents *)dateComponents {
    if (!_dateComponents) {
        _dateComponents = [[NSDateComponents alloc] init];
    }
    return _dateComponents;
}

- (void)formateDateString:(NSString *)dateString {
    
    NSDate *date        = [self.dateFormatter dateFromString:dateString];
    NSInteger unitFlags =  NSCalendarUnitMonth | NSCalendarUnitDay;
    self.dateComponents = [self.calendar components:unitFlags fromDate:date];
    
}

- (NSInteger)day {
    return self.dateComponents.day;
}

- (NSInteger)month {
    return self.dateComponents.month;
}

@end

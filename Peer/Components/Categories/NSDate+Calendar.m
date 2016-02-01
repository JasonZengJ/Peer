//
//  NSDate+Calendar.m
//  Peer
//
//  Created by jason on 1/31/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)


+ (NSInteger)currentYear {
    
    return [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]];
	
}
@end

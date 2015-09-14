//
//  NSData+JSON.m
//  WeatherApp
//
//  Created by jason on 8/26/15.
//  Copyright (c) 2015 jason. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (NSDictionary *)jsonObject
{
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    
    if (error) {
        return nil;
    } else {
        return jsonObject;
    }
    
}

@end

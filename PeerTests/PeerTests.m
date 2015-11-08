//
//  PeerTests.m
//  PeerTests
//
//  Created by jason on 8/15/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface PeerTests : XCTestCase

@end

@implementation PeerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
//    DLog(@"test setup");
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadingAddress {
    
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Address_CN" withExtension:@"plist"];
   
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:url];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths[0] stringByAppendingPathComponent:@"address.plist"];
    
    NSURL *fileUlr = [NSURL URLWithString:path];
    [dic writeToURL:fileUlr atomically:YES];
    
//    NSLog(@"%@",dic);
    
    
    
}

//- (void)testTranslateCNToEn {
//    
//    
//    
//    
//}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

//
//  LoginServiceTest.m
//  Peer
//
//  Created by jason on 9/18/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginService.h"



@interface LoginServiceTest : XCTestCase

@property(nonatomic)LoginService *loginService;

@end

@implementation LoginServiceTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.loginService = [[LoginService alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testCheckPhoneNumber {
    
    NSString *phoneNumber = @"";
    BOOL result = [self.loginService checkPhoneNumber:phoneNumber];
    XCTAssert(result,@"Pass");
    
    
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

//
//  BBC_Test_AppTests.m
//  BBC Test AppTests
//
//  Created by Omer Janjua on 18/01/2015.
//  Copyright (c) 2015 Omer Janjua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BBC_Test_AppTests : XCTestCase

@end

@implementation BBC_Test_AppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

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

- (void)testAsynchronousBlockCallback
{
    // asynchronous block callback was called expectation
    XCTestExpectation *expectation = [self expectationWithDescription:@"HTTP request"];
    
    // setup asynchronous block callback
    NSURL *url = [NSURL URLWithString:@"sdghttps://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task
    = [session dataTaskWithURL:url
             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                 /* fulfill asynchronous block callback was called expectation
                  causes -waitForExpectationsWithTimeout:handler: to stop waiting */
                 [expectation fulfill];
             }];
    
    // call asynchronous method
    [task resume];
    
    /* wait for the asynchronous block callback was called expectation to be fulfilled
     fail after 5 seconds */
    [self waitForExpectationsWithTimeout:5
                                 handler:^(NSError *error) {
                                     // handler is called on _either_ success or failure
                                     if (error != nil) {
                                         XCTFail(@"timeout error: %@", error);
                                     }
                                 }];
}

@end

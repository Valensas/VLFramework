//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Deniz Adalar on 15/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "VLTestCase.h"
#import <AFNetworking.h>

static NSData * AFJSONTestData() {
    return [NSJSONSerialization dataWithJSONObject:@{@"foo": @"bar"} options:0 error:nil];
}

@interface ExampleTests : VLTestCase

@end

@implementation ExampleTests

- (void)testExample
{
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:self.baseURL statusCode:200 HTTPVersion:@"1.1" headerFields:@{@"Content-Type": @"application/json"}];
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    NSError *error = nil;
    [serializer validateResponse:response data:AFJSONTestData() error:&error];
    
    XCTAssertNil(error, @"Error handling application/json");
}

- (void)testExample2
{
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:self.baseURL statusCode:200 HTTPVersion:@"1.1" headerFields:@{@"Content-Type": @"application/json"}];
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    NSError *error = nil;
    [serializer validateResponse:response data:AFJSONTestData() error:&error];
    
    XCTAssertNil(error, @"Error handling application/json");
}

@end

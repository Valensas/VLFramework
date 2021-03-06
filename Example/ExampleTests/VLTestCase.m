// AFTestCase.m
//
// Copyright (c) 2013 AFNetworking (http://afnetworking.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VLTestCase.h"
#import "TestRequest.h"
#import <AFNetworking.h>
#import <OCMockObject.h>

NSString * const VLNetworkingTestsBaseURLString = @"https://httpbin.org/";

@implementation VLTestCase

- (void)setUp {
    [super setUp];

    [Expecta setAsynchronousTestTimeout:5.0];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark -

- (void)testBasicJastorMapping {
    TestRequest *request = [TestRequest new];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer new];
    serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    request.operationManager.responseSerializer = serializer;
    AFHTTPRequestOperation *operation = request.operation;
    
    __block id blockResponseObject = nil;
    __block id blockError = nil;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        blockError = error;
    }];
    
    [operation start];

    expect([operation isFinished]).will.beTruthy();
    expect(blockError).will.beNil();
    expect(blockResponseObject).willNot.beNil;
    expect(blockResponseObject).will.beInstanceOf([TestResponse class]);
}

- (void)testCorruptData {
    TestRequest *request = [TestRequest new];
    
    OCMockObject *mockRequest = [OCMockObject partialMockForObject:request];
    [[[mockRequest stub] andReturn:@"https://rawgithub.com/Valensas/VLFramework/master/Example/Resources/corrupt.json"] path];
    
    
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer new];
    serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    request.operationManager.responseSerializer = serializer;
    AFHTTPRequestOperation *operation = request.operation;
    
    __block id blockResponseObject = nil;
    __block id blockError = nil;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        blockResponseObject = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        blockError = error;
    }];
    
    [operation start];
    
    expect([operation isFinished]).will.beTruthy();
    expect(blockError).willNot.beNil();
    expect(blockResponseObject).will.beNil;
}

@end

//
//  VLViewController.m
//  Example
//
//  Created by Deniz Adalar on 16/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <VLFramework/VLFramework.h>

#define EXP_SHORTHAND
#import <Expecta.h>


@interface VLViewControllerTests : XCTestCase

@property (nonatomic, strong) UIViewController *vc;

@end

@implementation VLViewControllerTests

- (void)setUp
{
    [super setUp];

    self.vc = [[UIViewController alloc] initWithCoder:nil];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testIsRefreshing
{
    self.vc._vl_isRefreshingData = true;
    expect(self.vc._vl_isRefreshingData).to.equal(true);
    self.vc._vl_isRefreshingData = false;
    expect(self.vc._vl_isRefreshingData).to.equal(false);
}
- (void)testRedisplayNeeded
{
    self.vc._vl_redisplayNeeded = true;
    expect(self.vc._vl_redisplayNeeded).to.equal(true);
    self.vc._vl_redisplayNeeded = false;
    expect(self.vc._vl_redisplayNeeded).to.equal(false);
}
- (void)testRefreshNeeded
{
    self.vc._vl_refreshNeeded = true;
    expect(self.vc._vl_refreshNeeded).to.equal(true);
    self.vc._vl_refreshNeeded = false;
    expect(self.vc._vl_refreshNeeded).to.equal(false);
}

@end

//
//  TestRequest.m
//  Example
//
//  Created by Deniz Adalar on 16/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "TestRequest.h"
#import <VLFramework/VLResponse.h>

@implementation TestRequest

-(NSString *)path {
    return @"https://github.com/Valensas/VLFramework/raw/master/Example/Resources/test.json";
}
-(NSString *)method {
    return @"GET";
}
-(Class)responseClass {
    return [TestResponse class];
}

@end

//
//  TestResponse.h
//  Example
//
//  Created by Deniz Adalar on 16/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "VLResponse.h"
#import "TestInnerObject.h"

@interface TestResponse : VLResponse

@property (nonatomic, strong) NSString *foo;
@property (nonatomic) CGFloat floatValue;
@property (nonatomic, strong) TestInnerObject *obj;
@property (nonatomic, strong) NSArray *dictArray;

@end

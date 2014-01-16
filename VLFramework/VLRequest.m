//
//  VLViewController.m
//  VLFramework
//
//  Created by Deniz Adalar on 15/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "VLRequest.h"

@implementation VLRequest
-(Class)responseClass {
    return nil;
}
-(NSString *)method {
    return nil;
}
-(NSString *)path {
    return nil;
}
-(NSMutableDictionary *)toDictionary {
    NSMutableDictionary *dict = [super toDictionary];
    [dict removeObjectForKey:@"extraParams"];
    [dict setValuesForKeysWithDictionary:self.extraParams];
    return dict;
}
@end

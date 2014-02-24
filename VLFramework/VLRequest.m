//
//  VLViewController.m
//  VLFramework
//
//  Created by Deniz Adalar on 15/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "VLRequest.h"
#import "AFNetworking.h"
#import "VLResponseSerializer.h"

@implementation VLRequest
-(Class)responseClass {
    return [VLResponse class];
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
-(AFHTTPRequestOperationManager *)operationManager {
    return [self.class defaultOperationManager];
}
-(AFHTTPRequestOperation *)operation {
    AFHTTPRequestOperationManager *manager = [self operationManager];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:self.method URLString:[[NSURL URLWithString:self.path relativeToURL:manager.baseURL] absoluteString] parameters:self.toDictionary];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:nil failure:nil];
    operation.responseSerializer = [VLResponseSerializer newWithOtherSerializer:operation.responseSerializer request:self];
    
    return operation;
}

static AFHTTPRequestOperationManager *defaultManager = nil;
+(void)load {
    //Can be assigned on other class' load method. So, if it's not null don't assign default manager.
    if (defaultManager == nil) {
        defaultManager = [AFHTTPRequestOperationManager manager];
    }
}
+(void)setDefaultOperationManager:(AFHTTPRequestOperationManager *)manager {
    defaultManager = manager;
}
+(AFHTTPRequestOperationManager *)defaultOperationManager {
    return defaultManager;
}

@end

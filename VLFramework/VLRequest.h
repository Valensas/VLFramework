//
//  VLViewController.m
//  VLFramework
//
//  Created by Deniz Adalar on 15/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "Jastor.h"
#import "VLResponse.h"
#import "AFNetworking.h"

@interface VLRequest : Jastor

@property (nonatomic, strong) NSDictionary *extraParams;

-(Class)responseClass;
-(NSString*)method;
-(NSString*)path;

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;
@property (nonatomic) Class serializerClass;

+(AFHTTPRequestOperationManager*)defaultOperationManager;
+(void)setDefaultOperationManager:(AFHTTPRequestOperationManager*)manager;
+(void)setDefaultSerializerClass:(Class)class;
+(Class)defaultSerializerClass;

-(AFHTTPRequestOperationManager*)operationManager;
-(AFHTTPRequestOperation*)operation;

@end

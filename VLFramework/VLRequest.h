//
//  VLViewController.m
//  VLFramework
//
//  Created by Deniz Adalar on 15/01/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "Jastor.h"

@interface VLRequest : Jastor

@property (nonatomic, strong) NSDictionary *extraParams;

-(Class)responseClass;
-(NSString*)method;
-(NSString*)path;

//test

@end

//
//  VLFramework.m
//  Pods
//
//  Created by Deniz Adalar on 16/01/14.
//
//

#import "VLFramework.h"
#import "JRSwizzle.h"
#import "UIViewController+VLFramework.h"

@implementation VLFramework

+(void)load {
    [UIViewController jr_swizzleMethod:@selector(viewDidLoad) withMethod:@selector(_vl_viewDidLoad) error:nil];
    [UIViewController jr_swizzleMethod:@selector(initWithCoder:) withMethod:@selector(_vl_initWithCoder:) error:nil];
    [UIViewController jr_swizzleMethod:@selector(initWithNibName:bundle:) withMethod:@selector(_vl_initWithNibName:bundle:) error:nil];
    [UIViewController jr_swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(_vl_viewWillAppear:) error:nil];
    [UIViewController jr_swizzleMethod:@selector(viewWillDisappear:) withMethod:@selector(_vl_viewWillDisappear:) error:nil];
}

@end

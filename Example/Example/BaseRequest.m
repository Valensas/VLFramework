//
//  BaseRequest.m
//  Example
//
//  Created by Deniz Adalar on 06/03/14.
//  Copyright (c) 2014 Valensas. All rights reserved.
//

#import "BaseRequest.h"
#import <UIAlertView+AFNetworking.h>

@implementation BaseRequest

-(AFHTTPRequestOperation *)operation {
    AFHTTPRequestOperation *operation = [super operation];
    [self addStartObserver:operation];
    [self addFinishObserver:operation];
    return operation;
}

- (void)addStartObserver:(AFURLConnectionOperation *)operation
{
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:AFNetworkingOperationDidStartNotification object:operation queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        
        if (notification.object && [notification.object isKindOfClass:[AFURLConnectionOperation class]]) {
            [self.class showLoadingView];
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer name:AFNetworkingOperationDidStartNotification object:notification.object];
    }];
}


- (void)addFinishObserver:(AFURLConnectionOperation *)operation
{
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:AFNetworkingOperationDidFinishNotification object:operation queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        
        if (notification.object && [notification.object isKindOfClass:[AFURLConnectionOperation class]]) {
            [self.class hideLoadingView];
            
            if ([notification.object isKindOfClass:[AFHTTPRequestOperation class]]) {
                [(AFHTTPRequestOperation *)notification.object responseObject];
            }
            
            NSError *error = [(AFURLConnectionOperation *)notification.object error];
            if (error) {
                NSString *title, *message;
                AFGetAlertViewTitleAndMessageFromError(error, &title, &message);
                
                [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
            }
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer name:AFNetworkingOperationDidFinishNotification object:notification.object];
    }];
}

static int loadingViewRetainCount = 0;
+(void)showLoadingView {
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (loadingViewRetainCount++ == 0) {
            UIWindow *w = [[[UIApplication sharedApplication] delegate] window];
            UIView *view = [[UIView alloc] initWithFrame:w.bounds];
            view.tag = 21350987;
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.25];
            
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [activityIndicator setCenter:CGPointMake((view.frame.size.width/2)-20, view.frame.size.height/2)];
            [activityIndicator startAnimating];
            [view addSubview:activityIndicator];
            [w addSubview:view];
        }
    });
}

+(void)hideLoadingView {
    if (--loadingViewRetainCount <= 0) {
        UIWindow *w = [[[UIApplication sharedApplication] delegate] window];
        UIView *view = [w viewWithTag:21350987];
        view.tag = 21350988;
        [view removeFromSuperview];
    }
}


static void AFGetAlertViewTitleAndMessageFromError(NSError *error, NSString * __autoreleasing *title, NSString * __autoreleasing *message) {
    if (error.localizedDescription && (error.localizedRecoverySuggestion || error.localizedFailureReason)) {
        *title = error.localizedDescription;
        
        if (error.localizedRecoverySuggestion) {
            *message = error.localizedRecoverySuggestion;
        } else {
            *message = error.localizedFailureReason;
        }
    } else if (error.localizedDescription) {
        *title = NSLocalizedStringFromTable(@"Error", @"AFNetworking", @"Fallback Error Description");
        *message = error.localizedDescription;
    } else {
        *title = NSLocalizedStringFromTable(@"Error", @"AFNetworking", @"Fallback Error Description");
        *message = [NSString stringWithFormat:NSLocalizedStringFromTable(@"%@ Error: %lu", @"AFNetworking", @"Fallback Error Failure Reason Format"), error.domain, (NSUInteger)error.code];
    }
}


@end

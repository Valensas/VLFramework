//
//  UIViewController+VLFramework.m
//  Pods
//
//  Created by Deniz Adalar on 16/01/14.
//
//

#import "UIViewController+VLFramework.h"
#import "UIViewController+Private.h"
#import <objc/runtime.h>

static char vlDataKey;
static char vlRedisplayNeededKey;
static char vlRefreshNeededKey;
static char vlIsRefreshingNeededKey;

@implementation UIViewController (VLFramework)

-(void)setNeedsRefreshData {
    if ([self respondsToSelector:@selector(mainRequest)] && !self._vl_isRefreshingData) {
		self._vl_isRefreshingData = TRUE;
		
		//download data
		AFHTTPRequestOperation *operation = [self mainRequest];
		if (operation == nil) { //we may use this page without internet connection
			self._vl_isRefreshingData = FALSE;
            if ([self respondsToSelector:@selector(displayData:)]) {
                [self displayData:self.vl_data];
            }
            return;
		}

        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *_operation, id responseObject) {
            self._vl_isRefreshingData = FALSE;
            
            self.vl_data = responseObject;
            
            if ([self respondsToSelector:@selector(mainRequestDone:)]) {
                [self mainRequestDone:_operation];
            }
            
            [self setNeedsDisplayData];
            
        } failure:^(AFHTTPRequestOperation *_operation, NSError *error) {
            self._vl_isRefreshingData = FALSE;

            if ([self respondsToSelector:@selector(mainRequestWentWrong:)]) {
                [self mainRequestWentWrong:_operation];
            }
        }];
        
        if ([self respondsToSelector:@selector(mainRequestStarted:)]) {
            [self mainRequestStarted:operation];
        }
        
        
        [operation start];

    }
}
-(void)setNeedsDisplayData
{
	if (self.vl_data == nil) { //We don't have the data, so first get it
		[self setNeedsRefreshData];
	} else { //We already have data, so just display them
		if (self.view == nil) { //If this view is not on screen, display later when it appears
			self._vl_redisplayNeeded = YES;
		} else {
            if ([self respondsToSelector:@selector(displayData:)]) {
                [self displayData:self.vl_data];
            }
            self._vl_redisplayNeeded = NO;
		}
	}
}

-(void)_vl_init {
    
}
-(void)_vl_viewDidLoad {
    [self _vl_viewDidLoad];
    
}
-(void)_vl_viewWillAppear:(BOOL)animated {
    [self _vl_viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_vl_keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_vl_keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_vl_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_vl_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (self.vl_data == nil) {
        self._vl_redisplayNeeded = YES;
    }
	if (self._vl_redisplayNeeded) {
        [self setNeedsDisplayData];
	}
}

-(void)_vl_viewWillDisappear:(BOOL)animated {
    [self _vl_viewWillDisappear:animated];
}

-(void)_vl_viewDidAppear:(BOOL)animated {
    [self _vl_viewDidAppear:animated];
}

-(void)_vl_viewDidDisappear:(BOOL)animated {
    [self _vl_viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark Dummy methods

- (void)_vl_keyboardDidShow:(NSNotification*)aNotification {
    if ([self respondsToSelector:@selector(vl_keyboardDidShow:)]) {
        [self vl_keyboardDidShow:aNotification];
    }
}
- (void)_vl_keyboardDidHide:(NSNotification*)aNotification {
    if ([self respondsToSelector:@selector(vl_keyboardDidHide:)]) {
        [self vl_keyboardDidHide:aNotification];
    }
    
}
- (void)_vl_keyboardWillShow:(NSNotification *)aNotification {
    if ([self respondsToSelector:@selector(vl_keyboardWillShow:)]) {
        [self vl_keyboardWillShow:aNotification];
    }
    
}
- (void)_vl_keyboardWillHide:(NSNotification *)aNotification {
    if ([self respondsToSelector:@selector(vl_keyboardWillHide:)]) {
        [self vl_keyboardWillHide:aNotification];
    }
    
}


#pragma mark Swizzling methods
-(id)_vl_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    id obj = [self _vl_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [obj _vl_init];
    return obj;
}
-(id)_vl_initWithCoder:(NSCoder *)aDecoder {
    id obj = [self _vl_initWithCoder:aDecoder];
    [obj _vl_init];
    return obj;
}
-(void)setVl_data:(id)vl_data {
    objc_setAssociatedObject(self, &vlDataKey, vl_data, OBJC_ASSOCIATION_RETAIN);
}
-(id)vl_data {
    return objc_getAssociatedObject(self, &vlDataKey);
}
-(void)set_vl_redisplayNeeded:(BOOL)redisplayNeeded {
    objc_setAssociatedObject(self, &vlRedisplayNeededKey, @(redisplayNeeded), OBJC_ASSOCIATION_COPY);
}
-(BOOL)_vl_redisplayNeeded {
    return [objc_getAssociatedObject(self, &vlRedisplayNeededKey) boolValue];
}
-(void)set_vl_refreshNeeded:(BOOL)refreshNeeded {
    objc_setAssociatedObject(self, &vlRefreshNeededKey, @(refreshNeeded), OBJC_ASSOCIATION_COPY);
}
-(BOOL)_vl_refreshNeeded {
    NSNumber *a = objc_getAssociatedObject(self, &vlRefreshNeededKey);
    return [a boolValue];
}
-(void)set_vl_isRefreshingData:(BOOL)_vl_isRefreshingData {
    objc_setAssociatedObject(self, &vlIsRefreshingNeededKey, @(_vl_isRefreshingData), OBJC_ASSOCIATION_COPY);
}
-(BOOL)_vl_isRefreshingData {
    return [objc_getAssociatedObject(self, &vlIsRefreshingNeededKey) boolValue];
}
@end

//
//  UIViewController+VLFramework.h
//  Pods
//
//  Created by Deniz Adalar on 16/01/14.
//
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface UIViewController (VLFramework)

@property (nonatomic, strong) id vl_data;
//@property (nonatomic) BOOL showsLoading;
//@property (nonatomic) BOOL preventsTapGesture;
//@property (nonatomic) BOOL isRefreshingData;

-(void)setNeedsRefreshData:(BOOL)ignoreCache;
-(void)setNeedsDisplayData;
-(void)displayData:(id)data;

-(AFHTTPRequestOperation*)mainRequest;
-(void)mainRequestStarted:(AFHTTPRequestOperation *)request;
-(void)mainRequestDone:(AFHTTPRequestOperation *)request;
-(void)mainRequestWentWrong:(AFHTTPRequestOperation *)request;

- (void)vl_keyboardDidShow:(NSNotification*)aNotification;
- (void)vl_keyboardDidHide:(NSNotification*)aNotification;
- (void)vl_keyboardWillShow:(NSNotification *)aNotification;
- (void)vl_keyboardWillHide:(NSNotification *)aNotification;



//private

-(void)_vl_viewDidLoad;
-(void)_vl_viewWillAppear:(BOOL)animated;
-(void)_vl_viewWillDisappear:(BOOL)animated;
-(id)_vl_initWithCoder:(NSCoder *)aDecoder;
-(id)_vl_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@property (nonatomic) BOOL _vl_refreshNeeded;
@property (nonatomic) BOOL _vl_redisplayNeeded;
@property (nonatomic) BOOL _vl_isRefreshingData;

@end

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

@property (nonatomic, strong) id data;
//@property (nonatomic) BOOL showsLoading;
//@property (nonatomic) BOOL preventsTapGesture;
//@property (nonatomic) BOOL isRefreshingData;

-(void)setNeedsRefreshData:(BOOL)ignoreCache;
-(void)setNeedsDisplayData;
-(void)displayData;

-(AFHTTPRequestOperation*)mainRequest;
-(void)mainRequestStarted:(AFHTTPRequestOperation *)request;
-(void)mainRequestDone:(AFHTTPRequestOperation *)request;
-(void)mainRequestWentWrong:(AFHTTPRequestOperation *)request;

//-(UIView*)findFirstResponder:(UIView*)parentView;
//- (void)keyboardDidShow:(NSNotification*)aNotification;
//- (void)keyboardDidHide:(NSNotification*)aNotification;
//- (void)keyboardWillShow:(NSNotification *)aNotification;
//- (void)keyboardWillHide:(NSNotification *)aNotification;



//private

-(void)_vl_viewDidLoad;
-(void)_vl_viewWillAppear:(BOOL)animated;
-(id)_vl_initWithCoder:(NSCoder *)aDecoder;
-(id)_vl_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@property (nonatomic) BOOL _vl_refreshNeeded;
@property (nonatomic) BOOL _vl_redisplayNeeded;
@property (nonatomic) BOOL _vl_isRefreshingData;

@end

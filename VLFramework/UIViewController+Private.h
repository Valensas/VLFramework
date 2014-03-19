//
//  UIViewController+Private.h
//  Pods
//
//  Created by Deniz Adalar on 22/01/14.
//
//

@interface UIViewController (VLPrivate)

-(void)_vl_viewDidLoad;
-(void)_vl_viewWillAppear:(BOOL)animated;
-(void)_vl_viewWillDisappear:(BOOL)animated;
-(void)_vl_viewDidAppear:(BOOL)animated;
-(void)_vl_viewDidDisappear:(BOOL)animated;
-(id)_vl_initWithCoder:(NSCoder *)aDecoder;
-(id)_vl_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@property (nonatomic) BOOL _vl_refreshNeeded;
@property (nonatomic) BOOL _vl_redisplayNeeded;
@property (nonatomic) BOOL _vl_isRefreshingData;

@end

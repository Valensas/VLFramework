//
//  UIViewController+VLFramework.h
//  Pods
//
//  Created by Deniz Adalar on 16/01/14.
//
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

/**
 *  VLFramework extensions class for UIViewController. UIViewController sends the request and gets the response automatically when its view is appeared (if mainRequest method is implemented). When data is get successfully, it is assigned to vl_data property.
 */
@interface UIViewController (VLFramework)

/**
 *  The response of mainRequest is assigned to this property. Default value is nil.
 */
@property (nonatomic, strong) id vl_data;
//@property (nonatomic) BOOL showsLoading;
//@property (nonatomic) BOOL preventsTapGesture;

/**
 *  Call this method whenever you want to get the data again - which means making a new HTTP request (with mainRequest). You do not need to override this method.
 */
-(void)setNeedsRefreshData;

/**
 *  Call this method whenever you want to display the data again. If there is no data, it will first try to obtain it. You do not need to override this method.
 */
-(void)setNeedsDisplayData;

/**
 *  This method will be called whenever the view should be refreshed according to the data. You should override this method to reflect changes on the data to the view.
 *
 *  @param data Same as vl_data. It is given as a parameter so you can set your class type on your implementation file.
 */
-(void)displayData:(id)data;

/**
 *  A HTTP request attached to the view controller. Override this method so it returns a proper HTTP request object. It will be automatically called by setNeedsRefreshData method.
 *
 *  @return A HTTP request object. If you return nil, no request will be sent. The complectionBlock properties will be replaced, so you don't have to assign them. If you would like to do so, implement mainRequestDone: and mainRequestWentWrong: methods.
 */
-(AFHTTPRequestOperation*)mainRequest;

/**
 *  Called when the mainRequest is started. Override this if you want to do something extra (i.e. showing a loading view). Optional.
 *
 *  @param request mainRequest
 */
-(void)mainRequestStarted:(AFHTTPRequestOperation *)request;

/**
 *  Called when the mainRequest is completed successfully. displayData: is called automatically. Optional.
 *
 *  @param request mainRequest
 */
-(void)mainRequestDone:(AFHTTPRequestOperation *)request;

/**
 *  Called when the mainRequest is completed with an error. vl_data won't be updated and displayData: won't be callaed in case of an error. If you want to do such things, you can override this method. Optional.
 *
 *  @param request mainRequest
 */
-(void)mainRequestWentWrong:(AFHTTPRequestOperation *)request;

/**
 *  Implement this method if you want to get notified about UIKeyboardDidShowNotification events.
 *
 *  @param aNotification [Keyboard Notification User Info Keys](https://developer.apple.com/library/ios/documentation/uikit/reference/UIWindow_Class/UIWindowClassReference/UIWindowClassReference.html)
 */
-(void)vl_keyboardDidShow:(NSNotification*)aNotification;
/**
 *  Implement this method if you want to get notified about UIKeyboardDidHideNotification events.
 *
 *  @param aNotification [Keyboard Notification User Info Keys](https://developer.apple.com/library/ios/documentation/uikit/reference/UIWindow_Class/UIWindowClassReference/UIWindowClassReference.html)
 */
-(void)vl_keyboardDidHide:(NSNotification*)aNotification;
/**
 *  Implement this method if you want to get notified about UIKeyboardWillShowNotification events.
 *
 *  @param aNotification [Keyboard Notification User Info Keys](https://developer.apple.com/library/ios/documentation/uikit/reference/UIWindow_Class/UIWindowClassReference/UIWindowClassReference.html)
 */
-(void)vl_keyboardWillShow:(NSNotification *)aNotification;
/**
 *  Implement this method if you want to get notified about UIKeyboardWillHideNotification events.
 *
 *  @param aNotification [Keyboard Notification User Info Keys](https://developer.apple.com/library/ios/documentation/uikit/reference/UIWindow_Class/UIWindowClassReference/UIWindowClassReference.html)
 */
-(void)vl_keyboardWillHide:(NSNotification *)aNotification;



//private


@end

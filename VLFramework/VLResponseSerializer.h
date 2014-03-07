//
//  AFJastorResponseSerializer.h
//  Pods
//
//  Created by Deniz Adalar on 16/01/14.
//
//

#import "AFURLResponseSerialization.h"
#import "VLRequest.h"

@interface VLResponseSerializer : AFHTTPResponseSerializer

+(VLResponseSerializer*)newWithOtherSerializer:(AFHTTPResponseSerializer*)otherSerializer request:(VLRequest*)request;

/**
 *  Default overridden implementation of AFNetworking's response to object conversion method. Override this on your class to return extra errors based on your response object. Super's implementation will return a VLResponse object if successful.
 *
 *  @param response AFNetworkings's response object.
 *  @param data     AFNetworkings's data object.
 *  @param error    Error object that you can assign to. Check first if there is an error sent by super.
 *
 *  @return A response object that will be returned if there is no error.
 */
-(id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError **)error;


@end

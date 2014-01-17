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

@property (nonatomic, weak) AFHTTPResponseSerializer *otherSerializer;
@property (nonatomic, strong) VLRequest *request;

@end

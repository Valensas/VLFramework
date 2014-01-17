//
//  AFJastorResponseSerializer.m
//  Pods
//
//  Created by Deniz Adalar on 16/01/14.
//
//

#import "VLResponseSerializer.h"

@implementation VLResponseSerializer

+(VLResponseSerializer*)newWithOtherSerializer:(AFHTTPResponseSerializer*)otherSerializer request:(VLRequest *)request {
    VLResponseSerializer *obj = [VLResponseSerializer new];
    obj.otherSerializer = otherSerializer;
    obj.request = request;
    return obj;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    if (anInvocation.selector != @selector(responseObjectForResponse:data:error:)) {
        [anInvocation invokeWithTarget:self.otherSerializer];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

-(id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError **)error {
    id result = [self.otherSerializer responseObjectForResponse:response data:data error:error];
    return [[self.request.responseClass alloc] initWithDictionary:result];
}

@end

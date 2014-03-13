//
//  AFJastorResponseSerializer.m
//  Pods
//
//  Created by Deniz Adalar on 16/01/14.
//
//

#import "VLResponseSerializer.h"

@interface VLResponseSerializer ()

@property (nonatomic, weak) AFHTTPResponseSerializer *otherSerializer;
@property (nonatomic, strong) VLRequest *request;

@end

@implementation VLResponseSerializer

+(instancetype)newWithOtherSerializer:(AFHTTPResponseSerializer*)otherSerializer request:(VLRequest *)request {
    VLResponseSerializer *obj = [self new];
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
    if (*error) {
        return result;
    } else {
        if ([self.request.responseClass isSubclassOfClass:[Jastor class]]) {
            return [[self.request.responseClass alloc] initWithDictionary:result];
        } else {
            *error = [NSError errorWithDomain:@"VLFramework" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Response Class is not a subclass of Jastor."}];
            return nil;
        }
    }
}

@end

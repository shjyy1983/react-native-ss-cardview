//
//  SsCardview.m
//  SsCardview
//
//  Created by SHEN on 2020/9/2.
//  Copyright © 2020 SHEN. All rights reserved.
//

#import "SsCardview.h"
#import "JWT.h"

@implementation SsCardview

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(sign,
    resolver: (RCTPromiseResolveBlock) resolve
    rejecter: (RCTPromiseRejectBlock) reject) {
    resolve(@"Hello world 1");
}

RCT_REMAP_METHOD(decode,
    token: (NSString *) token
    resolver: (RCTPromiseResolveBlock) resolve
    rejecter: (RCTPromiseRejectBlock) reject) {
    resolve(@"Hello world 2");
}

@end

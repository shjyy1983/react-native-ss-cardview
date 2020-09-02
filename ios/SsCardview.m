//
//  SsCardview.m
//  SsCardview
//
//  Created by SHEN on 2020/9/2.
//  Copyright © 2020 SHEN. All rights reserved.
//

#import "SsCardview.h"

RCT_EXPORT_MODULE()

@implementation SsCardview

- (UIView *)view
{
    // TODO: Implement some actually useful functionality
    UILabel * label = [[UILabel alloc] init];
    [label setTextColor:[UIColor redColor]];
    [label setText: @"hello world2"];
    [label sizeToFit];
    UIView * wrapper = [[UIView alloc] init];
    [wrapper addSubview:label];
    return wrapper;
}

@end

#import "SsCardview.h"

@implementation SsCardview

RCT_EXPORT_MODULE()

- (UIView *)view
{
    // TODO: Implement some actually useful functionality
    UILabel * label = [[UILabel alloc] init];
    [label setTextColor:[UIColor redColor]];
    [label setText: @"hello *****"];
    [label sizeToFit];
    UIView * wrapper = [[UIView alloc] init];
    [wrapper addSubview:label];
    return wrapper;
}

@end

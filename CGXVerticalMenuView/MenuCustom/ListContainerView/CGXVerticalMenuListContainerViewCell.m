//
//  CGXVerticalMenuListContainerViewCell.m
//  App
//
//  Created by MacMini-1 on 2021/3/5.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXVerticalMenuListContainerViewCell.h"

@implementation CGXVerticalMenuListContainerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)updateWithCellModel:(id<CGXVerticalMenuListContainerViewDelegate>)list
{
    for (UIView *subview in self.contentView.subviews) {
        [subview removeFromSuperview];
    }
    if (list != nil) {
        if ([list isKindOfClass:[UIViewController class]]) {
            [list listView].frame = self.contentView.bounds;
        } else {
            [list listView].frame = self.bounds;
        }
        [self.contentView addSubview:[list listView]];
    }
}
@end

//
//  MoreSectionFootView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/16.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "MoreSectionFootView.h"

@implementation MoreSectionFootView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        self.titleLabel.textColor = [UIColor blackColor];

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

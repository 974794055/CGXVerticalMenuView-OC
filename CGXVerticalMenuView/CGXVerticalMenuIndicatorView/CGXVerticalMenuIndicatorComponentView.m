//
//  CGXHomeCategoryIndicatorComponentView.m
//  CGXHomeCategoryListView-OC
//
//  Created by MacMini-1 on 2019/7/25.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuIndicatorComponentView.h"

@implementation CGXVerticalMenuIndicatorComponentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}
- (void)initializeData
{
    
}

- (void)initializeViews
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

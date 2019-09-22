//
//  CGXVerticalMenuBaseCell.m
//  CGXCategoryListView-OC
//
//  Created by  on 2019/9/4.
//  Copyright © 2019 . All rights reserved.
//

#import "CGXVerticalMenuBaseCell.h"

@implementation CGXVerticalMenuBaseCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    
}
@end

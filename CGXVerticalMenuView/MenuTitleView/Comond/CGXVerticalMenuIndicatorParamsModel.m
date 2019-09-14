//
//  CGXCategoryIndicatorParamsModel.m
//  CGXCategoryView
//
//  Created by CGX on 2018/12/13.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXVerticalMenuIndicatorParamsModel.h"

@implementation CGXVerticalMenuIndicatorParamsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeDuration = 0;
        self.isFirstClick = YES;
        self.selectedIndex = CGXCategoryListCellSelectedTypeClick;
    }
    return self;
}
@end

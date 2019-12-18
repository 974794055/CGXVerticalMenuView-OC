//
//  CGXCategoryIndicatorParamsModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
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

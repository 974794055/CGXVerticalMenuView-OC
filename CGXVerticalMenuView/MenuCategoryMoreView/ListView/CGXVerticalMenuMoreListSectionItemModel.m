//
//  CGXVerticalMenuMoreListSectionItemModel.m
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2021/3/15.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListSectionItemModel.h"

@implementation CGXVerticalMenuMoreListSectionItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [self initializeData];
    }
    return self;
}
- (void)initializeData
{
    self.itemCornerRadius = 10;
    self.itemBborderWidth = 0;
    self.itemBorderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    self.itemBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    self.itemColor = [UIColor blackColor];
    self.itemFont = [UIFont systemFontOfSize:12];
    self.numberOfLines = 1;
}
@end

//
//  CGXVerticalMenuMoreListModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListModel.h"

@implementation CGXVerticalMenuMoreListModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.headEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.headColor = [UIColor whiteColor];
        self.headBorderColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.headBorderWidth = 0;
        self.headCornerRadius = 10;
        self.titleHeight = 50;
        self.titleSpace = 10;
        self.titleModel = [[CGXVerticalMenuMoreListTitleModel alloc] init];
        self.titleModel.textSelectBorderRadius = 10;
        self.titleModel.textNormalBorderRadius = 10;
        self.haveTitleView = YES;
    }
    return self;
}

@end

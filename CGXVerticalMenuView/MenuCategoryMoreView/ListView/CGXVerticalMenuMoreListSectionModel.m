//
//  CGXVerticalMenuMoreListSectionModel.m
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2021/3/15.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListSectionModel.h"

@implementation CGXVerticalMenuMoreListSectionModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];

        self.rowCount = 3;
        self.insets =UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        
        self.footerHeight = 10;
        self.headerHeight = 0;
        self.footerBgColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.headerBgColor= [UIColor whiteColor];
         self.sectionColor= [UIColor whiteColor];
        self.itemHeight = 0;
        self.itemSpace = 1;
        
        self.headerTextFont = [UIFont systemFontOfSize:14];
        self.headerTextColor = [UIColor blackColor];
        self.headertextAlignment = NSTextAlignmentLeft;
        self.headTextEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        self.roundModel = [[CGXVerticalMenuRoundModel alloc] init];
        self.roundModel.isCalculateHeader = NO;
        self.roundModel.isCalculateFooter = NO;
        self.borderInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}
- (void)setRowCount:(NSInteger)rowCount
{
    _rowCount = rowCount;
    NSAssert(rowCount >= 1, @"rowCount每行必须是大于等于1");
}
@end

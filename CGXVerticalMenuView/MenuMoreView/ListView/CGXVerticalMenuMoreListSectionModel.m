//
//  CGXVerticalMenuMoreListSectionModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
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

        self.itemHeight = 0;
        self.itemSpace = 1;
        
        
        
        self.roundModel = [[CGXVerticalMenuRoundModel alloc] init];
        self.roundModel.isCalculateHeader = NO;
        self.roundModel.isCalculateFooter = NO;
        self.roundModel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        self.borderInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.headNameModel = [[CGXVerticalMenuCustomTextModel alloc] init];
        self.headNameModel.textFont = [UIFont systemFontOfSize:14];
        self.headNameModel.textColor = [UIColor blackColor];
        self.headNameModel.textAlignment = NSTextAlignmentLeft;
        self.headNameModel.spaceTop = 10;
        self.headNameModel.spaceBottom = 10;
        self.headNameModel.spaceLeft = 10;
        self.headNameModel.spaceRight = 10;
     
    }
    return self;
}
- (void)setRowCount:(NSInteger)rowCount
{
    _rowCount = rowCount;
    NSAssert(rowCount >= 1, @"rowCount每行必须是大于等于1");
}
@end

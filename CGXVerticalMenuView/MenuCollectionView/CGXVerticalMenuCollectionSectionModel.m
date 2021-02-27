//
//  CGXVerticalMenuCollectionSectionModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCollectionSectionModel.h"

@implementation CGXVerticalMenuCollectionSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rowArray = [NSMutableArray array];
        self.rowCount = 3;
        self.insets =UIEdgeInsetsMake(10, 10, 10, 10);
        self.borderInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.footerHeight = 10;
        self.headerHeight = 0;
        self.footerBgColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.headerBgColor= [UIColor whiteColor];
         self.sectionColor= [UIColor blackColor];
        self.headersHovering = NO;
        self.headersHoveringTopEdging = 0;
        self.roundModel = [[CGXVerticalMenuRoundModel alloc] init];
        self.roundModel.isCalculateHeader = YES;
        self.roundModel.isCalculateFooter = YES;
    }
    return self;
}
@end

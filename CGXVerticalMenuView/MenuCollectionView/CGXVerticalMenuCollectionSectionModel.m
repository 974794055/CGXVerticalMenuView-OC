//
//  CGXVerticalMenuCollectionSectionModel.m
//  CGXCategoryListView-OC
//
//  Created by CGX on 2019/9/12.
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
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.footerHeight = 10;
        self.headerHeight = 0;
        self.footerBgColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.headerBgColor= [UIColor whiteColor];
         self.sectionColor= [UIColor blackColor];
    }
    return self;
}
@end

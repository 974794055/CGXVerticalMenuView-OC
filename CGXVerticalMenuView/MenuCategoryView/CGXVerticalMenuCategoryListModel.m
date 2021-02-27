//
//  CGXVerticalMenuCategoryListModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCategoryListModel.h"

@implementation CGXVerticalMenuCategoryListModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightArray = [NSMutableArray array];
        self.leftModel = [[CGXVerticalMenuTitleModel alloc] init];
    }
    return self;
}
@end

//
//  CGXVerticalMenuBaseModel.m
//  CGXCategoryListView-OC
//
//  Created by MacMini-1 on 2019/9/12.
//  Copyright © 2019 . All rights reserved.
//

#import "CGXVerticalMenuBaseModel.h"

@implementation CGXVerticalMenuBaseModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isMoreClick = YES;
        self.rowHeight = 50;
    }
    return self;
}
@end

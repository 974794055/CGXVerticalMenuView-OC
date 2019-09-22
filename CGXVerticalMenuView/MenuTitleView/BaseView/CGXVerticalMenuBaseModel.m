//
//  CGXVerticalMenuBaseModel.m
//  CGXCategoryListView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
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

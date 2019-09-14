//
//  CGXVerticalMenuTitleModel.m
//  CGXCategoryListView-OC
//
//  Created by 曹贵鑫 on 2019/9/4.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import "CGXVerticalMenuTitleModel.h"

@implementation CGXVerticalMenuTitleModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleNormalColor = [UIColor blackColor];
        self.titleSelectedColor = [UIColor redColor];
        self.titleFont=[UIFont systemFontOfSize:14];
        self.titleSelectedFont=[UIFont systemFontOfSize:15];
    }
    return self;
}
@end

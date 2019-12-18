//
//  CGXVerticalMenuTitleModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
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

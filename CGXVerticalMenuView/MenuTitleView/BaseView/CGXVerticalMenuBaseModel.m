//
//  CGXVerticalMenuBaseModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuBaseModel.h"

@implementation CGXVerticalMenuBaseModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selected = NO;
        self.isMoreClick = YES;
        self.rowHeight = 50;
    }
    return self;
}
@end

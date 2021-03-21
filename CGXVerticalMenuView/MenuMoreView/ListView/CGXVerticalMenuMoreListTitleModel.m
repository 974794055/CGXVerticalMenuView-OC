//
//  CGXVerticalMenuMoreListTitleModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListTitleModel.h"

@implementation CGXVerticalMenuMoreListTitleModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textNormalColor = [UIColor blackColor];
        self.textSelectColor = [UIColor redColor];
        self.textNormalBgColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.textSelectBgColor = [UIColor whiteColor];
        self.textNormalFont= [UIFont systemFontOfSize:14];
        self.textSelectFont= [UIFont systemFontOfSize:14];
        self.textNormalBorderColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        self.textSelectBorderColor = [UIColor redColor];
        self.textNormalBorderRadius = 10;
        self.textSelectBorderRadius = 10;
        self.textNormalBorderWidth = 0;
        self.textSelectBorderWidth = 1;
        self.titleSpace = 30;
    }
    return self;
}
@end

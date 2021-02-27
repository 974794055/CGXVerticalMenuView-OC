//
//  CGXVerticalMenuRoundModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuRoundModel.h"

@implementation CGXVerticalMenuRoundModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isCalculateHeader = YES;
        self.isCalculateFooter = YES;
        self.borderWidth = 0;
        self.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        self.shadowColor = [UIColor colorWithWhite:0.93 alpha:1];;
        self.shadowOffset= CGSizeMake(0, 0);
        self.shadowOpacity = 0;
        self.shadowRadius = 0;
        self.cornerRadius = 0;
    }
    return self;
}
@end

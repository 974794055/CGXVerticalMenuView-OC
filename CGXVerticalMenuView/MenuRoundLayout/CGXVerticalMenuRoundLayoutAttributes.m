//
//  CGXVerticalMenuRoundLayoutAttributes.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuRoundLayoutAttributes.h"

@implementation CGXVerticalMenuRoundLayoutAttributes
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.borderEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.myConfigModel = [[CGXVerticalMenuRoundModel alloc] init];
    }
    return self;
}
@end

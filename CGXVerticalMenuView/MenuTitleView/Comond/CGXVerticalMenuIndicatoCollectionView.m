//
//  CGXHomeCategoryCollectionView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuIndicatoCollectionView.h"

@implementation CGXVerticalMenuIndicatoCollectionView
- (void)setIndicators:(NSArray<UIView<CGXCategoryListIndicatorProtocol> *> *)indicators {
    for (UIView *indicator in _indicators) {
        //先移除之前的indicator
        [indicator removeFromSuperview];
    }
    
    _indicators = indicators;
    
    for (UIView *indicator in indicators) {
        [self addSubview:indicator];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView<CGXCategoryListIndicatorProtocol> *view in self.indicators) {
        [self sendSubviewToBack:view];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

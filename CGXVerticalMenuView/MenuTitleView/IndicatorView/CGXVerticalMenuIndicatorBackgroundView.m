//
//  CGXVerticalMenuIndicatorBackgroundView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuIndicatorBackgroundView.h"


@implementation CGXVerticalMenuIndicatorBackgroundView

- (void)initializeData
{
    [super initializeData];
     self.backgroundViewColor = [UIColor whiteColor];
    self.backgroundViewWidth = CGXVerticalMenuViewAutomaticDimension;
    self.backgroundViewHeight = CGXVerticalMenuViewAutomaticDimension;
    self.backgroundViewCornerRadius = CGXVerticalMenuViewAutomaticDimension;
}
- (void)initializeViews
{
    [super initializeViews];
    self.backgroundColor = self.backgroundViewColor;
    self.layer.masksToBounds  =YES;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect backframe = self.bounds;
    if (self.backgroundViewCornerRadius == CGXVerticalMenuViewAutomaticDimension) {
        self.layer.cornerRadius  = CGRectGetHeight(self.frame)/2.0;
    } else{
        self.layer.cornerRadius  = self.backgroundViewCornerRadius;
    }
    if (self.backgroundViewWidth != CGXVerticalMenuViewAutomaticDimension) {
        backframe.size.width = self.backgroundViewWidth;
    }
    if (self.backgroundViewHeight != CGXVerticalMenuViewAutomaticDimension) {
        backframe.size.height = self.backgroundViewHeight;
    }
}
/**
 categoryView重置状态时调用
 
 param selectedIndex 当前选中的index
 param selectedCellFrame 当前选中的cellFrame
 @param model 数据模型
 */
- (void)listIndicatorRefreshState:(CGXVerticalMenuIndicatorParamsModel *)model
{
//    NSLog(@"RefreshState---%@" , model);
    [self updateIndicatorModel:model];
}

/**
 选中了某一个cell
 
 param lastSelectedIndex 之前选中的index
 param selectedIndex 选中的index
 param selectedCellFrame 选中的cellFrame
 param selectedType cell被选中类型
 @param model 数据模型
 */
- (void)listIndicatorSelectedCell:(CGXVerticalMenuIndicatorParamsModel *)model
{
    [self updateIndicatorModel:model];
}

- (void)updateIndicatorModel:(CGXVerticalMenuIndicatorParamsModel *)model
{
    self.backgroundColor = self.backgroundViewColor;
    CGRect backframe = model.backgroundViewMaskFrame;
    if (self.backgroundViewWidth != CGXVerticalMenuViewAutomaticDimension) {
        backframe.origin.x = (backframe.size.width - self.backgroundViewWidth)/2.0;
        backframe.size.width = self.backgroundViewWidth;
    }
    if (self.backgroundViewHeight != CGXVerticalMenuViewAutomaticDimension) {
        backframe.origin.y = (backframe.size.height - self.backgroundViewHeight)/2.0+ model.selectedIndex * (model.selectedCellFrame.size.height+0)+0;
        backframe.size.height = self.backgroundViewHeight;
    }
    if (model.isFirstClick) {
        [UIView animateWithDuration:0 animations:^{
            self.frame = backframe;
        }];
    }  else{
        [UIView animateWithDuration:model.timeDuration animations:^{
            self.frame = backframe;
        }];
    }
}


@end

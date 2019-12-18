//
//  CGXHomeCategoryIndicatorLineView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuIndicatorLineView.h"

@implementation CGXVerticalMenuIndicatorLineView


- (void)initializeData
{
    [super initializeData];
    
    self.positionType = CGXVerticalMenuIndicatorLinePosition_Left;
    self.spaceTop = 0;
    self.spaceLeft  =  0;
    self.spaceRight = 0;
    self.spaceBottom = 0;
    self.lineSpace  = 4;
}
- (void)initializeViews
{
    [super initializeViews];
    self.backgroundColor = [UIColor redColor];
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
//    NSLog(@"SelectedCell---%@" , model);
    [self updateIndicatorModel:model];
}
- (void)updateIndicatorModel:(CGXVerticalMenuIndicatorParamsModel *)model
{
    CGRect lineFrame;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 0;
    CGFloat h = 0;
    switch (self.positionType) {
        case CGXVerticalMenuIndicatorLinePosition_Left:
        {
            x = self.spaceLeft;
            y = self.spaceTop+model.selectedIndex * (model.selectedCellFrame.size.height+0)+0;
            w = self.lineSpace;
            h = model.selectedCellFrame.size.height-self.spaceTop-self.spaceBottom;
        }
            break;
        case CGXVerticalMenuIndicatorLinePosition_Right:
        {
            x = model.selectedCellFrame.size.width-self.lineSpace-self.spaceRight;
            y = self.spaceTop+model.selectedIndex * (model.selectedCellFrame.size.height+0)+0;
            w = self.lineSpace;
            h = model.selectedCellFrame.size.height-self.spaceTop-self.spaceBottom;
        }
            break;
        case CGXVerticalMenuIndicatorLinePosition_Top:
        {
            x = self.spaceLeft;
            y = self.spaceTop+model.selectedIndex * (model.selectedCellFrame.size.height+0)+0;
            w = model.selectedCellFrame.size.width-self.spaceLeft-self.spaceRight;;
            h = self.lineSpace;
        }
            break;
        case CGXVerticalMenuIndicatorLinePosition_Bottom:
        {
            x = self.spaceLeft;
            y = model.selectedCellFrame.size.height - self.spaceBottom - self.lineSpace + model.selectedIndex * (model.selectedCellFrame.size.height+0)+0;
            w = model.selectedCellFrame.size.width-self.spaceLeft-self.spaceRight;;
            h = self.lineSpace;
        }
            break;
            
        default:
            break;
    }
    lineFrame = CGRectMake(x, y, w, h);
    if (model.isFirstClick) {
        [UIView animateWithDuration:0 animations:^{
            self.frame = lineFrame;
        }];
    }  else{
        [UIView animateWithDuration:model.timeDuration animations:^{
            self.frame = lineFrame;
        }];
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

//
//  CGXVerticalMenuTitleView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuTitleView.h"
#import "CGXVerticalMenuTitleCell.h"
#import "CGXVerticalMenuIndicatorBackgroundView.h"
#import "CGXVerticalMenuIndicatorLineView.h"
@interface CGXVerticalMenuTitleView()

@property (nonatomic, assign) CGFloat isFirstClick;//是否第一次点击

@end

@implementation CGXVerticalMenuTitleView

- (void)initializeData
{
    [super initializeData];
    self.isFirstClick = YES;
    self.timeDuration = 0;
    self.clickedPosition = CGXCategoryListCellClickedPosition_Left;
}
- (void)initializeViews
{
    [super initializeViews];
    CGXVerticalMenuIndicatorBackgroundView *backgroundView = [[CGXVerticalMenuIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewColor = [UIColor orangeColor];
    backgroundView.backgroundViewCornerRadius = 0;
    CGXVerticalMenuIndicatorLineView *lineView = [[CGXVerticalMenuIndicatorLineView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    lineView.positionType = CGXVerticalMenuIndicatorLinePosition_Left;
    self.indicators = @[lineView,backgroundView];
    
}
- (Class)preferredCellClass
{
    return CGXVerticalMenuTitleCell.class;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectCellAtIndex:indexPath.section selectedType:CGXCategoryListCellSelectedTypeClick];
}
- (void)updateMenuWithDataArray:(NSMutableArray<CGXVerticalMenuBaseModel *> *)dataArray
{
    [super updateMenuWithDataArray:dataArray];

    for (UIView<CGXCategoryListIndicatorProtocol> *indicator in self.indicators) {
        if (self.dataArray.count <= 0) {
            indicator.hidden = YES;
        }else {
            indicator.hidden = NO;

            CGXVerticalMenuTitleModel *model = (CGXVerticalMenuTitleModel *)self.dataArray[self.selectedIndex];
            NSInteger lastSelectedIndex = self.selectedIndex;
            CGRect clickedCellFrame = CGRectMake(0, self.selectedIndex *model.rowHeight , self.frame.size.width, model.rowHeight);

            CGXVerticalMenuIndicatorParamsModel *indicatorParamsModel = [[CGXVerticalMenuIndicatorParamsModel alloc] init];
            indicatorParamsModel.selectedIndex = self.selectedIndex;
            indicatorParamsModel.lastSelectedIndex = lastSelectedIndex;
            indicatorParamsModel.selectedCellFrame = clickedCellFrame;
            indicatorParamsModel.isFirstClick = self.isFirstClick;
            indicatorParamsModel.timeDuration = self.timeDuration;
            [indicator listIndicatorRefreshState:indicatorParamsModel];
            if ([indicator isKindOfClass:[CGXVerticalMenuIndicatorBackgroundView class]]) {
                CGRect maskFrame = indicator.frame;
                maskFrame.origin.x = maskFrame.origin.x - clickedCellFrame.origin.x;
                indicatorParamsModel.backgroundViewMaskFrame = clickedCellFrame;
            }
        }
    }
    [self selectItemAtIndex:self.selectedIndex];
    
}


- (void)refreshCellModel:(CGXVerticalMenuBaseModel *)cellModel index:(NSInteger)index
{
    [super refreshCellModel:cellModel index:index];
//    CGXVerticalMenuTitleModel *model = (CGXVerticalMenuTitleModel *)cellModel;
  
}
- (void)refreshSelectedCellModel:(CGXVerticalMenuBaseModel *)selectedCellModel unselectedCellModel:(CGXVerticalMenuBaseModel *)unselectedCellModel
{
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
}
/**
 选中目标index的item
 @param index 目标index
 */
- (void)selectItemAtIndex:(NSInteger)index
{
    [self selectCellAtIndex:index selectedType:CGXCategoryListCellSelectedTypeClick];
}
/**
 滚动目标index的item
 @param index 目标index
 */
- (void)scrollerItemAtIndex:(NSInteger)index
{
    [self selectCellAtIndex:index selectedType:CGXCategoryListCellSelectedTypeScroll];
}
- (void)selectCellAtIndex:(NSInteger)index selectedType:(CGXCategoryListCellSelectedType)selectedType
{
    if (self.dataArray.count==0) {
        return;
    }
    if (index>self.dataArray.count-1) {
        return;
    }
    if (self.selectedIndex == index) {
        if (self.isFirstClick) {
            self.isFirstClick = !self.isFirstClick;
            [self updateIndicatorAtIndex:index selectedType:selectedType]; //更新指示器
        } else{
            CGXVerticalMenuTitleModel *newModel = (CGXVerticalMenuTitleModel *)self.dataArray[index];
            if (newModel.isMoreClick) {
                [self updateCellAtIndex:index selectedType:selectedType];
            }
        }
        return;
    } else{
        [self updateIndicatorAtIndex:index selectedType:selectedType]; //更新指示器
    }
    
    //通知子类刷新当前选中的和将要选中的cellModel
    CGXVerticalMenuTitleModel *oldModel = (CGXVerticalMenuTitleModel *)self.dataArray[self.selectedIndex];
    CGXVerticalMenuTitleModel *newModel = (CGXVerticalMenuTitleModel *)self.dataArray[index];
    [self refreshSelectedCellModel:newModel unselectedCellModel:oldModel];
    
    
    //刷新当前选中的和将要选中的cell
    CGXVerticalMenuTitleCell *lastCell = (CGXVerticalMenuTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:self.selectedIndex]];
    [lastCell reloadData:oldModel];
    CGXVerticalMenuTitleCell *selectedCell = (CGXVerticalMenuTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index]];
    [selectedCell reloadData:newModel];
    
    
    if (self.selectedIndex == index) {
        if (self.isFirstClick) {
            [self updateCellAtIndex:index selectedType:selectedType];
            [self updateDelegateAtIndex:index selectedType:selectedType];
            self.isFirstClick = NO;
        } else{
            if (newModel.isMoreClick) {
                [self updateCellAtIndex:index selectedType:selectedType];
                [self updateDelegateAtIndex:index selectedType:selectedType];
            }
        }
    } else{
        [self updateCellAtIndex:index selectedType:selectedType];
        [self updateDelegateAtIndex:index selectedType:selectedType];
    }
    self.isFirstClick = NO;
    self.selectedIndex = index;
}

#pragma mark - 更新指示器
- (void)updateIndicatorAtIndex:(NSInteger)index selectedType:(CGXCategoryListCellSelectedType)selectedType
{
    CGXVerticalMenuTitleModel *model = (CGXVerticalMenuTitleModel *)self.dataArray[index];
    NSInteger lastSelectedIndex = index;
    CGRect clickedCellFrame = CGRectMake(0, index *model.rowHeight , self.frame.size.width, model.rowHeight);
    for (UIView<CGXCategoryListIndicatorProtocol> *indicator in self.indicators) {
        CGXVerticalMenuIndicatorParamsModel *indicatorParamsModel = [[CGXVerticalMenuIndicatorParamsModel alloc] init];
        indicatorParamsModel.lastSelectedIndex = lastSelectedIndex;
        indicatorParamsModel.selectedIndex = index;
        indicatorParamsModel.selectedCellFrame = clickedCellFrame;
        indicatorParamsModel.selectedType = selectedType;
        indicatorParamsModel.isFirstClick = self.isFirstClick;
        indicatorParamsModel.timeDuration = self.timeDuration;
        if ([indicator isKindOfClass:[CGXVerticalMenuIndicatorBackgroundView class]]) {
            CGRect maskFrame = indicator.frame;
            maskFrame.origin.x = maskFrame.origin.x - clickedCellFrame.origin.x;
            indicatorParamsModel.backgroundViewMaskFrame = clickedCellFrame;
        }
        [indicator listIndicatorSelectedCell:indicatorParamsModel];
    }
}
#pragma mark - 更新cell
- (void)updateCellAtIndex:(NSInteger)index selectedType:(CGXCategoryListCellSelectedType)selectedType
{
    [CATransaction setDisableActions:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    [CATransaction commit];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    
}
#pragma mark - 更新代理
- (void)updateDelegateAtIndex:(NSInteger)index selectedType:(CGXCategoryListCellSelectedType)selectedType
{
    //目标index和当前选中的index相等，就不需要处理后续的选中更新逻辑，只需要回调代理方法即可。
    if (selectedType == CGXCategoryListCellSelectedTypeClick) {
        // 点击选中
        if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuTitleView:didClickSelectedItemAtIndex:)]) {
            [self.delegate verticalMenuTitleView:self didClickSelectedItemAtIndex:index];
        }
    }else if (selectedType == CGXCategoryListCellSelectedTypeScroll) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuTitleView:didScrollerSelectedItemAtIndex:)]) {
            [self.delegate verticalMenuTitleView:self didScrollerSelectedItemAtIndex:index];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuTitleView:didSelectedItemAtIndex:)]) {
        [self.delegate verticalMenuTitleView:self didSelectedItemAtIndex:index];
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

//
//  CGXVerticalMenuTitleView.m
//  CGXCategoryListView-OC
//
//  Created by 曹贵鑫 on 2019/9/4.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import "CGXVerticalMenuTitleView.h"
#import "CGXVerticalMenuTitleCell.h"
#import "CGXVerticalMenuIndicatorBackgroundView.h"
#import "CGXVerticalMenuIndicatorLineView.h"
@interface CGXVerticalMenuTitleView()

@property (nonatomic, assign) CGFloat isFirstClick;//是否第一次点击

@property (nonatomic, assign,readwrite) NSInteger  selectedIndex;

@end

@implementation CGXVerticalMenuTitleView

- (void)initializeData
{
    [super initializeData];
   
    self.isFirstClick = YES;
    self.timeDuration = 0;
    self.selectedIndex = 0;
  
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
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
    CGXVerticalMenuTitleModel *model = (CGXVerticalMenuTitleModel *)self.dataArray[indexPath.section];
    
    BOOL isSelect = NO;
    if (self.selectedIndex == indexPath.section) {
        isSelect = YES;
    }
    [cell reloadData:model IsSelect:isSelect];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectCellAtIndex:indexPath.section selectedType:CGXCategoryListCellSelectedTypeClick];
}
- (void)updateMenuWithDataArray:(NSMutableArray<CGXVerticalMenuBaseModel *> *)dataArray
{
    [super updateMenuWithDataArray:dataArray];
    [self selectItemAtIndex:self.selectedIndex];    
}
- (void)replaceObjectAtIndex:(NSInteger)index ItemModel:(CGXVerticalMenuBaseModel  *)itemModel
{
    [super replaceObjectAtIndex:index ItemModel:itemModel];
    [self.dataArray replaceObjectAtIndex:index withObject:itemModel];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:index]];
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
    CGXVerticalMenuTitleModel *model = (CGXVerticalMenuTitleModel *)self.dataArray[index];
    
    [self updateIndicatorAtIndex:index selectedType:selectedType];
    
    if (self.selectedIndex == index) {
        if (self.isFirstClick) {
            [self updateCellAtIndex:index selectedType:selectedType];
            self.isFirstClick = NO;
        } else{
            if (model.isMoreClick) {
                [self updateCellAtIndex:index selectedType:selectedType];
            }
        }
    } else{
        [self updateCellAtIndex:index selectedType:selectedType];
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
    [self updateDelegateAtIndex:index selectedType:selectedType];
    
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

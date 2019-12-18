//
//  CGXVerticalMenuView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCategoryView.h"

typedef NS_ENUM(NSUInteger, CGXVerticalMenuCategoryViewDropUpDownType) {
    CGXVerticalMenuCategoryViewDropUpDownNodel,
    CGXVerticalMenuCategoryViewDropUpDownTop,
    CGXVerticalMenuCategoryViewDropUpDownBottom
};


@interface CGXVerticalMenuCategoryView ()<CGXVerticalMenuTitleViewDelegate,CGXVerticalMenuCollectionViewDelegate,CGXVerticalMenuCollectionViewDataSouce,CGXVerticalMenuContainerViewDataSouce,CGXVerticalMenuContainerViewDelegate>

@property (nonatomic , strong,readwrite) NSMutableArray <CGXVerticalMenuCategoryListModel *> *dataArray;

@property (nonatomic , assign,readwrite) NSInteger currentInteger;


@property (nonatomic , assign) CGXVerticalMenuCategoryViewDropUpDownType dropUpDown;


@property (nonatomic , strong) CGXVerticalMenuTitleView *leftView;

@property (nonatomic , strong) CGXVerticalMenuContainerView *containerView;


// 是否是点击滚动翻页的，为YES时 和 animated无效，无滚动动画
@property (nonatomic, assign) BOOL isClickScroll;


@end

@implementation CGXVerticalMenuCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.leftBgColor = [UIColor colorWithWhite:0.93 alpha:1];;
        self.rightBgColor = [UIColor whiteColor];
        self.dropUpDown = CGXVerticalMenuCategoryViewDropUpDownNodel;
        self.titleWidth = 100;
        self.currentInteger = 0;
        self.dataArray = [NSMutableArray array];
        self.spaceLeft = 0;
        self.spaceRight = 0;
        self.leftView = [[CGXVerticalMenuTitleView alloc] initWithFrame:CGRectMake(0, 0, self.titleWidth, CGRectGetHeight(self.bounds))];
        self.leftView.delegate = self;
        self.leftView.backgroundColor = self.leftBgColor;
        [self addSubview:self.leftView];
        
        self.containerView = [[CGXVerticalMenuContainerView alloc] initWithFrame:CGRectMake(self.titleWidth, 0, CGRectGetWidth(self.bounds)-self.titleWidth, CGRectGetHeight(self.bounds))];
        self.containerView.backgroundColor = self.rightBgColor;
        self.containerView.dataSouce = self;
        self.containerView.delegate = self;
        [self addSubview:self.containerView];
        self.containerView.animated = self.scrollAnimated;
        
        CGXVerticalMenuIndicatorLineView *lineView = [[CGXVerticalMenuIndicatorLineView alloc] init];
        lineView.backgroundColor = [UIColor redColor];
        lineView.positionType = CGXVerticalMenuIndicatorLinePosition_Left;
        self.leftView.indicators = @[lineView];
    }
    return self;
}
- (void)setSpaceLeft:(CGFloat)spaceLeft
{
    _spaceLeft = spaceLeft;
    self.containerView.spaceLeft = spaceLeft;
}
- (void)setSpaceRight:(CGFloat)spaceRight
{
    _spaceRight = spaceRight;
     self.containerView.spaceRight = spaceRight;
}
- (void)setLeftBgColor:(UIColor *)leftBgColor
{
    _leftBgColor = leftBgColor;
    self.leftView.backgroundColor = leftBgColor;
}
- (void)setRightBgColor:(UIColor *)rightBgColor
{
    _rightBgColor = rightBgColor;
    self.containerView.backgroundColor = rightBgColor;
}
- (void)setIndicators:(NSArray<UIView<CGXCategoryListIndicatorProtocol> *> *)indicators
{
    _indicators = indicators;
    self.leftView.indicators = indicators;
}
- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuCategoryListModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (CGXVerticalMenuCategoryListModel *listModel in self.dataArray) {
        CGXVerticalMenuTitleModel *itemModel = listModel.leftModel;
        [dataArr addObject:itemModel];
    }
    [self.leftView updateMenuWithDataArray:dataArr];
//    [self.containerView reloadData];
//
}
/**
 选中目标index的item
 @param index 目标index
 */
- (void)selectItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    [self.leftView selectItemAtIndex:index];
}
- (void)refreshLoadData
{
    if (self.currentInteger > 0) {
        self.currentInteger = self.currentInteger-1;
    }
    self.currentInteger = self.currentInteger;
    [self.leftView scrollerItemAtIndex:self.currentInteger];
}
- (void)refreshMoreLoadData
{
    if (self.currentInteger < self.dataArray.count-1) {
        self.currentInteger = self.currentInteger+1;
    }
    self.currentInteger = self.currentInteger;
    [self.leftView scrollerItemAtIndex:self.currentInteger];
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    self.isClickScroll = YES;
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didScrollerSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
     self.isClickScroll = NO;
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
     self.containerView.isClickScroll = self.isClickScroll;
     self.containerView.animated = self.scrollAnimated;
    [self.containerView reloadDataToItemAtIndex:index];
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:didSelectedItemAtIndex:)]) {
        [self.delegate verticalMenuView:self didSelectedItemAtIndex:index];
    }
    
}
- (NSInteger)numberOfRowsInListContainerView:(CGXVerticalMenuContainerView *)listContainerView
{
    return self.dataArray.count;
}
- (UIView *)verticalListContainerView:(CGXVerticalMenuContainerView *)listContainerView listViewInRow:(NSInteger)row
{
    CGXVerticalMenuCategoryListModel *listModel = self.dataArray[row];
    CGXVerticalMenuCollectionView *rightView = [[CGXVerticalMenuCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    rightView.delegate = self;
    rightView.dataSouce = self;
    [rightView updateRightWithDataArray:listModel.rightArray];
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:RefreshScrollView:listViewInRow:)]) {
        [self.delegate verticalMenuView:self RefreshScrollView:rightView.collectionView listViewInRow:row];
    }
    return rightView;
}
- (void)verticalListContainerView:(CGXVerticalMenuContainerView *)listContainerView willDisplayCellAtRow:(NSInteger)row
{
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:willDisplayCellAtRow:)]) {
        [self.delegate verticalMenuView:self willDisplayCellAtRow:row];
    }
}

- (void)verticalListContainerView:(CGXVerticalMenuContainerView *)listContainerView didEndDisplayingCellAtRow:(NSInteger)row
{
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:didEndDisplayingCellAtRow:)]) {
        [self.delegate verticalMenuView:self didEndDisplayingCellAtRow:row];
    }
}
#pragma mark --  右侧代理
- (UICollectionViewCell *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(verticalMenuView:ListView:cellForItemAtIndexPath:listViewInRow:)]) {
        return [self.dataSouce verticalMenuView:self ListView:categoryView cellForItemAtIndexPath:indexPath listViewInRow:self.currentInteger];
    }
    CGXVerticalMenuCollectionCell *cell = [categoryView.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionCell class]) forIndexPath:indexPath];
    CGXVerticalMenuCollectionSectionModel *sectionModel = categoryView.dataArray[indexPath.section];
    CGXVerticalMenuCollectionItemModel *itemModel = sectionModel.rowArray[indexPath.row];
    [cell reloadData:itemModel];
    return cell;
}
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(verticalMenuView:ListView:KindHeadAtIndexPath:listViewInRow:)]) {
        return [self.dataSouce verticalMenuView:self ListView:categoryView KindHeadAtIndexPath:indexPath listViewInRow:self.currentInteger];
    }
    return [[UICollectionReusableView alloc] init];
}
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindFootAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(verticalMenuView:ListView:KindFootAtIndexPath:listViewInRow:)]) {
        return [self.dataSouce verticalMenuView:self ListView:categoryView KindFootAtIndexPath:indexPath listViewInRow:self.currentInteger];
    }
    return [[UICollectionReusableView alloc] init];
}
/**
 每个分区背景颜色  默认背景色
 */
- (UIColor *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView BackgroundColorForSection:(NSInteger)section
{
    if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(verticalMenuView:BackgroundColorForSection:)]) {
        return [self.dataSouce verticalMenuView:self BackgroundColorForSection:section];
    }
    CGXVerticalMenuCollectionSectionModel *sectionModel = categoryView.dataArray[section];
    return sectionModel.sectionColor;
}
- (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end

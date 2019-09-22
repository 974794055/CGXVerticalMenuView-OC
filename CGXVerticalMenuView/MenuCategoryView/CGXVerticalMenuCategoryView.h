//
//  CGXVerticalMenuView.h
//  CGXVerticalMenuView-OC
//
//  Created by  on 2019/9/15.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGXVerticalMenuCategoryListModel.h"
#import "CGXVerticalMenuTitleView.h"
#import "CGXVerticalMenuIndicatorLineView.h"
#import "CGXVerticalMenuIndicatorBackgroundView.h"
#import "CGXVerticalMenuCollectionView.h"
#import "CGXVerticalMenuContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXVerticalMenuCategoryView;

@protocol CGXVerticalMenuCategoryViewDataSouce <NSObject>


@optional
/** 右侧自定义cell样式
 @param categoryView categoryView description
 @param row 选中的row
 */
- (UICollectionViewCell *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView ListView:(CGXVerticalMenuCollectionView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath listViewInRow:(NSInteger)row;
/** 右侧头分区样式
 @param categoryView categoryView description
 @param row 选中的row
 */
- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView ListView:(CGXVerticalMenuCollectionView *)listView KindHeadAtIndexPath:(NSIndexPath *)indexPath listViewInRow:(NSInteger)row;
/** 右侧脚分区样式
 @param categoryView categoryView description
 @param row 选中的row
 */
- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView ListView:(CGXVerticalMenuCollectionView *)listView KindFootAtIndexPath:(NSIndexPath *)indexPath listViewInRow:(NSInteger)row;

@end

@protocol CGXVerticalMenuCategoryViewDelegate <NSObject>


@optional

/** 左侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

/**  右侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param indexPath 选中的indexPath
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemDetailsAtIndexPath:(NSIndexPath *)indexPath;

/**  将要显示
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param row 选中的row
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView willDisplayCellAtRow:(NSInteger)row;
/**  将要消失
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param row 选中的row
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didEndDisplayingCellAtRow:(NSInteger)row;

/**  右侧自定义下拉view
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param scrollView 右侧滚动的view
 @param row 选中的row 左侧选中的下标
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView RefreshScrollView:(UIScrollView *)scrollView listViewInRow:(NSInteger)row;


@end

@interface CGXVerticalMenuCategoryView : UIView

@property (nonatomic, weak) id<CGXVerticalMenuCategoryViewDelegate> delegate;

@property (nonatomic, weak) id<CGXVerticalMenuCategoryViewDataSouce> dataSouce;


@property (nonatomic, strong) NSArray <UIView<CGXCategoryListIndicatorProtocol> *> *indicators;

@property (nonatomic , strong,readonly) NSMutableArray <CGXVerticalMenuCategoryListModel *> *dataArray;

- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuCategoryListModel *> *)dataArray;

/* 左侧背景 */
@property (nonatomic , strong) UIColor *leftBgColor;
/* 右侧背景 */
@property (nonatomic , strong) UIColor *rightBgColor;
/* 左侧默认宽度100 */
@property (nonatomic, assign) CGFloat titleWidth;
/* 选中目标index */
@property (nonatomic , assign,readonly) NSInteger currentInteger;

/**
 右侧手动翻页滚动动画 默认NO
 需要实现
 - (void)refreshLoadData;
 - (void)refreshMoreLoadData;
 */
@property (nonatomic, assign) BOOL scrollAnimated;

/**
 选中目标index的item
 @param index 目标index
 */
- (void)selectItemAtIndex:(NSInteger)index;
/**
 上一页
 */
- (void)refreshLoadData;
/**
 下一页
 */
- (void)refreshMoreLoadData;

@end

NS_ASSUME_NONNULL_END

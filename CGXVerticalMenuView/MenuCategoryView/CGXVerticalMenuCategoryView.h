//
//  CGXVerticalMenuView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCustomBaseView.h"

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
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)verticalMenuViewCustomCollectionViewCellClass;

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (Class)verticalMenuViewCustomCollectionViewCellNib;

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
/**
 每个分区背景颜色  默认背景色
 实现此代理时 CGXVerticalMenuCollectionSectionModel 内的配置sectionColor无效
 */
- (UIColor *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView BackgroundColorForSection:(NSInteger)section;

/**
 每个分区的高度 不实现  默认宽高相等
 */
- (CGFloat)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView sizeForItemAtSection:(NSInteger)section ItemWidth:(CGFloat)itemWidth;

@end

@protocol CGXVerticalMenuCategoryViewDelegate <NSObject>


@optional

/** 左侧点击
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

/**  右侧点击
 @param categoryView categoryView description
 @param indexPath 选中的indexPath
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemDetailsAtIndexPath:(NSIndexPath *)indexPath;

/**
 背景图点击事件
 @param categoryView categoryView description
 @param indexPath 点击背景图的indexPath
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectDecorationViewAtIndexPath:(NSIndexPath *)indexPath;
/**  将要显示
 @param categoryView categoryView description
 @param row 选中的row
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView willDisplayCellAtRow:(NSInteger)row;
/**  将要消失
 @param categoryView categoryView description
 @param row 选中的row
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didEndDisplayingCellAtRow:(NSInteger)row;

/**  将要显示的右侧分区
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView willDisplaViewElementKind:(NSString *)elementKind
   atIndexPath:(NSIndexPath *)indexPath;

/**  将要消失的右侧分区
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didEndDisplayingElementKind:(NSString *)elementKind
   atIndexPath:(NSIndexPath *)indexPath;

/**  右侧自定义下拉view
 @param categoryView categoryView description
 @param scrollView 右侧滚动的view
 @param row 选中的row 左侧选中的下标
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView
       RefreshScrollView:(UIScrollView *)scrollView
           listViewInRow:(NSInteger)row;

@end

@interface CGXVerticalMenuCategoryView : CGXVerticalMenuCustomBaseView

@property (nonatomic, weak) id<CGXVerticalMenuCategoryViewDelegate> delegate;

@property (nonatomic, weak) id<CGXVerticalMenuCategoryViewDataSouce> dataSouce;

@property (nonatomic, strong) NSArray <UIView<CGXCategoryListIndicatorProtocol> *> *indicators;

@property (nonatomic , strong,readonly) NSMutableArray <CGXVerticalMenuCategoryListModel *> *dataArray;
/*
 初始化使用
 */
- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuCategoryListModel *> *)dataArray;
/*
  更新某个下标数据使用
*/
- (void)updateListWistAtIndex:(NSInteger)index ItemModel:(CGXVerticalMenuCategoryListModel  *)itemModel;

- (void)reloadData;

/* 左侧背景 */
@property (nonatomic , strong) UIColor *leftBgColor;
/* 右侧背景 */
@property (nonatomic , strong) UIColor *rightBgColor;
/* 左侧默认宽度100 */
@property (nonatomic, assign) CGFloat titleWidth;
/* 选中目标index */
@property (nonatomic , assign,readonly) NSInteger currentInteger;

// 右侧滚动左侧间距 默认0
@property (nonatomic, assign) CGFloat spaceLeft;
// 右侧滚动右侧侧间距 默认0
@property (nonatomic, assign) CGFloat spaceRight;

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

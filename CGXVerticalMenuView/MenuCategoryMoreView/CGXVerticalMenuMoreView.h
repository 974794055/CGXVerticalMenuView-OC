//
//  CGXVerticalMenuMoreView.h
//  App
//
//  Created by MacMini-1 on 2021/3/9.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXVerticalMenuCustomBaseView.h"

#import "CGXVerticalMenuIndicatorLineView.h"
#import "CGXVerticalMenuIndicatorBackgroundView.h"
#import "CGXVerticalMenuMoreListView.h"
#import "CGXVerticalMenuMoreListModel.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXVerticalMenuMoreView;

@protocol CGXVerticalMenuMoreViewDelegate <NSObject>

@optional

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)verticalMenuMoreViewCustomCollectionViewCellClass;

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (Class)verticalMenuMoreViewCustomCollectionViewCellNib;
/**
 每个分区自定义cell
 */
- (UICollectionViewCell *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView
                                CollectionView:(nonnull UICollectionView *)collectionView
                                       AtIndex:(NSInteger)index
                        cellForItemAtIndexPath:(NSIndexPath *)indexPath;
/**
 自定义头部 需要设置frame
 */
- (UIView *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView HeadAtIndex:(NSInteger)index;
/**
 自定义脚部 需要设置frame
 */
- (UIView *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView FootAtIndex:(NSInteger)index;
/**
 每个分区头自定义view
 */
- (UIView *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView AtIndex:(NSInteger)index KindHeadAtIndexPath:(NSIndexPath *)indexPath;
/**
 每个分区脚自定义view
 */
- (UIView *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView AtIndex:(NSInteger)index KindFootAtIndexPath:(NSIndexPath *)indexPath;
/** 左侧点击
 @param moreView moreView description
 @param index 选中的index
 */
- (void)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView didSelectedItemAtIndex:(NSInteger)index;
/**  右侧点击
 @param moreView moreView description
 @param indexPath 选中的indexPath
 */
- (void)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView AtIndex:(NSInteger)index didSelectedItemDetailsAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CGXVerticalMenuMoreView : CGXVerticalMenuCustomBaseView

@property (nonatomic, weak) id<CGXVerticalMenuMoreViewDelegate> delegate;
/* 左侧背景 */
@property (nonatomic , strong) UIColor *leftBgColor;
/* 右侧背景 */
@property (nonatomic , strong) UIColor *rightBgColor;
/* 左侧默认宽度100 */
@property (nonatomic, assign) CGFloat titleWidth;
/* 选中目标index */
@property (nonatomic , assign,readonly) NSInteger currentInteger;

@property (nonatomic , strong,readonly) NSMutableArray <CGXVerticalMenuMoreListModel *> *dataArray;

/*
 数据源
 */
- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuMoreListModel *> *)dataArray;
/*
  更新某个下标数据使用
*/
- (void)updateListWistAtIndex:(NSInteger)index ItemModel:(CGXVerticalMenuMoreListModel  *)itemModel;
// 刷新数据
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END

//
//  CGXVerticalMenuCollectionView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuCollectionSectionModel.h"
#import "CGXVerticalMenuCollectionCell.h"
#import "CGXVerticalMenuCollectionViewFlowLayout.h"
#import "CGXVerticalMenuCollectionReusableView.h"
NS_ASSUME_NONNULL_BEGIN
@class CGXVerticalMenuCollectionView;

@protocol CGXVerticalMenuCollectionViewDataSouce <NSObject>
/**
 每个分区自定义cell
 */
- (UICollectionViewCell *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 每个分区头自定义view
 */
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath;
/**
 每个分区脚自定义view
 */
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindFootAtIndexPath:(NSIndexPath *)indexPath;

/**
 每个分区背景颜色  默认背景色
 */
- (UIColor *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView BackgroundColorForSection:(NSInteger)section;


@end

@protocol CGXVerticalMenuCollectionViewDelegate <NSObject>


@optional

/**
 点击选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param indexPath 选中的index
 */
- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView didClickSelectedItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView dropUpDownDidChanged:(CGPoint)contentOffset;


/**滚动选中的情况才会调用该方法*/
- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView ScrollViewDidScroll:(UIScrollView *)scrollView;
// CollectionView分区标题即将展示
- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
// CollectionView分区标题展示结束
- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;

-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewWillBeginDragging:(UIScrollView *)scrollView;
-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndDecelerating:(UIScrollView *)scrollView;


@end

@interface CGXVerticalMenuCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,CGXVerticalMenuCollectionViewFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong,readonly) NSMutableArray <CGXVerticalMenuCollectionSectionModel *> *dataArray;

@property (nonatomic, weak) id<CGXVerticalMenuCollectionViewDelegate> delegate;
@property (nonatomic, weak) id<CGXVerticalMenuCollectionViewDataSouce> dataSouce;
// 是否悬浮在顶部 默认NO
@property (nonatomic , assign) BOOL stopTop;

/*
 自定义cell 必须实现
 */
- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib;

- (void)updateRightWithDataArray:(NSMutableArray<CGXVerticalMenuCollectionSectionModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END

//
//  CGXVerticalMenuCollectionView.h
//  CGXCategoryListView-OC
//
//  Created by MacMini-1 on 2019/9/5.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuCollectionSectionModel.h"
#import "CGXVerticalMenuCollectionCell.h"
#import "CGXVerticalMenuCollectionViewFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN
@class CGXVerticalMenuCollectionView;
@protocol CGXVerticalMenuCollectionViewDelegate <NSObject>

- (UICollectionViewCell *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional


- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindFootAtIndexPath:(NSIndexPath *)indexPath;

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
-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndDecelerating:(UIScrollView *)scrollView;


@end

@interface CGXVerticalMenuCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong,readonly) NSMutableArray <CGXVerticalMenuCollectionSectionModel *> *dataArray;

@property (nonatomic, weak) id<CGXVerticalMenuCollectionViewDelegate> delegate;

// 是否悬浮在顶部 默认NO
@property (nonatomic , assign) BOOL stopTop;

/*
 自定义cell 必须实现
 */
- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib;

- (void)updateRightWithDataArray:(NSMutableArray<CGXVerticalMenuCollectionSectionModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END

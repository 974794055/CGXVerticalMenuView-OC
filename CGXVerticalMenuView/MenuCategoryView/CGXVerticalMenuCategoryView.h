//
//  CGXVerticalMenuView.h
//  CGXVerticalMenuView-OC
//
//  Created by 曹贵鑫 on 2019/9/15.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuCategoryListModel.h"
#import "CGXVerticalMenuTitleView.h"
#import "CGXVerticalMenuIndicatorLineView.h"
#import "CGXVerticalMenuIndicatorBackgroundView.h"
#import "CGXVerticalMenuCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXVerticalMenuCategoryView;
@protocol CGXVerticalMenuCategoryViewDelegate <NSObject>

- (UICollectionViewCell *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView KindFootAtIndexPath:(NSIndexPath *)indexPath;


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

@end

@interface CGXVerticalMenuCategoryView : UIView

@property (nonatomic, weak) id<CGXVerticalMenuCategoryViewDelegate> delegate;

@property (nonatomic , strong,readonly) NSMutableArray <CGXVerticalMenuCategoryListModel *> *dataArray;
- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuCategoryListModel *> *)dataArray;

@property (nonatomic , strong) UIColor *leftBgColor;
@property (nonatomic , strong) UIColor *righttBgColor;
/* 左侧默认宽度100 */
@property (nonatomic, assign) CGFloat titleWidth;

@property (nonatomic , strong) CGXVerticalMenuTitleView *leftView;
@property (nonatomic,strong) CGXVerticalMenuCollectionView *rightView;

//是否保持右边滚动时位置
@property(assign,nonatomic) BOOL isKeepScrollState;

@end

NS_ASSUME_NONNULL_END

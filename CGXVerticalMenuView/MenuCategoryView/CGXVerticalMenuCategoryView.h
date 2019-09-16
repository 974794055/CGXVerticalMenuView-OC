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

/* 联动类型
 CGXCategoryListViewScollTypeNode：//不联动 ，点击左侧时可刷新右侧数据
 CGXCategoryListViewScollTypeSinglePartition：//联动 点击选中  左侧大分区对应右侧一个小分区 右侧对应的分区个数大于1时，只取第一个，个数为0时初始化一个空分区
 CGXCategoryListViewScollTypeMorePartition：//联动 右侧多分区
 
 */
typedef NS_ENUM(NSUInteger, CGXVerticalMenuCategoryViewScollType) {
    CGXVerticalMenuCategoryViewScollTypeNode,          //不联动
    CGXVerticalMenuCategoryViewScollTypeLinkage,  //通过滚动到某个cell选中
    CGXVerticalMenuCategoryViewScollTypeNodeCustom
};
@class CGXVerticalMenuCategoryView;
@protocol CGXVerticalMenuCategoryViewDelegate <NSObject>

- (UICollectionViewCell *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional


- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView KindFootAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface CGXVerticalMenuCategoryView : UIView

@property (nonatomic, weak) id<CGXVerticalMenuCategoryViewDelegate> delegate;

@property (nonatomic , strong,readonly) NSMutableArray <CGXVerticalMenuCategoryListModel *> *dataArray;
- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuCategoryListModel *> *)dataArray;

@property (nonatomic , strong) UIColor *leftBgColor;
@property (nonatomic , strong) UIColor *righttBgColor;
/* 左侧默认宽度100 */
@property (nonatomic, assign) CGFloat titleWidth;

/* 联动类型 */
@property (nonatomic, assign) CGXVerticalMenuCategoryViewScollType  scollType;

@property (nonatomic , strong) CGXVerticalMenuTitleView *leftView;
@property (nonatomic,strong) CGXVerticalMenuCollectionView *rightView;

//是否保持右边滚动时位置
@property(assign,nonatomic) BOOL isKeepScrollState;
@property(assign,nonatomic) BOOL isReturnLastOffset;

@end

NS_ASSUME_NONNULL_END

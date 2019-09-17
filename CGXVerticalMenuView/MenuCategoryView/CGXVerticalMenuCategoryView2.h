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
#import "CGXVerticalMenuCategoryTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXVerticalMenuCategoryView2;
@protocol CGXVerticalMenuCategoryView2Delegate <NSObject>


@optional



/** 左侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView2 *)categoryView didSelectedItemAtIndex:(NSInteger)index;

/**  右侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param indexPath 选中的indexPath
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView2 *)categoryView didSelectedItemDetailsAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CGXVerticalMenuCategoryView2 : UIView<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic, weak) id<CGXVerticalMenuCategoryView2Delegate> delegate;

@property (nonatomic , strong,readonly) NSMutableArray <CGXVerticalMenuCategoryListModel *> *dataArray;

- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuCategoryListModel *> *)dataArray;

@property (nonatomic , strong) UIColor *leftBgColor;
@property (nonatomic , strong) UIColor *righttBgColor;
/* 左侧默认宽度100 */
@property (nonatomic, assign) CGFloat titleWidth;

@property (nonatomic , strong) CGXVerticalMenuTitleView *leftView;


@end

NS_ASSUME_NONNULL_END

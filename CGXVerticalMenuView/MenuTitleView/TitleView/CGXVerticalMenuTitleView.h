//
//  CGXVerticalMenuTitleView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuBaseView.h"
#import "CGXVerticalMenuTitleModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXVerticalMenuTitleView;

@protocol CGXVerticalMenuTitleViewDelegate <NSObject>

@optional
/**
 点击选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;
/**
 滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didScrollerSelectedItemAtIndex:(NSInteger)index;
/**
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didSelectedItemAtIndex:(NSInteger)index;
/**
 正在滚动中的回调
 @param categoryView categoryView对象
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 从左往右计算的百分比
 */
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView
       scrollingFromLeftIndex:(NSInteger)leftIndex
                 toRightIndex:(NSInteger)rightIndex
                        ratio:(CGFloat)ratio;

@end

@interface CGXVerticalMenuTitleView : CGXVerticalMenuBaseView

/**代理方法*/
@property (nonatomic, weak) id<CGXVerticalMenuTitleViewDelegate> delegate;
/**指示器方向 默认左侧*/
@property (nonatomic, assign) CGXCategoryListCellClickedPosition clickedPosition;
/**指示器动画时间 默认0*/
@property (nonatomic, assign) NSTimeInterval timeDuration;
/**
 选中目标index的item
 @param index 目标index
 */
- (void)selectItemAtIndex:(NSInteger)index;
/**
 滚动目标index的item
 @param index 目标index
 */
- (void)scrollerItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

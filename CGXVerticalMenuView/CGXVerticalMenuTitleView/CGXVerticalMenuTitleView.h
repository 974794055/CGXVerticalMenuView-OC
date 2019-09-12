//
//  CGXVerticalMenuTitleView.h
//  CGXCategoryListView-OC
//
//  Created by 曹贵鑫 on 2019/9/4.
//  Copyright © 2019 曹贵鑫. All rights reserved.
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

@end

@interface CGXVerticalMenuTitleView : CGXVerticalMenuBaseView

@property (nonatomic, weak) id<CGXVerticalMenuTitleViewDelegate> delegate;

@property (nonatomic, assign) CGXCategoryListCellClickedPosition clickedPosition;

@property (nonatomic, assign) NSTimeInterval timeDuration;//指示器动画时间 默认0

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

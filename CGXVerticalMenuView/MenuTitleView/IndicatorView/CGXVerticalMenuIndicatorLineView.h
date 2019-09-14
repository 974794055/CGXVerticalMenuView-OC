//
//  CGXHomeCategoryIndicatorLineView.h
//  CGXHomeCategoryListView-OC
//
//  Created by MacMini-1 on 2019/7/25.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuIndicatorComponentView.h"

NS_ASSUME_NONNULL_BEGIN

/*
 线条指示器位置
 */

typedef NS_ENUM(NSUInteger, CGXVerticalMenuIndicatorLineViewType) {
    CGXVerticalMenuIndicatorLinePosition_Left,
    CGXVerticalMenuIndicatorLinePosition_Right,
    CGXVerticalMenuIndicatorLinePosition_Top,
    CGXVerticalMenuIndicatorLinePosition_Bottom
};

@interface CGXVerticalMenuIndicatorLineView : CGXVerticalMenuIndicatorComponentView

//指示器lineView的宽度。水平
@property (nonatomic, assign) CGFloat lineSpace;

/* 默认都是0  有效性 跟 positionType 关联
 positionType：CGXVerticalMenuIndicatorLinePosition_Left时 ，spaceTop、spaceBottom、spaceLeft有效
 positionType：CGXVerticalMenuIndicatorLinePosition_Right时 ，spaceTop、spaceBottom、spaceRight有效
 positionType：CGXVerticalMenuIndicatorLinePosition_Top时 ，spaceTop、spaceLeft、spaceRight有效
 positionType：CGXVerticalMenuIndicatorLinePosition_Bottom时 ，spaceBottom、spaceLeft、spaceRight有效
 */
@property (nonatomic, assign) CGFloat spaceTop;
@property (nonatomic, assign) CGFloat spaceBottom;
@property (nonatomic, assign) CGFloat spaceLeft;
@property (nonatomic, assign) CGFloat spaceRight;


@property (nonatomic, assign) CGXVerticalMenuIndicatorLineViewType positionType;


@end

NS_ASSUME_NONNULL_END

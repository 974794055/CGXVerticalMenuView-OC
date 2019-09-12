//
//  CGXCategoryViewDefines.h
//  CGXCategoryView
//
//  Created by CGX on 2018/8/17.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const CGFloat CGXVerticalMenuViewAutomaticDimension = -1;


typedef NS_ENUM(NSUInteger, CGXCategoryListCellClickedPosition) {
    CGXCategoryListCellClickedPosition_Left,
    CGXCategoryListCellClickedPosition_Right,
    CGXCategoryListCellClickedPosition_Top,
    CGXCategoryListCellClickedPosition_Bottom,
};

// cell被选中的类型
typedef NS_ENUM(NSUInteger, CGXCategoryListCellSelectedType) {
    CGXCategoryListCellSelectedTypeSelect,            //点击选中 或者滚动
    CGXCategoryListCellSelectedTypeClick,            //点击选中
    CGXCategoryListCellSelectedTypeScroll            //滚动选中
};

#define CGXCategoryViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

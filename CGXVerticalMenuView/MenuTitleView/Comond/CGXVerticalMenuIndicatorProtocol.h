//
//  CGXCategoryIndicatorProtocol.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGXVerticalMenuIndicatorParamsModel.h"
@protocol CGXCategoryListIndicatorProtocol <NSObject>


/**
 categoryView重置状态时调用

 param selectedIndex 当前选中的index
 param selectedCellFrame 当前选中的cellFrame
 @param model 数据模型
 */
- (void)listIndicatorRefreshState:(CGXVerticalMenuIndicatorParamsModel *)model;

/**
 选中了某一个cell

 param lastSelectedIndex 之前选中的index
 param selectedIndex 选中的index
 param selectedCellFrame 选中的cellFrame
 param selectedType cell被选中类型
 @param model 数据模型
 */
- (void)listIndicatorSelectedCell:(CGXVerticalMenuIndicatorParamsModel *)model;

@end

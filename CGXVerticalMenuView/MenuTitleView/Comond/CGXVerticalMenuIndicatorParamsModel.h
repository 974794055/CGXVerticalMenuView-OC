//
//  CGXCategoryIndicatorParamsModel.h
//  CGXCategoryView
//
//  Created by CGX on 2018/12/13.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGXVerticalMenuViewDefines.h"
/**
指示器处理逻辑以后会扩展不同的使用场景，会新增参数，如果不通过model传递，就会在api新增参数，一旦修改api该的地方就特别多了，而且会影响到之前自定义实现的开发者。
 */
@interface CGXVerticalMenuIndicatorParamsModel : NSObject

@property (nonatomic, assign) BOOL isFirstClick;//是否第一次点击

@property (nonatomic, assign) CGRect backgroundViewMaskFrame;     //当前选中的cellFrame
@property (nonatomic, assign) CGRect selectedCellFrame;     //当前选中的cellFrame
@property (nonatomic, assign) NSInteger selectedIndex;      //当前选中的index
@property (nonatomic, assign) NSInteger lastSelectedIndex;  //之前选中的index
@property (nonatomic, assign) CGXCategoryListCellSelectedType selectedType;  //cell被选中类型
@property (nonatomic, assign) NSTimeInterval timeDuration;//指示器动画时间


@end



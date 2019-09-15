//
//  CGXVerticalMenuCategoryListModel.h
//  CGXVerticalMenuView-OC
//
//  Created by 曹贵鑫 on 2019/9/15.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGXVerticalMenuTitleModel.h"
#import "CGXVerticalMenuCollectionSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCategoryListModel : NSObject

@property (nonatomic , strong) CGXVerticalMenuTitleModel *leftModel;

@property (nonatomic, strong) NSMutableArray <CGXVerticalMenuCollectionSectionModel *> *rightArray;


//这个来定位右边数据源滚动的位置 内部使用
@property (nonatomic ,assign) CGFloat offsetScorller;

@end

NS_ASSUME_NONNULL_END

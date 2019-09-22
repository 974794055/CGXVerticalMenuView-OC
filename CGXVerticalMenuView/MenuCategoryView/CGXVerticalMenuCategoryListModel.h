//
//  CGXVerticalMenuCategoryListModel.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGXVerticalMenuTitleModel.h"
#import "CGXVerticalMenuCollectionSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCategoryListModel : NSObject

// 左侧数据源
@property (nonatomic , strong) CGXVerticalMenuTitleModel *leftModel;

// 右侧数据源
@property (nonatomic, strong) NSMutableArray <CGXVerticalMenuCollectionSectionModel *> *rightArray;


@end

NS_ASSUME_NONNULL_END

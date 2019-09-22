//
//  CGXVerticalMenuBaseModel.h
//  CGXCategoryListView-OC
//
//  Created by MacMini-1 on 2019/9/12.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuBaseModel : NSObject

// 是否支持多次点击 默认YES
@property (nonatomic, assign) BOOL isMoreClick;
// cell高
@property (nonatomic, assign) CGFloat  rowHeight;
// cell原始数据
@property (nonatomic , strong) id dataModel;
@end

NS_ASSUME_NONNULL_END

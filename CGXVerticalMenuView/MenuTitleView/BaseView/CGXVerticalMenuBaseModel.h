//
//  CGXVerticalMenuBaseModel.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuBaseModel : NSObject

@property (nonatomic, assign, getter=isSelected) BOOL selected;

// 是否支持多次点击 默认YES
@property (nonatomic, assign) BOOL isMoreClick;
// cell高
@property (nonatomic, assign) CGFloat  rowHeight;
// cell原始数据
@property (nonatomic , strong) id dataModel;
@end

NS_ASSUME_NONNULL_END

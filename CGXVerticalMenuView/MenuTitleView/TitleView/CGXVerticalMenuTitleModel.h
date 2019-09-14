//
//  CGXVerticalMenuTitleModel.h
//  CGXCategoryListView-OC
//
//  Created by 曹贵鑫 on 2019/9/4.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import "CGXVerticalMenuBaseModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuTitleModel : CGXVerticalMenuBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *titleSelectedFont;

@end

NS_ASSUME_NONNULL_END

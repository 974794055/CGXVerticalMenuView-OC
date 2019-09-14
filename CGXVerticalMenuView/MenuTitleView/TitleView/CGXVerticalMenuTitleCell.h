//
//  CGXVerticalMenuTitleCell.h
//  CGXCategoryListView-OC
//
//  Created by 曹贵鑫 on 2019/9/4.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import "CGXVerticalMenuBaseCell.h"
#import "CGXVerticalMenuTitleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuTitleCell : CGXVerticalMenuBaseCell

- (void)reloadData:(CGXVerticalMenuTitleModel *)model IsSelect:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END

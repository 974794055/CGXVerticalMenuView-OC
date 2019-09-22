//
//  CGXVerticalMenuTitleCell.h
//  CGXCategoryListView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuBaseCell.h"
#import "CGXVerticalMenuTitleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuTitleCell : CGXVerticalMenuBaseCell

- (void)reloadData:(CGXVerticalMenuTitleModel *)model IsSelect:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END

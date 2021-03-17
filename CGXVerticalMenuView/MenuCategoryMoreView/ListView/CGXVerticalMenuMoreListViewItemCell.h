//
//  CGXVerticalMenuMoreListViewItemCell.h
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2021/3/15.
//  Copyright © 2021 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuMoreListSectionItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuMoreListViewItemCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView *urlImageView;
@property (nonatomic , strong) UILabel *titleLabel;
- (void)reloadData:(CGXVerticalMenuMoreListSectionItemModel *)model TitleHeight:(CGFloat)titleHeight;
@end

NS_ASSUME_NONNULL_END

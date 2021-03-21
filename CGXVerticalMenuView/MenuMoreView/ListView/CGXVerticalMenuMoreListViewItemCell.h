//
//  CGXVerticalMenuMoreListViewItemCell.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
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

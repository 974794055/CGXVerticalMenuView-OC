//
//  MoreViewCell.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2021 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreViewCell : UICollectionViewCell
@property (nonatomic , strong) UIImageView *urlImageView;
@property (nonatomic , strong) UILabel *titleLabel;
- (void)reloadData:(CGXVerticalMenuMoreListSectionItemModel *)model;
@end

NS_ASSUME_NONNULL_END

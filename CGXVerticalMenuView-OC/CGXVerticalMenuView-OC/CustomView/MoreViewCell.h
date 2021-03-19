//
//  MoreViewCell.h
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2021/3/16.
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

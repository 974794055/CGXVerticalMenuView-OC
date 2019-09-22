//
//  CGXVerticalMenuCollectionCell..h
//  CGXCategoryListView-OC
//
//  Created by MacMini-1 on 2019/9/5.
//  Copyright © 2019 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuCollectionSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCollectionCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *urlImageView;

- (void)reloadData:(CGXVerticalMenuCollectionItemModel *)model;

@end

NS_ASSUME_NONNULL_END

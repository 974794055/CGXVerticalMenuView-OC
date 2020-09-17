//
//  CGXVerticalMenuBaseCell.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuBaseCell : UICollectionViewCell

@property (nonatomic , strong) CGXVerticalMenuBaseModel *cellModel;

- (void)initializeViews NS_REQUIRES_SUPER;
- (void)reloadData:(CGXVerticalMenuBaseModel *)model NS_REQUIRES_SUPER;
@end

NS_ASSUME_NONNULL_END

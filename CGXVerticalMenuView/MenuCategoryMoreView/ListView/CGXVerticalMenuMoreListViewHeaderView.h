//
//  CGXVerticalMenuMoreListViewHeaderView.h
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2021/3/15.
//  Copyright © 2021 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuMoreListSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuMoreListViewHeaderView : UICollectionReusableView
@property (nonatomic , strong) UILabel *titleLabel;
- (void)updateWithSectionModel:(CGXVerticalMenuMoreListSectionModel *)sectionModel;

@end

NS_ASSUME_NONNULL_END

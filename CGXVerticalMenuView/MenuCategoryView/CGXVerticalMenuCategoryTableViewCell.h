//
//  CGXVerticalMenuCategoryTableViewCell.h
//  CGXVerticalMenuView-OC
//
//  Created by 曹贵鑫 on 2019/9/17.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuCollectionView.h"
#import "TitleHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCategoryTableViewCell : UITableViewCell<CGXVerticalMenuCollectionViewDelegate>


@property (nonatomic,strong) CGXVerticalMenuCollectionView *rightView;


- (void)updateCellWithDataArray:(NSMutableArray<CGXVerticalMenuCollectionSectionModel *> *)dataArray AtIndex:(NSInteger)index;;

@end

NS_ASSUME_NONNULL_END

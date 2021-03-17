//
//  CGXVerticalMenuListContainerViewCell.h
//  App
//
//  Created by MacMini-1 on 2021/3/5.
//  Copyright © 2021 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuListContainerViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuListContainerViewCell : UICollectionViewCell

- (void)updateWithCellModel:(id<CGXVerticalMenuListContainerViewDelegate>)list;

@end

NS_ASSUME_NONNULL_END

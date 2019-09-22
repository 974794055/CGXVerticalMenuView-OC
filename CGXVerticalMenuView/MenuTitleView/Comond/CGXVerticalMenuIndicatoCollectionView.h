//
//  CGXHomeCategoryCollectionView.h
//  CGXHomeCategoryListView
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuIndicatorProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuIndicatoCollectionView : UICollectionView
@property (nonatomic, strong) NSArray <UIView<CGXCategoryListIndicatorProtocol> *> *indicators;
@end

NS_ASSUME_NONNULL_END

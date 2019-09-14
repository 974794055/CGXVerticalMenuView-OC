//
//  CGXHomeCategoryCollectionView.h
//  CGXHomeCategoryListView
//
//  Created by MacMini-1 on 2019/9/3.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuIndicatorProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuIndicatoCollectionView : UICollectionView
@property (nonatomic, strong) NSArray <UIView<CGXCategoryListIndicatorProtocol> *> *indicators;
@end

NS_ASSUME_NONNULL_END

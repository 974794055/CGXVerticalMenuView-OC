//
//  CGXVerticalMenuCollectionSectionReusableView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuRoundLayoutAttributes.h"
#import "CGXVerticalMenuRoundFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuRoundReusableView : UICollectionReusableView

@property (weak, nonatomic) CGXVerticalMenuRoundLayoutAttributes *myCacheAttr;
@end

NS_ASSUME_NONNULL_END

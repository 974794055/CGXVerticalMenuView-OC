//
//  CGXVerticalMenuRoundLayoutAttributes.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuRoundModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuRoundLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic, assign) UIColor *backgroundColor;
@property (nonatomic, assign) UIEdgeInsets borderEdgeInsets;
@property (nonatomic, strong) CGXVerticalMenuRoundModel *myConfigModel;
@end

NS_ASSUME_NONNULL_END

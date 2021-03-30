//
//  CGXVerticalMenuCollectionSectionTextView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuCustomTextModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCollectionSectionTextView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

- (void)updateWithTextModel:(CGXVerticalMenuCustomTextModel *)textModel;

@end

NS_ASSUME_NONNULL_END

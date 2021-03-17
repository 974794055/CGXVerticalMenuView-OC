//
//  CGXVerticalMenuCollectionSectionTextView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/12.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuCollectionSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCollectionSectionTextView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

- (void)updateWithTextModel:(CGXVerticalMenuCustomTextModel *)textModel;

@end

NS_ASSUME_NONNULL_END

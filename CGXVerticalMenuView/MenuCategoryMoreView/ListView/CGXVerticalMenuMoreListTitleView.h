//
//  CGXVerticalMenuMoreListTitleView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2020/12/12.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuMoreListTitleModel.h"
NS_ASSUME_NONNULL_BEGIN



@interface CGXVerticalMenuMoreListTitleView : UIView
/** 加载图片 */
@property (nonatomic, copy) void(^titieSelectBlock)(NSInteger integer);
@property (nonatomic, strong,readonly) UICollectionView *collectionView;
@property (nonatomic, assign,readonly) NSInteger currentInter;
- (void)updateDataTitieArray:(NSMutableArray<NSString *> *)titleArray TitleModel:(CGXVerticalMenuMoreListTitleModel *)titleModel Inter:(NSInteger)inter;
- (void)scrollAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END

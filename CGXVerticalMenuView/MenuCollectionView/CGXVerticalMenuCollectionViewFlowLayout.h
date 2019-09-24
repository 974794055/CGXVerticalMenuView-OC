//
//  CGXVerticalMenuCollectionViewFlowLayout.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CGXVerticalMenuCollectionViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section;

@end

@interface CGXVerticalMenuCollectionViewFlowLayout : UICollectionViewFlowLayout

// 是否悬浮在顶部 默认NO
@property (nonatomic , assign) BOOL stopTop;

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;


@end

NS_ASSUME_NONNULL_END

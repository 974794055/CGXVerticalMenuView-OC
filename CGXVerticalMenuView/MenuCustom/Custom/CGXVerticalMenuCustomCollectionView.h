//
//  CGXVerticalMenuCustomCollectionView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CGXVerticalMenuCustomCollectionView;

@protocol CGXPageHomeCollectionViewGestureDelegate <NSObject>

- (BOOL)gx_pageHomeCollectionView:(CGXVerticalMenuCustomCollectionView *)collectionView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
- (BOOL)gx_pageHomeCollectionView:(CGXVerticalMenuCustomCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end
@interface CGXVerticalMenuCustomCollectionView : UICollectionView
@property (nonatomic, assign) BOOL isNestEnabled;
@property (nonatomic, weak) id<CGXPageHomeCollectionViewGestureDelegate> gestureDelegate;
@end

NS_ASSUME_NONNULL_END

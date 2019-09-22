//
//  CGXVerticalMenuContainerCollectionView.h
//  CGXVerticalMenuView-OC
//
//  Created by  on 2019/9/21.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CGXVerticalMenuContainerCollectionView;

@protocol CGXVerticalMenuContainerCollectionViewGestureDelegate <NSObject>
@optional
- (BOOL)pagerListContainerCollectionView:(CGXVerticalMenuContainerCollectionView *)collectionView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;

- (BOOL)pagerListContainerCollectionView:(CGXVerticalMenuContainerCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end

@interface CGXVerticalMenuContainerCollectionView : UICollectionView<UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL isNestEnabled;
@property (nonatomic, weak) id<CGXVerticalMenuContainerCollectionViewGestureDelegate> gestureDelegate;

@end

NS_ASSUME_NONNULL_END

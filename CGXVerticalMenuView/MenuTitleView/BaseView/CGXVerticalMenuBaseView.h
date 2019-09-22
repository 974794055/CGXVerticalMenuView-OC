//
//  CGXVerticalMenuBaseView.h
//  CGXCategoryListView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuIndicatoCollectionView.h"
#import "CGXVerticalMenuViewDefines.h"
#import "CGXVerticalMenuBaseModel.h"
#import "CGXVerticalMenuBaseCell.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CGXVerticalMenuBaseViewSelectType) {
    CGXVerticalMenuBaseViewSelected,
    CGXVerticalMenuBaseViewClick,
    CGXVerticalMenuBaseViewScroll,
};


@interface CGXVerticalMenuBaseView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) CGXVerticalMenuIndicatoCollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <CGXVerticalMenuBaseModel *> *dataArray;

@property (nonatomic, strong) NSArray <UIView<CGXCategoryListIndicatorProtocol> *> *indicators;


- (void)initializeData NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;

- (Class)preferredCellClass;
- (UICollectionViewFlowLayout *)preferredFlowLayout;

/*
 自定义cell 必须实现
 */
- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib;
- (void)registerFooter:(Class)footer IsXib:(BOOL)isXib;
- (void)registerHeader:(Class)header IsXib:(BOOL)isXib;


- (void)updateMenuWithDataArray:(NSMutableArray<CGXVerticalMenuBaseModel *> *)dataArray NS_REQUIRES_SUPER;
- (void)replaceObjectAtIndex:(NSInteger)index ItemModel:(CGXVerticalMenuBaseModel  *)itemModel NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END

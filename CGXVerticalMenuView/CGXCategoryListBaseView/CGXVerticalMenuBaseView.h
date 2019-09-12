//
//  CGXVerticalMenuBaseView.h
//  CGXCategoryListView-OC
//
//  Created by 曹贵鑫 on 2019/9/4.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuIndicatoCollectionView.h"
#import "CGXVerticalMenuViewDefines.h"
#import "CGXVerticalMenuBaseModel.h"
#import "CGXVerticalMenuBaseCell.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CGXHomeCategoryListBaseViewSelectType) {
    CGXHomeCategoryListBaseViewSelected,
    CGXHomeCategoryListBaseViewClick,
    CGXHomeCategoryListBaseViewScroll,
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

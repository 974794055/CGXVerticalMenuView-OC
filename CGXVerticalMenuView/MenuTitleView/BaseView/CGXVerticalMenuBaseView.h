//
//  CGXVerticalMenuBaseView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
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

/**
 选中目标index的item
 */
@property (nonatomic, assign) NSInteger  selectedIndex;

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

/*
 初始化使用
 */
- (void)updateMenuWithDataArray:(NSMutableArray<CGXVerticalMenuBaseModel *> *)dataArray NS_REQUIRES_SUPER;
/*
  更新某个下标数据使用
*/
- (void)replaceObjectAtIndex:(NSInteger)index ItemModel:(CGXVerticalMenuBaseModel  *)itemModel NS_REQUIRES_SUPER;

/**
刷新指定的index的cell
内部会触发`- (void)refreshCellModel:(CGXVerticalMenuBaseModel *)cellModel index:(NSInteger)index`方法进行cellModel刷新

@param index 指定cell的index
*/
- (void)reloadCellAtIndex:(NSInteger)index;

/**
refreshState时调用，重置cellModel的状态

@param cellModel 待重置的cellModel
@param index cellModel在数组中的index
*/
- (void)refreshCellModel:(CGXVerticalMenuBaseModel *)cellModel index:(NSInteger)index NS_REQUIRES_SUPER;
/**
 选中某个item时，刷新将要选中与取消选中的cellModel

 @param selectedCellModel 将要选中的cellModel
 @param unselectedCellModel 取消选中的cellModel
 */
- (void)refreshSelectedCellModel:(CGXVerticalMenuBaseModel *)selectedCellModel unselectedCellModel:(CGXVerticalMenuBaseModel *)unselectedCellModel NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END

//
//  CGXVerticalMenuRoundFlowLayout.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuRoundModel.h"
#import "CGXVerticalMenuRoundLayoutAttributes.h"
#import "CGXVerticalMenuRoundReusableView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CGXVerticalMenuRoundFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@required


@optional

/// 设置底色参数
/// @param collectionView collectionView description
/// @param section section description
- (CGXVerticalMenuRoundModel *)collectionView:(UICollectionView *)collectionView configModelForSectionAtIndex:(NSInteger)section;

/// 设置底色偏移点量（与collectionview的sectionInset用法相同，但是与sectionInset区分）
/// @param collectionView collectionView description
/// @param section section description
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView borderEdgeInsertsForSectionAtIndex:(NSInteger)section;

/// 设置是否计算headerview（根据section判断是否单独计算）
/// @param collectionView collectionView description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView isCalculateHeaderViewIndex:(NSInteger)section;

/// 设置是否计算footerview（根据section判断是否单独计算）
/// @param collectionView collectionView description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView isCalculateFooterViewIndex:(NSInteger)section;


/// 背景图点击事件
/// @param collectionView collectionView description
/// @param indexPath 点击背景图的indexPath
- (void)collectionView:(UICollectionView *)collectionView didSelectDecorationViewAtIndexPath:(NSIndexPath *)indexPath;


/*
 是否悬停
 */
- (BOOL)collectionView:(UICollectionView *)collectionView sectionHeadersPinAtSection:(NSInteger)section;
/*
 悬停上部距离
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView sectionHeadersPinTopSpaceAtSection:(NSInteger)section;

@end

@interface CGXVerticalMenuRoundFlowLayout : UICollectionViewFlowLayout

/// 是否开始Round计算，（默认YES），当该位置为NO时，计算模块都不开启，包括设置的代理
@property (assign, nonatomic) BOOL isRoundEnabled;

/// 是否计算header（若实现collectionView: layout: isCalculateHeaderViewIndex:）该字段不起作用
@property (assign, nonatomic) BOOL isCalculateHeader;

/// 是否计算footer（若实现collectionView: layout: isCalculateFooterViewIndex:）该字段不起作用
@property (assign, nonatomic) BOOL isCalculateFooter;

/// 是否使用不规则Cell大小的计算方式(若Cell的大小是相同固定大小，则无需开启该方法)，默认NO
@property (assign, nonatomic) BOOL isCalculateOpenIrregularCell;

@property (nonatomic, strong,readonly) NSArray <UICollectionViewLayoutAttributes *> *sectionHeaderAttributes;


@end


NS_ASSUME_NONNULL_END

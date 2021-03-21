//
//  CGXVerticalMenuMoreListViewCell.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuMoreListSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CGXVerticalMenuMoreListViewCellDelegate <NSObject>

@optional


/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClass;

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (Class)customCollectionViewCellNib;
/**
 每个分区自定义cell
 */
- (UICollectionViewCell *)moreListCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 每个分区头自定义view
 */
- (UIView *)moreListCollectionView:(UICollectionView *)collectionView KindHeadAtIndexPath:(NSIndexPath *)indexPath;
/**
 每个分区脚自定义view
 */
- (UIView *)moreListCollectionView:(UICollectionView *)collectionView KindFootAtIndexPath:(NSIndexPath *)indexPath;
/**
 点击调用该方法
 */
- (void)moreListCollectionView:(UICollectionView *)collectionView didClickSelectedItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CGXVerticalMenuMoreListViewCell : UITableViewCell

- (void)updateWithListModel:(CGXVerticalMenuMoreListSectionModel *)listModel;

@property (nonatomic, weak) id<CGXVerticalMenuMoreListViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END

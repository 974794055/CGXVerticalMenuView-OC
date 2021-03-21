//
//  CGXVerticalMenuMoreListView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXVerticalMenuListContainerView.h"
#import "CGXVerticalMenuMoreListSectionModel.h"
#import "CGXVerticalMenuMoreListModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXVerticalMenuMoreListView;

@protocol CGXVerticalMenuMoreListViewDelegate <NSObject>

@optional

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)verticalMenuMoreListViewCustomCollectionViewCellClass;

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (Class)verticalMenuMoreListViewCustomCollectionViewCellNib;
/**
 每个分区自定义cell
 */
- (UICollectionViewCell *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView CollectionView:(UICollectionView *)collectionView AtIndex:(NSInteger)index cellForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 自定义头部
 */
- (UIView *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView HeaderAtIndex:(NSInteger)index;

/**
 自定义头部
 */
- (UIView *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView FooterAtIndex:(NSInteger)index;
/**
 每个分区头自定义view
 */
- (UIView *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView AtIndex:(NSInteger)index KindHeadAtIndexPath:(NSIndexPath *)indexPath;
/**
 每个分区脚自定义view
 */
- (UIView *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView AtIndex:(NSInteger)index KindFootAtIndexPath:(NSIndexPath *)indexPath;

/**
 点击调用该方法
 */
- (void)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView AtIndex:(NSInteger)index didClickSelectedItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CGXVerticalMenuMoreListView : UIView<CGXVerticalMenuListContainerViewDelegate>
@property (nonatomic, strong) NSMutableArray<CGXVerticalMenuMoreListSectionModel *> *dataArray;

@property (nonatomic, weak) id<CGXVerticalMenuMoreListViewDelegate> listDelegate;

// 图片加载
@property (nonatomic, copy) void(^menu_ImageCallback)(UIImageView *hotImageView, NSURL *hotImageURL);

- (void)updateWithListModel:(CGXVerticalMenuMoreListModel *)listModel AtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

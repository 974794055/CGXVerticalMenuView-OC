//
//  CGXVerticalMenuMoreListViewCell.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListViewCell.h"
#import "CGXVerticalMenuMoreListViewItemCell.h"
#import "CGXVerticalMenuRoundFlowLayout.h"
#import "CGXVerticalMenuCollectionSectionTextView.h"
@interface CGXVerticalMenuMoreListViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CGXVerticalMenuRoundFlowLayoutDelegate>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong)CGXVerticalMenuMoreListSectionModel *listModel;

@end
@implementation CGXVerticalMenuMoreListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGXVerticalMenuRoundFlowLayout *layout = [[CGXVerticalMenuRoundFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.isRoundEnabled = YES;
        layout.isCalculateHeader = YES;
        layout.isCalculateFooter = YES;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView= [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.bounces = NO;
        [self.collectionView registerClass:[CGXVerticalMenuMoreListViewItemCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuMoreListViewItemCell class])];
        //给collectionView注册头分区的Id
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        //给collection注册脚分区的id
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        
        [self.collectionView registerClass:[CGXVerticalMenuCollectionSectionTextView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionSectionTextView class])];
        if (@available(iOS 11.0, *)) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.collectionView.scrollEnabled = NO;
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}
- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib
{
    if (![classCell isKindOfClass:[UICollectionViewCell class]]) {
        NSAssert(![classCell isKindOfClass:[UICollectionViewCell class]], @"注册cell的registerCellAry数组必须是UICollectionViewCell类型");
    }
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", classCell] bundle:nil] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@", classCell]];
        
    } else{
        [self.collectionView registerClass:classCell forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@", classCell]];
    }
}
- (void)setDelegate:(id<CGXVerticalMenuMoreListViewCellDelegate>)delegate
{
    _delegate = delegate;
    if ([self.delegate respondsToSelector:@selector(customCollectionViewCellClass)] && [self.delegate customCollectionViewCellClass]) {
        [self registerCell:[self.delegate customCollectionViewCellClass] IsXib:NO];
    }else if ([self.delegate respondsToSelector:@selector(customCollectionViewCellNib)] && [self.delegate customCollectionViewCellNib]) {
        [self registerCell:[self.delegate customCollectionViewCellNib] IsXib:YES];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.contentView.bounds;
    [self.collectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listModel.dataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(self.listModel.insets.top+self.listModel.borderInsets.top, self.listModel.insets.left+self.listModel.borderInsets.left, self.listModel.insets.bottom+self.listModel.borderInsets.bottom, self.listModel.insets.right+self.listModel.borderInsets.right);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.listModel.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.listModel.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.listModel.roundModel.isCalculateFooter && self.listModel.footerHeight > 0) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), self.listModel.footerHeight+self.listModel.borderInsets.bottom);
    }
    return CGSizeMake(CGRectGetWidth(collectionView.frame), self.listModel.footerHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.listModel.roundModel.isCalculateHeader && self.listModel.headerHeight > 0) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), self.listModel.headerHeight+self.listModel.borderInsets.bottom);
    }
    return CGSizeMake(CGRectGetWidth(collectionView.frame), self.listModel.headerHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat space0 = self.listModel.borderInsets.left + self.listModel.borderInsets.right;
    CGFloat space1 = self.listModel.insets.left+self.listModel.insets.right;
    CGFloat width = floor( (CGRectGetWidth(collectionView.frame)-space1-space0-(self.listModel.rowCount-1)*self.listModel.minimumLineSpacing)/self.listModel.rowCount);
    CGFloat height = width * self.listModel.itemSpace+self.listModel.itemHeight;
    return CGSizeMake(width,height);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        [headView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(moreListCollectionView:KindHeadAtIndexPath:)] && [self.delegate moreListCollectionView:collectionView KindHeadAtIndexPath:indexPath]) {
            UIView *view = [self.delegate moreListCollectionView:collectionView KindHeadAtIndexPath:indexPath];
            CGRect frame = CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height);
            if (self.listModel.roundModel.isCalculateHeader) {
                frame.origin.y = self.listModel.borderInsets.top;
                frame.size.height -= self.listModel.borderInsets.top;
                frame.origin.x = self.listModel.borderInsets.left;
                frame.size.width -= self.listModel.borderInsets.left+self.listModel.borderInsets.right;
            }
            view.frame = frame;
            view.backgroundColor = self.listModel.headerBgColor;
            [headView addSubview:view];
        } else{
            CGXVerticalMenuCollectionSectionTextView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionSectionTextView class]) forIndexPath:indexPath];
            CGRect frame = CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height);
            if (self.listModel.roundModel.isCalculateHeader) {
                frame.origin.y = self.listModel.borderInsets.top;
                frame.size.height -= self.listModel.borderInsets.top;
                frame.origin.x = self.listModel.borderInsets.left;
                frame.size.width -= self.listModel.borderInsets.left+self.listModel.borderInsets.right;
            }
            view.frame = frame;
            view.backgroundColor = self.listModel.headerBgColor;
            [view updateWithTextModel:self.listModel.headNameModel];
            [headView addSubview:view];
        }
        return headView;
    } else {
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        [footView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(moreListCollectionView:KindFootAtIndexPath:)] && [self.delegate moreListCollectionView:collectionView KindFootAtIndexPath:indexPath]) {
            UIView *view = [self.delegate moreListCollectionView:collectionView KindFootAtIndexPath:indexPath];
            CGRect frame = CGRectMake(0, 0, footView.frame.size.width, footView.frame.size.height);
            if (self.listModel.roundModel.isCalculateFooter) {
                frame.size.height -= self.listModel.borderInsets.bottom;
                frame.origin.x = self.listModel.borderInsets.left;
                frame.size.width -= self.listModel.borderInsets.left+self.listModel.borderInsets.right;
            }
            view.frame = frame;
            view.backgroundColor = self.listModel.footerBgColor;
            [footView addSubview:view];
        }
        return footView;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreListCollectionView:cellForItemAtIndexPath:)] && [self.delegate moreListCollectionView:collectionView cellForItemAtIndexPath:indexPath]) {
        return [self.delegate moreListCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    CGXVerticalMenuMoreListViewItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuMoreListViewItemCell class]) forIndexPath:indexPath];
    [cell reloadData:self.listModel.dataArray[indexPath.row] TitleHeight:self.listModel.itemHeight];
    return cell;
}
#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreListCollectionView:didClickSelectedItemAtIndexPath:)]) {
        [self.delegate moreListCollectionView:collectionView  didClickSelectedItemAtIndexPath:indexPath];
    }
}

#pragma mark - CGXVerticalMenuRoundFlowLayout
/// 设置底色参数
/// @param collectionView collectionView description
/// @param section section description
- (CGXVerticalMenuRoundModel *)collectionView:(UICollectionView *)collectionView
                 configModelForSectionAtIndex:(NSInteger)section
{
    return self.listModel.roundModel;
}
/// 设置底色偏移点量（与collectionview的sectionInset用法相同，但是与sectionInset区分）
/// @param collectionView collectionView description
/// @param section section description
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView borderEdgeInsertsForSectionAtIndex:(NSInteger)section
{
    return self.listModel.borderInsets;
}
/// 设置是否计算headerview（根据section判断是否单独计算）
/// @param collectionView collectionView description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView isCalculateHeaderViewIndex:(NSInteger)section
{
    return self.listModel.roundModel.isCalculateHeader;
}
/// 设置是否计算footerview（根据section判断是否单独计算）
/// @param collectionView collectionView description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView isCalculateFooterViewIndex:(NSInteger)section
{
    return self.listModel.roundModel.isCalculateFooter;
}

/*
 是否悬停
 */
- (BOOL)collectionView:(UICollectionView *)collectionView sectionHeadersPinAtSection:(NSInteger)section
{
    return NO;
}

- (void)updateWithListModel:(CGXVerticalMenuMoreListSectionModel *)listModel
{
    self.listModel = listModel;
    self.collectionView.backgroundColor = listModel.roundModel.backgroundColor;
    [self.collectionView reloadData];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end

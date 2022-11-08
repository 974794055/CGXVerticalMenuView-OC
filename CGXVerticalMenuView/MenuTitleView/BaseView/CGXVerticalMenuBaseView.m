//
//  CGXVerticalMenuBaseView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuBaseView.h"
#import "CGXVerticalMenuBaseCell.h"
@interface CGXVerticalMenuBaseView()

@property (nonatomic, strong,readwrite) CGXVerticalMenuIndicatoCollectionView *collectionView;
@end

@implementation CGXVerticalMenuBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    self.collectionView = [[CGXVerticalMenuIndicatoCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self preferredFlowLayout]];
    self.collectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    [self.collectionView registerClass:[self preferredHeadClass] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([self preferredHeadClass])];
    [self.collectionView registerClass:[self preferredFootClass] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([self preferredFootClass])];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)setShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator
{
    _showsVerticalScrollIndicator = showsVerticalScrollIndicator;
    self.collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect targetFrame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.collectionView.frame = targetFrame;
    if (!CGRectEqualToRect(self.collectionView.frame, targetFrame)) {
        self.collectionView.frame = targetFrame;
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraint:top];
    [self addConstraint:left];
    [self addConstraint:right];
    [self addConstraint:bottom];
}
- (void)setIndicators:(NSArray<UIView<CGXCategoryListIndicatorProtocol> *> *)indicators {
    _indicators = indicators;
    self.collectionView.indicators = indicators;
}
- (Class)preferredHeadClass {
    return UICollectionReusableView.class;
}
- (Class)preferredFootClass {
    return UICollectionReusableView.class;
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
- (void)registerFooter:(Class)footer IsXib:(BOOL)isXib
{
    if (![footer isKindOfClass:[UICollectionReusableView class]]) {
        NSAssert(![footer isKindOfClass:[UICollectionReusableView class]], @"注册cell的registerCellAry数组必须是UICollectionReusableView类型");
    }
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", footer] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
    } else{
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
    }
}
- (void)registerHeader:(Class)header IsXib:(BOOL)isXib
{
    if (![header isKindOfClass:[UICollectionReusableView class]]) {
        NSAssert(![header isKindOfClass:[UICollectionReusableView class]], @"注册cell的registerCellAry数组必须是UICollectionReusableView类型");
    }
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", header] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
    } else{
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
    }
}






- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuBaseModel *model = self.dataArray[indexPath.section];
    return CGSizeMake(collectionView.frame.size.width, model.rowHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
    CGXVerticalMenuBaseModel *model = (CGXVerticalMenuBaseModel *)self.dataArray[indexPath.section];
    [cell reloadData:model];
    return cell;
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)next;
            if (@available(iOS 11.0, *)) {
                vc.automaticallyAdjustsScrollViewInsets = NO;
            }
            break;
        }
        next = next.nextResponder;
    }
}

- (void)updateMenuWithDataArray:(NSMutableArray<CGXVerticalMenuBaseModel *> *)dataArray
{
    if (dataArray.count==0) {
        [self.collectionView reloadData];
        return;
    }
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    
    if (self.selectedIndex < 0 || self.selectedIndex >= self.dataArray.count) {
        self.selectedIndex = 0;
    }
    for (int i = 0; i<self.dataArray.count; i++) {
        CGXVerticalMenuBaseModel *cellModel = self.dataArray[i];
        if (self.selectedIndex==i) {
            cellModel.selected = YES;
        } else{
            cellModel.selected = NO;
        }
        [self.dataArray replaceObjectAtIndex:i withObject:cellModel];
    }
    [self.collectionView reloadData];
    [self.superview layoutIfNeeded];
    [self.superview setNeedsLayout];
}
- (void)replaceObjectAtIndex:(NSInteger)index ItemModel:(CGXVerticalMenuBaseModel  *)itemModel
{
    if (self.dataArray.count==0 || index<0) {
        return;
    }
    if (index>self.dataArray.count-1) {
        return;
    }
    CGXVerticalMenuBaseModel *newModel = (CGXVerticalMenuBaseModel *)itemModel;
    [self.dataArray replaceObjectAtIndex:index withObject:newModel];
    [self reloadCellAtIndex:index];
}

- (void)reloadCellAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.dataArray.count) {
        return;
    }
    CGXVerticalMenuBaseModel *cellModel = self.dataArray[index];
    [self refreshCellModel:cellModel index:index];
    CGXVerticalMenuBaseCell *cell = (CGXVerticalMenuBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index]];
    [cell reloadData:cellModel];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@implementation CGXVerticalMenuBaseView (BaseHooks)

- (UICollectionViewFlowLayout *)preferredFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}
- (Class)preferredCellClass
{
    return CGXVerticalMenuBaseCell.class;
}
- (void)initializeData
{
    self.dataArray = [NSMutableArray array];
    self.selectedIndex = 0;
    self.showsVerticalScrollIndicator = NO;
}


- (void)refreshCellModel:(CGXVerticalMenuBaseModel *)cellModel index:(NSInteger)index
{
    
}
/**
 选中某个item时，刷新将要选中与取消选中的cellModel
 
 @param selectedCellModel 将要选中的cellModel
 @param unselectedCellModel 取消选中的cellModel
 */
- (void)refreshSelectedCellModel:(CGXVerticalMenuBaseModel *)selectedCellModel unselectedCellModel:(CGXVerticalMenuBaseModel *)unselectedCellModel
{
    selectedCellModel.selected = YES;
    unselectedCellModel.selected = NO;
}

@end

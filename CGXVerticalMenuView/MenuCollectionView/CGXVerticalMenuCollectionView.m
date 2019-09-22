//
//  CGXVerticalMenuCollectionView.m
//  CGXCategoryListView-OC
//
//  Created by MacMini-1 on 2019/9/5.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import "CGXVerticalMenuCollectionView.h"


@interface CGXVerticalMenuCollectionView()

@property (nonatomic, strong,readwrite) NSMutableArray <CGXVerticalMenuCollectionSectionModel *> *dataArray;

@end
@implementation CGXVerticalMenuCollectionView

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

- (void)initializeData
{
    self.dataArray = [NSMutableArray array];
    self.stopTop = NO;
}
- (CGXVerticalMenuCollectionViewFlowLayout *)preferredLayout
{
    CGXVerticalMenuCollectionViewFlowLayout *layout = [[CGXVerticalMenuCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.stopTop = self.stopTop;
    return layout;
}
- (void)setStopTop:(BOOL)stopTop
{
    _stopTop = stopTop;
    CGXVerticalMenuCollectionViewFlowLayout *layout =  [[CGXVerticalMenuCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.stopTop = self.stopTop;
    
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}
- (void)initializeViews
{
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.preferredLayout];
    self.collectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[CGXVerticalMenuCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionCell class])];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];
    
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    [self.collectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.rowArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[indexPath.section];
    CGXVerticalMenuCollectionItemModel *itemModel = sectionModel.rowArray[indexPath.row];
    UIEdgeInsets insets = sectionModel.insets;
    CGFloat space1 = insets.left + insets.right;
    CGFloat space2 = sectionModel.minimumInteritemSpacing;
    CGFloat width = (CGRectGetWidth(self.frame)-space1-(sectionModel.rowCount-1)*space2)/sectionModel.rowCount;
    return CGSizeMake(floor(width), itemModel.rowHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    UIEdgeInsets insets = sectionModel.insets;
    CGFloat space = insets.left + insets.right;
    
    return CGSizeMake(collectionView.frame.size.width-space, sectionModel.footerHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    UIEdgeInsets insets = sectionModel.insets;
    CGFloat space = insets.left + insets.right;
    return CGSizeMake(collectionView.frame.size.width-space, sectionModel.headerHeight);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[indexPath.section];
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        view.backgroundColor = sectionModel.headerBgColor;
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(categoryRightView:KindHeadAtIndexPath:)]) {
            UICollectionReusableView *headerView =[self.dataSouce categoryRightView:self KindHeadAtIndexPath:indexPath];
            headerView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            headerView.backgroundColor = sectionModel.headerBgColor;
            [view addSubview:headerView];
        }
        return view;
    } else {
        CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[indexPath.section];
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        view.backgroundColor = sectionModel.footerBgColor;
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(categoryRightView:KindFootAtIndexPath:)]) {
            UICollectionReusableView *footerView = [self.dataSouce categoryRightView:self KindFootAtIndexPath:indexPath];
            footerView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
             footerView.backgroundColor = sectionModel.footerBgColor;
            [view addSubview:footerView];
        }
        return view;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSouce categoryRightView:self cellForItemAtIndexPath:indexPath];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:didClickSelectedItemAtIndexPath:)]) {
        [self.delegate categoryRightView:self didClickSelectedItemAtIndexPath:indexPath];
    }
}
#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if ((self.collectionView.isTracking || self.collectionView.isDecelerating)) {
            //只处理用户滚动的情况
            [self contentOffsetOfContentScrollViewDidChanged:contentOffset];
        }
    }
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:dropUpDownDidChanged:)]) {
        [self.delegate categoryRightView:self dropUpDownDidChanged:contentOffset];
    }
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    view.layer.zPosition = 0.0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:willDisplaySupplementaryView:forElementKind:atIndexPath:)]) {
        [self.delegate categoryRightView:self willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
    }
}
// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:)]) {
        [self.delegate categoryRightView:self didEndDisplayingSupplementaryView:view forElementOfKind:elementKind atIndexPath:indexPath];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:ScrollViewDidScroll:)]) {
        [self.delegate categoryRightView:self ScrollViewDidScroll:scrollView];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:scrollViewWillBeginDragging:)]) {
        [self.delegate categoryRightView:self scrollViewWillBeginDragging:scrollView];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate categoryRightView:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate categoryRightView:self scrollViewDidEndScrollingAnimation:scrollView];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:scrollViewDidEndDecelerating:)]) {
        [self.delegate categoryRightView:self scrollViewDidEndDecelerating:scrollView];
    }
}
- (void)updateRightWithDataArray:(NSMutableArray<CGXVerticalMenuCollectionSectionModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
//    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) animated:NO];
}
- (void)dealloc
{
    if (self.collectionView) {
        [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
    }
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

@end

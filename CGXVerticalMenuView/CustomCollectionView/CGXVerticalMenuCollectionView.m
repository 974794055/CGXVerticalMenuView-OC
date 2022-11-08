//
//  CGXVerticalMenuCollectionView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCollectionView.h"
#import "CGXVerticalMenuRoundFlowLayout.h"
#import "CGXVerticalMenuCollectionSectionTextView.h"
#import "CGXVerticalMenuCollectionCell.h"
@interface CGXVerticalMenuCollectionView()<CGXVerticalMenuRoundFlowLayoutDelegate>

@property (nonatomic, strong,readwrite) NSMutableArray <CGXVerticalMenuCollectionSectionModel *> *dataArray;

@property (nonatomic, strong,readwrite) CGXVerticalMenuCustomCollectionView *collectionView;


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
}
- (CGXVerticalMenuRoundFlowLayout *)preferredLayout
{
    CGXVerticalMenuRoundFlowLayout *layout = [[CGXVerticalMenuRoundFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.isRoundEnabled = YES;
    layout.isCalculateHeader = YES;
    layout.isCalculateFooter = YES;
    return layout;
}
- (void)initializeViews
{
    self.collectionView = [[CGXVerticalMenuCustomCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self preferredLayout]];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView registerClass:[CGXVerticalMenuCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionCell class])];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    [self.collectionView registerClass:[CGXVerticalMenuCollectionSectionTextView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionSectionTextView class])];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.collectionView];
    
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
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
    return UIEdgeInsetsMake(sectionModel.insets.top, sectionModel.insets.left+sectionModel.borderInsets.left, sectionModel.insets.bottom+sectionModel.borderInsets.bottom, sectionModel.insets.right+sectionModel.borderInsets.right);
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
    UIEdgeInsets insets = sectionModel.insets;
    CGFloat space0 = sectionModel.borderInsets.left + sectionModel.borderInsets.right;
    CGFloat space1 = insets.left + insets.right;
    CGFloat space2 = sectionModel.minimumInteritemSpacing;
    CGFloat width = (CGRectGetWidth(self.frame)-space1-space0-(sectionModel.rowCount-1)*space2)/sectionModel.rowCount;
    CGFloat height = width;
    
    if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(categoryRightView:sizeForItemAtSection:ItemWidth:)]) {
        height = [self.dataSouce categoryRightView:self sizeForItemAtSection:indexPath.section ItemWidth:width];
    }
    return CGSizeMake(floor(width), height);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    if (sectionModel.footerHeight==0) {
        return CGSizeMake(collectionView.frame.size.width, sectionModel.footerHeight);
    }
    return CGSizeMake(collectionView.frame.size.width, sectionModel.footerHeight+sectionModel.borderInsets.bottom);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    if (sectionModel.headerHeight==0) {
        return CGSizeMake(collectionView.frame.size.width, sectionModel.headerHeight);
    }
    return CGSizeMake(collectionView.frame.size.width, sectionModel.headerHeight+sectionModel.borderInsets.top);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[indexPath.section];
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(categoryRightView:KindHeadAtIndexPath:)] && [self.dataSouce categoryRightView:self KindHeadAtIndexPath:indexPath]) {
            UICollectionReusableView *headerView =[self.dataSouce categoryRightView:self KindHeadAtIndexPath:indexPath];
            CGRect frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            if (view.frame.size.height > sectionModel.borderInsets.top) {
                frame.origin.y = sectionModel.borderInsets.top;
                frame.size.height = view.frame.size.height-sectionModel.borderInsets.top;
            }
            if (sectionModel.roundModel.isCalculateHeader) {
                frame.origin.x = sectionModel.borderInsets.left;
                frame.size.width = view.frame.size.width-sectionModel.borderInsets.left-sectionModel.borderInsets.right;
            }
            headerView.frame = frame;
            headerView.backgroundColor = sectionModel.headerBgColor;
            [view addSubview:headerView];
        } else{
            CGXVerticalMenuCollectionSectionTextView *textView = [[CGXVerticalMenuCollectionSectionTextView alloc] init];
            textView.frame = CGRectMake(0, 0, CGRectGetWidth(collectionView.frame), sectionModel.headerHeight);;
            CGRect frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            if (view.frame.size.height > sectionModel.borderInsets.top) {
                frame.origin.y = sectionModel.borderInsets.top;
                frame.size.height = view.frame.size.height-sectionModel.borderInsets.top;
            }
            if (sectionModel.roundModel.isCalculateHeader) {
                frame.origin.x = sectionModel.borderInsets.left;
                frame.size.width = view.frame.size.width-sectionModel.borderInsets.left-sectionModel.borderInsets.right;
            }
            textView.frame = frame;
            textView.backgroundColor = sectionModel.headerBgColor;
            [textView updateWithTextModel:sectionModel.headNameModel];
            [view addSubview:textView];
        }
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(categoryRightView:KindFootAtIndexPath:)] && [self.dataSouce categoryRightView:self KindFootAtIndexPath:indexPath]) {
            UICollectionReusableView *footerView = [self.dataSouce categoryRightView:self KindFootAtIndexPath:indexPath];
            CGRect frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            if (view.frame.size.height > sectionModel.borderInsets.bottom) {
                frame.size.height = view.frame.size.height-sectionModel.borderInsets.bottom;
            }
            if (sectionModel.roundModel.isCalculateHeader) {
                frame.origin.x = sectionModel.borderInsets.left;
                frame.size.width = view.frame.size.width-sectionModel.borderInsets.left-sectionModel.borderInsets.right;
            }
            footerView.frame = frame;
            footerView.backgroundColor = sectionModel.footerBgColor;
            [view addSubview:footerView];
        } else{
            view.backgroundColor = sectionModel.footerBgColor;
        }
        return view;
    }
    return nil;
}

#pragma mark - CGXVerticalMenuRoundFlowLayout
- (UIColor *)collectionView:(UICollectionView *)categoryView BackgroundColorForSection:(NSInteger)section
{
    if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(categoryRightView:BackgroundColorForSection:)]) {
        return [self.dataSouce categoryRightView:self BackgroundColorForSection:section];
    }
    return self.backgroundColor;
}
/// 设置底色参数
/// @param collectionView collectionView description
/// @param section section description
- (CGXVerticalMenuRoundModel *)collectionView:(UICollectionView *)collectionView
                 configModelForSectionAtIndex:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.roundModel;
}
/// 设置底色偏移点量（与collectionview的sectionInset用法相同，但是与sectionInset区分）
/// @param collectionView collectionView description
/// @param section section description
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView borderEdgeInsertsForSectionAtIndex:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.borderInsets;
}
/// 设置是否计算headerview（根据section判断是否单独计算）
/// @param collectionView collectionView description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView isCalculateHeaderViewIndex:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.roundModel.isCalculateHeader;
}
/// 设置是否计算footerview（根据section判断是否单独计算）
/// @param collectionView collectionView description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView isCalculateFooterViewIndex:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.roundModel.isCalculateFooter;
}
/// 背景图点击事件
/// @param collectionView collectionView description
/// @param indexPath 点击背景图的indexPath
- (void)collectionView:(UICollectionView *)collectionView didSelectDecorationViewAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryRightView:didSelectDecorationViewAtIndexPath:)]) {
        [self.delegate categoryRightView:self didSelectDecorationViewAtIndexPath:indexPath];
    }
}
/*
 是否悬停
 */
- (BOOL)collectionView:(UICollectionView *)collectionView sectionHeadersPinAtSection:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.headersHovering;
}
/*
 悬停上部距离
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView sectionHeadersPinTopSpaceAtSection:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.headersHoveringTopEdging;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSouce && [self.dataSouce respondsToSelector:@selector(categoryRightView:cellForItemAtIndexPath:)] && [self.dataSouce categoryRightView:self cellForItemAtIndexPath:indexPath]) {
        return [self.dataSouce categoryRightView:self cellForItemAtIndexPath:indexPath];
    }
    CGXVerticalMenuCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionCell class]) forIndexPath:indexPath];
    CGXVerticalMenuCollectionSectionModel *sectionModel = self.dataArray[indexPath.section];
    CGXVerticalMenuCollectionItemModel *itemModel = sectionModel.rowArray[indexPath.row];
    [cell reloadData:itemModel];
    return cell;
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
}




- (void)setDataSouce:(id<CGXVerticalMenuCollectionViewDataSouce>)dataSouce
{
    _dataSouce = dataSouce;
    if ([self.dataSouce respondsToSelector:@selector(customcategoryRightViewCollectionViewCellClass)] && [self.dataSouce customcategoryRightViewCollectionViewCellClass]) {
        [self registerCell:[self.dataSouce customcategoryRightViewCollectionViewCellClass] IsXib:NO];
    }else if ([self.dataSouce respondsToSelector:@selector(customcategoryRightViewCollectionViewCellNib)] && [self.dataSouce customcategoryRightViewCollectionViewCellNib]) {
        [self registerCell:[self.dataSouce customcategoryRightViewCollectionViewCellNib] IsXib:YES];
    }
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

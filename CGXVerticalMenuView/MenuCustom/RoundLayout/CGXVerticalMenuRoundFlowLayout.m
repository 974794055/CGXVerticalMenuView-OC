//
//  CGXVerticalMenuRoundFlowLayout.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuRoundFlowLayout.h"
#import "CGXVerticalMenuRoundFlowLayoutUtils.h"

static NSString *const CGXVerticalMenuRoundFlowLayoutRoundSection = @"com.CGXVerticalMenuRoundFlowLayoutRoundSection";


@interface CGXVerticalMenuRoundFlowLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;
@property (nonatomic, strong,readwrite) NSArray <UICollectionViewLayoutAttributes *> *sectionHeaderAttributes;

@end

@implementation CGXVerticalMenuRoundFlowLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.isRoundEnabled = YES;
    }
    return self;
}
- (void)prepareLayout{
    [super prepareLayout];
    
    if (!self.isRoundEnabled) {
        return;
    }
    NSInteger sections = [self.collectionView numberOfSections];
    id <CGXVerticalMenuRoundFlowLayoutDelegate> delegate  = (id <CGXVerticalMenuRoundFlowLayoutDelegate>)self.collectionView.delegate;
    //检测是否实现了背景样式模块代理
    if ([delegate respondsToSelector:@selector(collectionView:configModelForSectionAtIndex:)]) {
        //1.初始化
        [self registerClass:[CGXVerticalMenuRoundReusableView class] forDecorationViewOfKind:CGXVerticalMenuRoundFlowLayoutRoundSection];
        [self.decorationViewAttrs removeAllObjects];
        
        for (NSInteger section = 0; section < sections; section++) {
            NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            if (numberOfItems > 0) {
                UICollectionViewLayoutAttributes *firstAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                CGRect firstFrame = firstAttr.frame;
                
                //headerView
                UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                
                //footerView
                UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                
                // 最后一个item
                UICollectionViewLayoutAttributes *lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(numberOfItems - 1) inSection:section]];
                CGRect lastFrame = lastAttr.frame;
                
                BOOL isHeaderAttr = (headerAttr &&
                                     (headerAttr.frame.size.width != 0  && headerAttr.frame.size.height != 0));
                BOOL isFooterAttr = (footerAttr &&
                                     (footerAttr.frame.size.width != 0  && footerAttr.frame.size.height != 0));
                
                //判断是否计算headerview
                BOOL isCalculateHeaderView = [self isCalculateHeaderViewSection:section] && isHeaderAttr;
                //判断是否计算footerView
                BOOL isCalculateFooterView = [self isCalculateFooterViewSection:section] && isFooterAttr;
                
                
                firstFrame = [self calculateDefaultFrameWithFirstHeader:isCalculateHeaderView Section:section NumberOfItems:numberOfItems IsOpen:self.isCalculateOpenIrregularCell];
                lastFrame = [self calculateDefaultFrameWithFirstFooter:isCalculateFooterView Section:section NumberOfItems:numberOfItems IsOpen:self.isCalculateOpenIrregularCell];
                
                
                //获取sectionInset
                UIEdgeInsets sectionInset = [CGXVerticalMenuRoundFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:self atIndex:section];
                CGRect sectionFrame = CGRectUnion(firstFrame, lastFrame);
                
                if (!isCalculateHeaderView && !isCalculateFooterView) {
                    //都没有headerView&footerView
                    sectionFrame = [self calculateDefaultFrameWithSectionFrame:sectionFrame sectionInset:sectionInset];
                }else{
                    
                    if (isCalculateHeaderView && !isCalculateFooterView) {
                        //判断是否有headerview
                        if (isHeaderAttr) {
                            //判断包含headerview, top位置已经计算在内，不需要补偏移
                            sectionFrame.size.height += sectionInset.bottom;
                        }else{
                            sectionFrame = [self calculateDefaultFrameWithSectionFrame:sectionFrame sectionInset:sectionInset];
                        }
                    }else if (!isCalculateHeaderView && isCalculateFooterView) {
                        if (isFooterAttr) {
                            //判断包含footerView, bottom位置已经计算在内，不需要补偏移
                            //(需要补充y偏移)
                            sectionFrame.origin.y -= sectionInset.top;
                            sectionFrame.size.width = self.collectionView.frame.size.width;
                            sectionFrame.size.height += sectionInset.top;
                        }else{
                            sectionFrame = [self calculateDefaultFrameWithSectionFrame:sectionFrame sectionInset:sectionInset];
                        }
                    }else{
                        if (isHeaderAttr && isFooterAttr) {
                            //都有headerview和footerview就不用计算了
                        }else{
                            sectionFrame = [self calculateDefaultFrameWithSectionFrame:sectionFrame sectionInset:sectionInset];
                            
                        }
                    }
                }
                
                UIEdgeInsets userCustomSectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
                if ([delegate respondsToSelector:@selector(collectionView:borderEdgeInsertsForSectionAtIndex:)]) {
                    //检测是否实现了该方法，进行赋值
                    userCustomSectionInset = [delegate collectionView:self.collectionView borderEdgeInsertsForSectionAtIndex:section];
                }
                sectionFrame.origin.x += userCustomSectionInset.left;
                sectionFrame.origin.y += userCustomSectionInset.top;
                if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                    sectionFrame.size.width -= (userCustomSectionInset.left + userCustomSectionInset.right);
                    sectionFrame.size.height -= (userCustomSectionInset.top + userCustomSectionInset.bottom);
                }else{
                    sectionFrame.size.width -= (userCustomSectionInset.left + userCustomSectionInset.right);
                    sectionFrame.size.height -= (userCustomSectionInset.top + userCustomSectionInset.bottom);
                }
                
                //2. 定义
                CGXVerticalMenuRoundLayoutAttributes *attr = [CGXVerticalMenuRoundLayoutAttributes layoutAttributesForDecorationViewOfKind:CGXVerticalMenuRoundFlowLayoutRoundSection withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                attr.frame = sectionFrame;
                attr.zIndex = -1;
                attr.borderEdgeInsets = userCustomSectionInset;
                if ([delegate respondsToSelector:@selector(collectionView:configModelForSectionAtIndex:)]) {
                    attr.myConfigModel = [delegate collectionView:self.collectionView configModelForSectionAtIndex:section];
                }
                [self.decorationViewAttrs addObject:attr];
            }else{
                continue ;
            }
        }
        
        
        if (sections>0) {
            if (self.sectionHeaderAttributes == nil) {
                //获取到所有的sectionHeaderAtrributes，用于后续的点击，滚动到指定contentOffset.y使用
                NSMutableArray *attributes = [NSMutableArray array];
                UICollectionViewLayoutAttributes *lastHeaderAttri = nil;
                for (int i = 0; i < sections; i++) {
                    UICollectionViewLayoutAttributes *attri = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
                    if (attri) {
                        [attributes addObject:attri];
                    }
                    if (i == sections - 1) {
                        lastHeaderAttri = attri;
                    }
                }
                if (attributes.count == 0) {
                    return;
                }
                self.sectionHeaderAttributes = attributes;
                
                //            NSInteger rowCount = [self.collectionView numberOfItemsInSection:sections-1];
                //            //如果最后一个section条目太少了，会导致滚动最底部，但是却不能触发categoryView选中最后一个item。而且点击最后一个滚动的contentOffset.y也不好弄。所以添加contentInset，让最后一个section滚到最下面能显示完整个屏幕。
                //            UICollectionViewLayoutAttributes *lastCellAttri = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:rowCount inSection:sections-1]];
                //            CGFloat lastSectionHeight = CGRectGetMaxY(lastCellAttri.frame) - CGRectGetMinY(lastHeaderAttri.frame);
                //            CGFloat value = self.collectionView.bounds.size.height - lastSectionHeight;
                //            if (value > 0) {
                //                self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, value+20, 0);
                //            }
            }
        }
        
    }
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray * attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        [attrs addObject:attr];
    }
    [self layoutHeaderFooterAttributesForElementsInRect:rect attributes:attrs];
    return attrs;
}
//return YES;表示一旦滑动就实时调用上面这个layoutAttributesForElementsInRect:方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}

- (void)layoutHeaderFooterAttributesForElementsInRect:(CGRect)rect attributes:(NSMutableArray *)superAttributes
{
    NSMutableIndexSet *noneHeaderSections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *attributes in superAttributes)
    {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell)
        {
            [noneHeaderSections addIndex:attributes.indexPath.section];
        }
    }
    for (UICollectionViewLayoutAttributes *attributes in superAttributes)
    {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader])
        {
            [noneHeaderSections removeIndex:attributes.indexPath.section];
            
        }
    }
    [noneHeaderSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (attributes)
        {
            
            [superAttributes addObject:attributes];
        }
    }];
    
    id <CGXVerticalMenuRoundFlowLayoutDelegate> delegate  = (id <CGXVerticalMenuRoundFlowLayoutDelegate>)self.collectionView.delegate;
    
    for (UICollectionViewLayoutAttributes *attributes in superAttributes) {
        BOOL sectionHeaderViewHovering = NO;
        if (delegate && [delegate respondsToSelector:@selector(collectionView:sectionHeadersPinAtSection:)]) {
            sectionHeaderViewHovering = [delegate collectionView:self.collectionView sectionHeadersPinAtSection:attributes.indexPath.section];
        }
        CGFloat sectionHeaderViewHoveringTopEdging = 0;
        if (delegate && [delegate respondsToSelector:@selector(collectionView:sectionHeadersPinTopSpaceAtSection:)]) {
            sectionHeaderViewHoveringTopEdging = [delegate collectionView:self.collectionView sectionHeadersPinTopSpaceAtSection:attributes.indexPath.section];
        }
        UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:attributes.indexPath.section];
        
        if (sectionHeaderViewHovering) {
            if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
                NSInteger numberOfItemsInSection = [self.collectionView numberOfItemsInSection:attributes.indexPath.section];
                NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section];
                NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemsInSection-1) inSection:attributes.indexPath.section];
                UICollectionViewLayoutAttributes *firstItemAttributes, *lastItemAttributes;
                if (numberOfItemsInSection>0){
                    firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                    lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
                }else{
                    firstItemAttributes = [UICollectionViewLayoutAttributes new];
                    CGFloat y = CGRectGetMaxY(attributes.frame)+self.sectionInset.top;
                    firstItemAttributes.frame = CGRectMake(0, y, 0, 0);
                    lastItemAttributes = firstItemAttributes;
                }
                CGRect rect = attributes.frame;
                CGFloat offset = self.collectionView.contentOffset.y + sectionHeaderViewHoveringTopEdging;
                CGFloat headerY = firstItemAttributes.frame.origin.y - rect.size.height - sectionInset.top;
                CGFloat maxY = MAX(offset,headerY);
                CGFloat headerMissingY = CGRectGetMaxY(lastItemAttributes.frame) + sectionInset.bottom - rect.size.height;
                rect.origin.y = MIN(maxY,headerMissingY);
                attributes.frame = rect;
                attributes.zIndex = 1;
            }
        }
    }
}

//判断是否计算headerview
- (BOOL)isCalculateHeaderViewSection:(NSInteger)section
{
    BOOL isCalculateHeaderView = NO;
    id <CGXVerticalMenuRoundFlowLayoutDelegate> delegate  = (id <CGXVerticalMenuRoundFlowLayoutDelegate>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:isCalculateHeaderViewIndex:)]) {
        isCalculateHeaderView = [delegate collectionView:self.collectionView isCalculateHeaderViewIndex:section];
    }else{
        isCalculateHeaderView = self.isCalculateHeader;
    }
    return isCalculateHeaderView;
}
//判断是否计算footerView
- (BOOL)isCalculateFooterViewSection:(NSInteger)section
{
    BOOL isCalculateFooterView = NO;
    id <CGXVerticalMenuRoundFlowLayoutDelegate> delegate  = (id <CGXVerticalMenuRoundFlowLayoutDelegate>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:isCalculateFooterViewIndex:)]) {
        isCalculateFooterView = [delegate collectionView:self.collectionView isCalculateFooterViewIndex:section];
    }else{
        isCalculateFooterView = self.isCalculateFooter;
    }
    return isCalculateFooterView;
}

/// 计算默认不包含headerview和footerview的背景大小
/// @param frame frame description
/// @param sectionInset sectionInset description
- (CGRect)calculateDefaultFrameWithSectionFrame:(CGRect)frame sectionInset:(UIEdgeInsets)sectionInset{
    CGRect sectionFrame = frame;
    sectionFrame.origin.x -= sectionInset.left;
    sectionFrame.origin.y -= sectionInset.top;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        sectionFrame.size.width += sectionInset.left + sectionInset.right;
        //减去系统adjustInset的top
        if (@available(iOS 11.0, *)) {
            sectionFrame.size.height = self.collectionView.frame.size.height - self.collectionView.adjustedContentInset.top;
        } else {
            sectionFrame.size.height = self.collectionView.frame.size.height - fabs(self.collectionView.contentOffset.y)/*适配iOS11以下*/;
        }
    }else{
        sectionFrame.size.width = self.collectionView.frame.size.width;
        sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
    }
    return sectionFrame;
}
/// 计算headerview背景大小
/// @param isCalculateHeaderView  是否计算头
/// @param section  分区
/// @param numberOfItems 第几个
/// @param isOpen 是否打开不规则运算
- (CGRect)calculateDefaultFrameWithFirstHeader:(BOOL)isCalculateHeaderView
                                       Section:(NSInteger)section
                                 NumberOfItems:(NSInteger)numberOfItems
                                        IsOpen:(BOOL)isOpen
{
    BOOL isCalculateOpenIrregularCell = isOpen;
    // 第一个item
    UICollectionViewLayoutAttributes *firstAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    //headerView
    UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    
    CGRect firstFrame = firstAttr.frame;
    if (isCalculateHeaderView) {
        if (headerAttr &&
            (headerAttr.frame.size.width != 0 && headerAttr.frame.size.height != 0)) {
            firstFrame = headerAttr.frame;
        }else{
            CGRect rect = firstFrame;
            if (isCalculateOpenIrregularCell) {
                rect = [CGXVerticalMenuRoundFlowLayoutUtils calculateIrregularitiesCellByMinTopFrameWithLayout:self section:section numberOfItems:numberOfItems defaultFrame:rect];
            }
            firstFrame = CGRectMake(rect.origin.x, rect.origin.y, self.collectionView.bounds.size.width, rect.size.height);
            
        }
    }else{
        //不计算headerview的情况
        if (isCalculateOpenIrregularCell) {
            firstFrame = [CGXVerticalMenuRoundFlowLayoutUtils calculateIrregularitiesCellByMinTopFrameWithLayout:self section:section numberOfItems:numberOfItems defaultFrame:firstFrame];
        }
    }
    
    return firstFrame;
}
/// 计算footerview的背景大小
/// @param isCalculateFooterView  是否计算脚
/// @param section  分区
/// @param numberOfItems 第几个
/// @param isOpen 是否打开不规则运算
- (CGRect)calculateDefaultFrameWithFirstFooter:(BOOL)isCalculateFooterView
                                       Section:(NSInteger)section
                                 NumberOfItems:(NSInteger)numberOfItems
                                        IsOpen:(BOOL)isOpen
{
    BOOL isCalculateOpenIrregularCell = isOpen;
    // 最后一个item
    UICollectionViewLayoutAttributes *lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(numberOfItems - 1) inSection:section]];
    //footerView
    UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    CGRect lastFrame = lastAttr.frame;
    if (isCalculateFooterView) {
        if (footerAttr &&
            (footerAttr.frame.size.width != 0 && footerAttr.frame.size.height != 0)) {
            lastFrame = footerAttr.frame;
        }else{
            CGRect rect = lastFrame;
            if (isCalculateOpenIrregularCell) {
                rect = [CGXVerticalMenuRoundFlowLayoutUtils calculateIrregularitiesCellByMaxBottomFrameWithLayout:self section:section numberOfItems:numberOfItems defaultFrame:rect];
            }
            lastFrame = CGRectMake(rect.origin.x, rect.origin.y, self.collectionView.bounds.size.width, rect.size.height);
        }
    }else{
        //不计算footerView的情况
        if (isCalculateOpenIrregularCell) {
            lastFrame = [CGXVerticalMenuRoundFlowLayoutUtils calculateIrregularitiesCellByMaxBottomFrameWithLayout:self section:section numberOfItems:numberOfItems defaultFrame:lastFrame];
        }
    }
    return lastFrame;
}


#pragma mark - other

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationViewAttrs{
    if (!_decorationViewAttrs) {
        _decorationViewAttrs = [NSMutableArray array];
    }
    return _decorationViewAttrs;
}


- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return self.minimumInteritemSpacing;
    }
}
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    } else {
        return self.minimumLineSpacing;
    }
}
- (CGSize)gx_referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(0, 0);
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        size = [delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
    } else{
        size = self.headerReferenceSize;
    }
    return size;
}
- (CGSize)gx_referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(0, 0);
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        size = [delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
    } else{
        size = self.footerReferenceSize;
    }
    return size;
}
- (UIEdgeInsets)gx_insetForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    } else {
        return self.sectionInset;
    }
}
- (CGSize)gx_sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    } else {
        return self.itemSize;
    }
}



@end

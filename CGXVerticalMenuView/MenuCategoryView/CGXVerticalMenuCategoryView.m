//
//  CGXVerticalMenuView.m
//  CGXVerticalMenuView-OC
//
//  Created by 曹贵鑫 on 2019/9/15.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCategoryView.h"
@interface CGXVerticalMenuCategoryView ()<CGXVerticalMenuTitleViewDelegate,CGXVerticalMenuCollectionViewDelegate>

@property (nonatomic , strong,readwrite) NSMutableArray <CGXVerticalMenuCategoryListModel *> *dataArray;

@property (nonatomic , assign) NSInteger currentInteger;


@property (nonatomic , assign) BOOL dropUpDown;

@property (nonatomic , assign) BOOL isScrollDown;


@property(assign,nonatomic) BOOL isReturnLastOffset;

@end

@implementation CGXVerticalMenuCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftBgColor = [UIColor colorWithRed:29.0/255.0f green:35.0/255.0f blue:69.0/255.0f alpha:1.0];;
        self.righttBgColor = [UIColor whiteColor];
        self.isScrollDown = YES;
        self.isReturnLastOffset=YES;
        //是否允许右位保持滚动位置
        self.isKeepScrollState=YES;
        self.titleWidth = 100;
        self.currentInteger = 0;
        self.dataArray = [NSMutableArray array];
        self.dropUpDown = YES;
        self.leftView = [[CGXVerticalMenuTitleView alloc] initWithFrame:CGRectMake(0, 0, self.titleWidth, CGRectGetHeight(self.bounds))];
        self.leftView.delegate = self;
        self.leftView.backgroundColor = self.leftBgColor;
        [self addSubview:self.leftView];
        
        self.rightView = [[CGXVerticalMenuCollectionView alloc] initWithFrame:CGRectMake(self.titleWidth, 0, CGRectGetWidth(self.bounds)-self.titleWidth, CGRectGetHeight(self.bounds))];
        self.rightView.delegate = self;
        self.rightView.backgroundColor = self.righttBgColor;
        [self addSubview:self.rightView];
        
    }
    return self;
}
- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuCategoryListModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (CGXVerticalMenuCategoryListModel *listModel in dataArray) {
        CGXVerticalMenuTitleModel *itemModel = listModel.leftModel;
        [dataArr addObject:itemModel];
    }
    [self.leftView updateMenuWithDataArray:dataArr];
    
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    CGXVerticalMenuCategoryListModel *listModel = self.dataArray[index];
    [self.rightView updateRightWithDataArray:listModel.rightArray];
    [self keepScrollStateInter:index];
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didScrollerSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    CGXVerticalMenuCategoryListModel *listModel = self.dataArray[index];
    [self.rightView updateRightWithDataArray:listModel.rightArray];
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:didSelectedItemAtIndex:)]) {
        [self.delegate verticalMenuView:self didSelectedItemAtIndex:index];
    }
}

#pragma mark --  右侧代理
- (UICollectionViewCell *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.delegate verticalMenuView:self cellForItemAtIndexPath:indexPath];
}
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:KindHeadAtIndexPath:)]) {
        return [self.delegate verticalMenuView:self KindHeadAtIndexPath:indexPath];
    }
    return [[UICollectionReusableView alloc] init];
}
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindFootAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:KindFootAtIndexPath:)]) {
        return [self.delegate verticalMenuView:self KindFootAtIndexPath:indexPath];
    }
    return [[UICollectionReusableView alloc] init];
}
/**
 点击选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param indexPath 选中的index
 */
- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView didClickSelectedItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:didSelectedItemDetailsAtIndexPath:)]) {
        [self.delegate verticalMenuView:self didSelectedItemDetailsAtIndexPath:indexPath];
    }
}

/**
 滚动选中的情况才会调用该方法
 */
- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView ScrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffsetY = 0;
    if (categoryView.collectionView == scrollView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
    if (self.isReturnLastOffset) {
        CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
        listModel.offsetScorller = scrollView.contentOffset.y;
    }
    
}
// CollectionView分区标题即将展示
- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if (self.isReturnLastOffset) {
        CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
        listModel.offsetScorller = categoryView.collectionView.contentOffset.y;
    }
}
// CollectionView分区标题展示结束
- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isReturnLastOffset) {
        CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
        listModel.offsetScorller = categoryView.collectionView.contentOffset.y;
    }
    
}
-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:categoryView.collectionView]) {
        self.isReturnLastOffset=YES;
    }
}
-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:categoryView.collectionView]) {
        self.isReturnLastOffset=NO;
        if (!decelerate) {
            BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
            if (dragToDragStop) {
                
            }
        }
        if (self.isReturnLastOffset) {
            CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
            listModel.offsetScorller = categoryView.collectionView.contentOffset.y;
        }
        
    }
}
-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:categoryView.collectionView]) {
        self.isReturnLastOffset=NO;
        if (self.isReturnLastOffset) {
            CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
            listModel.offsetScorller = categoryView.collectionView.contentOffset.y;
        }
        
    }
}
- (void)keepScrollStateInter:(NSInteger)inter
{
    self.isReturnLastOffset=NO;
    CGXVerticalMenuCategoryListModel *listModel = self.dataArray[inter];
    [self.leftView.collectionView reloadData];
    if (self.isKeepScrollState) {
        [self.rightView.collectionView scrollRectToVisible:CGRectMake(0, listModel.offsetScorller, self.rightView.collectionView.frame.size.width, self.rightView.collectionView.frame.size.height) animated:NO];
    }else{
        [self.rightView.collectionView scrollRectToVisible:CGRectMake(0, 0, self.rightView.collectionView.frame.size.width, self.rightView.collectionView.frame.size.height) animated:NO];
    }
    
}
@end

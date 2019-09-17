//
//  CGXVerticalMenuView.m
//  CGXVerticalMenuView-OC
//
//  Created by 曹贵鑫 on 2019/9/15.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCategoryView2.h"
@interface CGXVerticalMenuCategoryView2 ()<CGXVerticalMenuTitleViewDelegate,CGXVerticalMenuCollectionViewDelegate>

@property (nonatomic , strong,readwrite) NSMutableArray <CGXVerticalMenuCategoryListModel *> *dataArray;

@property (nonatomic , assign) NSInteger currentInteger;



@end

@implementation CGXVerticalMenuCategoryView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftBgColor = [UIColor colorWithRed:29.0/255.0f green:35.0/255.0f blue:69.0/255.0f alpha:1.0];;
        self.righttBgColor = [UIColor whiteColor];
      

        self.titleWidth = 100;
        self.currentInteger = 0;
        self.dataArray = [NSMutableArray array];
    
        self.leftView = [[CGXVerticalMenuTitleView alloc] initWithFrame:CGRectMake(0, 0, self.titleWidth, CGRectGetHeight(self.bounds))];
        self.leftView.delegate = self;
        self.leftView.backgroundColor = self.leftBgColor;
        [self addSubview:self.leftView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.titleWidth, 0, CGRectGetWidth(self.bounds)-self.titleWidth, CGRectGetHeight(self.bounds)) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CGXVerticalMenuCategoryTableViewCell class] forCellReuseIdentifier:@"CGXVerticalMenuCategoryTableViewCell"];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
         _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.pagingEnabled = YES;
        [self addSubview:_tableView];
        
        
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
    [self.tableView reloadData];
    
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
     [self.tableView reloadData];
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didScrollerSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    [self.tableView reloadData];
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuView:didSelectedItemAtIndex:)]) {
        [self.delegate verticalMenuView:self didSelectedItemAtIndex:index];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%f",CGRectGetHeight(self.bounds));
    return CGRectGetHeight(self.bounds);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CGXVerticalMenuCategoryTableViewCell" forIndexPath:indexPath];
   
//    cell.contentView.backgroundColor = APPRandomColor;
    CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.currentInteger];
    [cell updateCellWithDataArray:listModel.rightArray AtIndex:self.currentInteger];
    cell.rightView.delegate = self;
    return cell;
}
#pragma mark --  右侧代理
- (UICollectionViewCell *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuCollectionCell *cell = [categoryView.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionCell class]) forIndexPath:indexPath];
    CGXVerticalMenuCollectionSectionModel *sectionModel = categoryView.dataArray[indexPath.section];
    CGXVerticalMenuCollectionItemModel *itemModel = sectionModel.rowArray[indexPath.row];
    [cell reloadData:itemModel];
    return cell;
}
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath
{
    
    TitleHeaderView *titleView = [[TitleHeaderView alloc] init];
    titleView.titleLabel.text = [NSString stringWithFormat:@"分区%ld--%ld--%ld",self.currentInteger,indexPath.section,indexPath.row];
    return titleView;
    
    return [[UICollectionReusableView alloc] init];
    
    
}
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindFootAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UICollectionReusableView alloc] init];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll+++:%f",self.tableView.contentOffset.y);
//    if (self.childVCScrollView && self.childVCScrollView.contentOffset.y > 0) {
//        self.tableView.contentOffset = CGPointMake(0, self.headView.frame.size.height);
//    }
}
- (void)personalCenterChildBaseVCScrollViewDidScroll:(UIScrollView *)scrollView
{
//    self.childVCScrollView = scrollView;
//    if (self.tableView.contentOffset.y < self.headView.frame.size.height) {
//        scrollView.contentOffset = CGPointZero;
//        scrollView.showsVerticalScrollIndicator = NO;
//    } else {
//        self.tableView.contentOffset = CGPointMake(0, self.headView.frame.size.height);
//        scrollView.showsVerticalScrollIndicator = YES;
//    }
}

/**
// 点击选中的情况才会调用该方法
// 
// @param categoryView categoryView description
// @param indexPath 选中的index
// */
//- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView didClickSelectedItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
///**
// 滚动选中的情况才会调用该方法
// */
//- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView ScrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"ScrollViewDidScroll++++:%f",self.tableView.contentOffset.y);
//    //    static float lastOffsetY = 0;
//    //    if (categoryView.collectionView == scrollView) {
//    //        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
//    //        lastOffsetY = scrollView.contentOffset.y;
//    //    }
//    //    if (self.isReturnLastOffset) {
//    //        CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
//    //        listModel.offsetScorller = scrollView.contentOffset.y;
//    //    }
//    
//}
//// CollectionView分区标题即将展示
//- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
//{
//    //    if (self.isReturnLastOffset) {
//    //        CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
//    //        listModel.offsetScorller = categoryView.collectionView.contentOffset.y;
//    //    }
//}
//// CollectionView分区标题展示结束
//- (void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//    //    if (self.isReturnLastOffset) {
//    //        CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
//    //        listModel.offsetScorller = categoryView.collectionView.contentOffset.y;
//    //    }
//    
//}
//-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    //    if ([scrollView isEqual:categoryView.collectionView]) {
//    //        self.isReturnLastOffset=YES;
//    //    }
//}
//-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    //    if ([scrollView isEqual:categoryView.collectionView]) {
//    //        self.isReturnLastOffset=NO;
//    //        if (!decelerate) {
//    //            BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
//    //            if (dragToDragStop) {
//    //
//    //            }
//    //        }
//    //        if (self.isReturnLastOffset) {
//    //            CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
//    //            listModel.offsetScorller = categoryView.collectionView.contentOffset.y;
//    //        }
//    //
//    //    }
//}
//-(void)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //    if ([scrollView isEqual:categoryView.collectionView]) {
//    //        self.isReturnLastOffset=NO;
//    //        if (self.isReturnLastOffset) {
//    //            CGXVerticalMenuCategoryListModel *listModel = self.dataArray[self.leftView.selectedIndex];
//    //            listModel.offsetScorller = categoryView.collectionView.contentOffset.y;
//    //        }
//    //
//    //    }
//}
//- (void)keepScrollStateInter:(NSInteger)inter
//{
//    //    self.isReturnLastOffset=NO;
//    //    CGXVerticalMenuCategoryListModel *listModel = self.dataArray[inter];
//    //    [self.leftView.collectionView reloadData];
//    //    if (self.isKeepScrollState) {
//    //        [self.rightView.collectionView scrollRectToVisible:CGRectMake(0, listModel.offsetScorller, self.rightView.collectionView.frame.size.width, self.rightView.collectionView.frame.size.height) animated:NO];
//    //    }else{
//    //        [self.rightView.collectionView scrollRectToVisible:CGRectMake(0, 0, self.rightView.collectionView.frame.size.width, self.rightView.collectionView.frame.size.height) animated:NO];
//    //    }
//    
//}
- (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end

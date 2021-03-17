//
//  CGXVerticalMenuMoreView.m
//  App
//
//  Created by MacMini-1 on 2021/3/9.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreView.h"

#import "CGXVerticalMenuListContainerView.h"

#import "CGXVerticalMenuTitleView.h"

@interface CGXVerticalMenuMoreView ()<CGXVerticalMenuTitleViewDelegate,CGXVerticalMenuListContainerViewDataSource,CGXVerticalMenuMoreListViewDelegate>

@property (nonatomic , strong) CGXVerticalMenuTitleView *leftView;

@property (nonatomic , assign,readwrite) NSInteger currentInteger;

@property (nonatomic, strong) CGXVerticalMenuListContainerView *listContainerView;

@property (nonatomic , strong,readwrite) NSMutableArray <CGXVerticalMenuMoreListModel *> *dataArray;

@end

@implementation CGXVerticalMenuMoreView
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
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self.leftBgColor = [UIColor colorWithWhite:0.93 alpha:1];;
       self.rightBgColor = [UIColor whiteColor];
       self.titleWidth = 100;
       self.currentInteger = 0;
        self.leftView = [[CGXVerticalMenuTitleView alloc] initWithFrame:CGRectMake(0, 0, self.titleWidth, CGRectGetHeight(self.bounds))];
        self.leftView.delegate = self;
        self.leftView.backgroundColor = self.leftBgColor;
        [self addSubview:self.leftView];

        CGXVerticalMenuIndicatorBackgroundView *backgroundView = [[CGXVerticalMenuIndicatorBackgroundView alloc] init];
        backgroundView.backgroundViewColor = [UIColor whiteColor];
        backgroundView.backgroundViewCornerRadius = 0;
        CGXVerticalMenuIndicatorLineView *lineView = [[CGXVerticalMenuIndicatorLineView alloc] init];
        lineView.backgroundColor = [UIColor redColor];
        lineView.positionType = CGXVerticalMenuIndicatorLinePosition_Left;
        self.leftView.indicators = @[lineView,backgroundView];

        self.listContainerView = [[CGXVerticalMenuListContainerView alloc] initWithType:CGXVerticalMenuListContainerType_CollectionView delegate:self];
        self.listContainerView.isHorizontal = YES;
        self.listContainerView.scrollView.scrollEnabled = NO;
        [self addSubview:self.listContainerView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftView.frame = CGRectMake(0, 0, self.titleWidth, CGRectGetHeight(self.frame));
    self.listContainerView.frame = CGRectMake(self.titleWidth, 0, CGRectGetWidth(self.frame)-self.titleWidth, CGRectGetHeight(self.frame));;
}

- (NSMutableArray<CGXVerticalMenuMoreListModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)setLeftBgColor:(UIColor *)leftBgColor
{
    _leftBgColor = leftBgColor;
    self.leftView.backgroundColor = leftBgColor;
}
- (void)setRightBgColor:(UIColor *)rightBgColor
{
    _rightBgColor = rightBgColor;
    self.listContainerView.backgroundColor = rightBgColor;
}

- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didScrollerSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuMoreView:didSelectedItemAtIndex:)]) {
        [self.delegate verticalMenuMoreView:self didSelectedItemAtIndex:index];
    }
    [self.listContainerView scrollSelectedItemAtIndex:index];
}
- (NSInteger)numberOfListsInlistContainerView:(CGXVerticalMenuListContainerView *)listContainerView
{
    return self.dataArray.count;
}
- (id<CGXVerticalMenuListContainerViewDelegate>)listContainerView:(CGXVerticalMenuListContainerView *)listContainerView initListForIndex:(NSInteger)index
{
    CGXVerticalMenuMoreListView *pageScrollView = [[CGXVerticalMenuMoreListView alloc] init];
    pageScrollView.backgroundColor = self.rightBgColor;
    pageScrollView.listDelegate = self;
    CGXVerticalMenuMoreListModel *listModel = self.dataArray[index];
    [pageScrollView updateWithListModel:listModel AtIndex:index];
    pageScrollView.menu_ImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
        if (listModel.menu_ImageCallback) {
            listModel.menu_ImageCallback(hotImageView, hotImageURL);
        };
    };
    return pageScrollView;
}
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)verticalMenuMoreListViewCustomCollectionViewCellClass
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuMoreViewCustomCollectionViewCellClass)] && [self.delegate verticalMenuMoreViewCustomCollectionViewCellClass]) {
        return [self.delegate verticalMenuMoreViewCustomCollectionViewCellClass];
    }
    return nil;
}

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (Class)verticalMenuMoreListViewCustomCollectionViewCellNib
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuMoreViewCustomCollectionViewCellNib)] && [self.delegate verticalMenuMoreViewCustomCollectionViewCellNib]) {
        return [self.delegate verticalMenuMoreViewCustomCollectionViewCellNib];
    }
    return nil;
}
/**
 每个分区自定义cell
 */
- (UICollectionViewCell *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView CollectionView:(nonnull UICollectionView *)collectionView AtIndex:(NSInteger)index cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuMoreView:CollectionView:AtIndex:cellForItemAtIndexPath:)]) {
        return [self.delegate verticalMenuMoreView:self CollectionView:collectionView AtIndex:index cellForItemAtIndexPath:indexPath];
    }
    return nil;
}
- (UIView *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView HeaderAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuMoreView:HeadAtIndex:)]) {
        return [self.delegate verticalMenuMoreView:self HeadAtIndex:index];
    }
    return nil;
}
- (UIView *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView FooterAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuMoreView:FootAtIndex:)]) {
        return [self.delegate verticalMenuMoreView:self FootAtIndex:index];
    }
    return nil;
}

- (UIView *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView AtIndex:(NSInteger)index KindHeadAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuMoreView:AtIndex:KindHeadAtIndexPath:)]) {
        return [self.delegate verticalMenuMoreView:self AtIndex:index KindHeadAtIndexPath:indexPath];
    }
    return nil;
}

- (UIView *)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView AtIndex:(NSInteger)index KindFootAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(verticalMenuMoreView:AtIndex:KindFootAtIndexPath:)]) {
        return [self.delegate verticalMenuMoreView:self AtIndex:index KindFootAtIndexPath:indexPath];
    }
    return nil;
}
- (void)verticalMenuMoreListView:(CGXVerticalMenuMoreListView *)listView AtIndex:(NSInteger)index didClickSelectedItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate  respondsToSelector:@selector(verticalMenuMoreView:AtIndex:didSelectedItemDetailsAtIndexPath:)]) {
        [self.delegate verticalMenuMoreView:self AtIndex:index didSelectedItemDetailsAtIndexPath:indexPath];
    }
}

/*
 数据源
 */
- (void)updateListWithDataArray:(NSMutableArray<CGXVerticalMenuMoreListModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (CGXVerticalMenuMoreListModel *listModel in self.dataArray) {
        CGXVerticalMenuTitleModel *itemModel = listModel.leftModel;
        [dataArr addObject:itemModel];
    }
    [self.leftView updateMenuWithDataArray:dataArr];
}
/*
  更新某个下标数据使用
*/
- (void)updateListWistAtIndex:(NSInteger)index ItemModel:(CGXVerticalMenuMoreListModel  *)itemModel
{
    if (self.dataArray.count==0 || index<0) {
        return;
    }
    if (index>self.dataArray.count-1) {
        return;
    }
    [self.dataArray replaceObjectAtIndex:index withObject:itemModel];
    [self.listContainerView reloadData];
}
- (void)reloadData
{
    [self.leftView.collectionView reloadData];
    [self.listContainerView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

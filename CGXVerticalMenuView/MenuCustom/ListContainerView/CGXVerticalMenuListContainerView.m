//
//  CGXVerticalMenuListContainerView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "CGXVerticalMenuListContainerView.h"
#import <objc/runtime.h>

#import "CGXVerticalMenuListContainerViewController.h"
#import "CGXVerticalMenuListContainerViewCell.h"

@interface CGXVerticalMenuListContainerView () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) id<CGXVerticalMenuListContainerViewDataSource> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign,readwrite) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<CGXVerticalMenuListContainerViewDelegate>> *validListDict;
@property (nonatomic, assign) NSInteger willAppearIndex;
@property (nonatomic, assign) NSInteger willDisappearIndex;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CGXVerticalMenuListContainerViewController *containerVC;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation CGXVerticalMenuListContainerView

- (instancetype)initWithType:(CGXVerticalMenuListContainerType)type delegate:(id<CGXVerticalMenuListContainerViewDataSource>)delegate{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _containerType = type;
        _delegate = delegate;
        _validListDict = [NSMutableDictionary dictionary];
        _willAppearIndex = -1;
        _willDisappearIndex = -1;
        _initListPercent = 0.01;
        self.isHorizontal = NO;
        [self initializeViews];
    }
    return self;
}
- (void)setIsHorizontal:(BOOL)isHorizontal
{
    _isHorizontal = isHorizontal;
    if (self.containerType == CGXVerticalMenuListContainerType_ScrollView) {
        self.scrollView.scrollEnabled = self.isHorizontal ? YES:NO;
    } else{
        self.collectionView.scrollEnabled = self.isHorizontal ? YES:NO;
        if (self.isHorizontal) {
            self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        } else{
            self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        self.collectionView.collectionViewLayout = self.layout;
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
}
- (void)initializeViews {
    _listCellBackgroundColor = [UIColor whiteColor];
    _containerVC = [[CGXVerticalMenuListContainerViewController alloc] init];
    self.containerVC.view.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containerVC.view];
    __weak typeof(self) weakSelf = self;
    self.containerVC.viewWillAppearBlock = ^{
        [weakSelf listWillAppear:weakSelf.currentIndex];
    };
    self.containerVC.viewDidAppearBlock = ^{
        [weakSelf listDidAppear:weakSelf.currentIndex];
    };
    self.containerVC.viewWillDisappearBlock = ^{
        [weakSelf listWillDisappear:weakSelf.currentIndex];
    };
    self.containerVC.viewDidDisappearBlock = ^{
        [weakSelf listDidDisappear:weakSelf.currentIndex];
    };
    if (self.containerType == CGXVerticalMenuListContainerType_ScrollView) {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(scrollViewClassInlistContainerView:)] &&
            [[self.delegate scrollViewClassInlistContainerView:self] isKindOfClass:object_getClass([UIScrollView class])]) {
            _scrollView = (UIScrollView *)[[[self.delegate scrollViewClassInlistContainerView:self] alloc] init];
        }else {
            _scrollView = [[UIScrollView alloc] init];
        }
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            if ([self.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        [self.containerVC.view addSubview:self.scrollView];
    }else {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        if (self.isHorizontal) {
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        } else{
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        self.layout = layout;
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(scrollViewClassInlistContainerView:)] &&
            [[self.delegate scrollViewClassInlistContainerView:self] isKindOfClass:object_getClass([UICollectionView class])]) {
            _collectionView = (UICollectionView *)[[[self.delegate scrollViewClassInlistContainerView:self] alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        }else {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        }
        self.collectionView.backgroundColor = self.backgroundColor;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.scrollsToTop = NO;
        self.collectionView.bounces = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[CGXVerticalMenuListContainerViewCell class] forCellWithReuseIdentifier:NSStringFromClass( [CGXVerticalMenuListContainerViewCell class])];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        if (@available(iOS 10.0, *)) {
            self.collectionView.prefetchingEnabled = NO;
        }
        if (@available(iOS 11.0, *)) {
            if ([self.collectionView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        self.collectionView.scrollEnabled = self.isHorizontal ? YES:NO;
        [self.containerVC.view addSubview:self.collectionView];
        //让外部统一访问scrollView
        _scrollView = _collectionView;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            [((UIViewController *)next) addChildViewController:self.containerVC];
            break;
        }
        next = next.nextResponder;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.containerVC.view.frame = self.bounds;
    if (self.containerType == CGXVerticalMenuListContainerType_ScrollView) {
        if (CGRectEqualToRect(self.scrollView.frame, CGRectZero) ||  !CGSizeEqualToSize(self.scrollView.bounds.size, self.bounds.size)) {
            self.scrollView.frame = self.bounds;
            if (self.isHorizontal) {
                self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
            }else{
                self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height*[self.delegate numberOfListsInlistContainerView:self]);
            }
            [_validListDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull index, id<CGXVerticalMenuListContainerViewDelegate>  _Nonnull list, BOOL * _Nonnull stop) {
                if (self.isHorizontal) {
                    [list listView].frame = CGRectMake(index.intValue*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
                }else{
                    [list listView].frame = CGRectMake(0, index.intValue*self.scrollView.bounds.size.height, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
                }
            }];
            if (self.isHorizontal) {
                self.scrollView.contentOffset = CGPointMake(self.currentIndex*self.scrollView.bounds.size.width, 0);
            }else{
                self.scrollView.contentOffset = CGPointMake(0, self.currentIndex*self.scrollView.bounds.size.height);
            }
        }else {
            self.scrollView.frame = self.bounds;
            if (self.isHorizontal) {
                self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
            }else{
                self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height*[self.delegate numberOfListsInlistContainerView:self]);
            }
        }
    }else {
        if (CGRectEqualToRect(self.collectionView.frame, CGRectZero) ||  !CGSizeEqualToSize(self.collectionView.bounds.size, self.bounds.size)) {
            [self.collectionView.collectionViewLayout invalidateLayout];
            self.collectionView.frame = self.bounds;
            [self.collectionView reloadData];
            if (self.isHorizontal) {
                [self.collectionView setContentOffset:CGPointMake(self.collectionView.bounds.size.width*self.currentIndex, 0) animated:NO];
            } else{
                [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.bounds.size.height*self.currentIndex) animated:NO];
            }
        }else {
            self.collectionView.frame = self.bounds;
        }
    }
    [self reloadData];
}


- (void)setinitListPercent:(CGFloat)initListPercent {
    _initListPercent = initListPercent;
    if (initListPercent <= 0 || initListPercent >= 1) {
        NSAssert(NO, @"initListPercent值范围为开区间(0,1)，即不包括0和1");
    }
}

- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    self.scrollView.bounces = bounces;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.delegate numberOfListsInlistContainerView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGXVerticalMenuListContainerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass( [CGXVerticalMenuListContainerViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.listCellBackgroundColor;
    id<CGXVerticalMenuListContainerViewDelegate> list = _validListDict[@(indexPath.item)];
    BOOL canInitList = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
        canInitList = [self.delegate listContainerView:self canInitListAtIndex:indexPath.item];
    }
    if (canInitList) {
        if (list == nil && self.delegate && [self.delegate respondsToSelector:@selector(listContainerView:initListForIndex:)]) {
            list = [self.delegate listContainerView:self initListForIndex:indexPath.item];
            if (list != nil) {
                _validListDict[@(indexPath.item)] = list;
            }
        }
        [cell updateWithCellModel:list];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listContainerViewDidScroll:)]) {
        [self.delegate listContainerViewDidScroll:scrollView];
    }
    
    if (!scrollView.isDragging && !scrollView.isTracking && !scrollView.isDecelerating) {
        return;
    }
    CGFloat ratio = scrollView.contentOffset.y/scrollView.bounds.size.height;
    NSInteger maxCount = round(scrollView.contentSize.height/scrollView.bounds.size.height);
    
    if (self.isHorizontal) {
        ratio = scrollView.contentOffset.x/scrollView.bounds.size.width;
        maxCount = round(scrollView.contentSize.width/scrollView.bounds.size.width);
    }
    
    NSInteger leftIndex = floorf(ratio);
    leftIndex = MAX(0, MIN(maxCount - 1, leftIndex));
    NSInteger rightIndex = leftIndex + 1;
    if (ratio < 0 || rightIndex >= maxCount) {
        [self listDidAppearOrDisappear:scrollView];
        return;
    }
    CGFloat remainderRatio = ratio - leftIndex;
    if (rightIndex == self.currentIndex) {
        //当前选中的在右边，用户正在从右边往左边滑动
        if (self.validListDict[@(leftIndex)] == nil && remainderRatio < (1 - self.initListPercent)) {
            [self initListIfNeededAtIndex:leftIndex];
        }else if (self.validListDict[@(leftIndex)] != nil) {
            if (self.willAppearIndex == -1) {
                self.willAppearIndex = leftIndex;
                [self listWillAppear:self.willAppearIndex];
            }
        }
        if (self.willDisappearIndex == -1) {
            self.willDisappearIndex = rightIndex;
            [self listWillDisappear:self.willDisappearIndex];
        }
    }else {
        //当前选中的在左边，用户正在从左边往右边滑动
        if (self.validListDict[@(rightIndex)] == nil && remainderRatio > self.initListPercent) {
            [self initListIfNeededAtIndex:rightIndex];
        }else if (self.validListDict[@(rightIndex)] != nil) {
            if (self.willAppearIndex == -1) {
                self.willAppearIndex = rightIndex;
                [self listWillAppear:self.willAppearIndex];
            }
        }
        if (self.willDisappearIndex == -1) {
            self.willDisappearIndex = leftIndex;
            [self listWillDisappear:self.willDisappearIndex];
        }
    }
    [self listDidAppearOrDisappear:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //滑动到一半又取消滑动处理
    if (self.willDisappearIndex != -1) {
        [self listWillAppear:self.willDisappearIndex];
        [self listWillDisappear:self.willAppearIndex];
        [self listDidAppear:self.willDisappearIndex];
        [self listDidDisappear:self.willAppearIndex];
        self.willDisappearIndex = -1;
        self.willAppearIndex = -1;
    }
}

- (void)didClickSelectedItemAtIndex:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    self.willAppearIndex = -1;
    self.willDisappearIndex = -1;
    if (self.currentIndex != index) {
        [self listWillDisappear:self.currentIndex];
        [self listDidDisappear:self.currentIndex];
        [self listWillAppear:index];
        [self listDidAppear:index];
    }
}

- (void)reloadData {
    for (id<CGXVerticalMenuListContainerViewDelegate> list in _validListDict.allValues) {
        [[list listView] removeFromSuperview];
        if ([list isKindOfClass:[UIViewController class]]) {
            [(UIViewController *)list removeFromParentViewController];
        }
    }
    [_validListDict removeAllObjects];
    
    if (self.containerType == CGXVerticalMenuListContainerType_ScrollView) {
        if (self.isHorizontal) {
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
        } else{
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height*[self.delegate numberOfListsInlistContainerView:self]);
        }
    }else {
        [self.collectionView reloadData];
    }
    [self listWillAppear:self.currentIndex];
    [self listDidAppear:self.currentIndex];
}

#pragma mark - Private

- (void)initListIfNeededAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
        BOOL canInitList = [self.delegate listContainerView:self canInitListAtIndex:index];
        if (!canInitList) {
            return;
        }
    }
    id<CGXVerticalMenuListContainerViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        //列表已经创建好了
        return;
    }
    list = [self.delegate listContainerView:self initListForIndex:index];
    if ([list isKindOfClass:[UIViewController class]]) {
        [self.containerVC addChildViewController:(UIViewController *)list];
    }
    _validListDict[@(index)] = list;
    
    if (self.containerType == CGXVerticalMenuListContainerType_ScrollView) {
        if (self.isHorizontal) {
            [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        } else{
            [list listView].frame = CGRectMake(0, index*self.scrollView.bounds.size.height, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        }
        
        [self.scrollView addSubview:[list listView]];
    }else {
        CGXVerticalMenuListContainerViewCell *cell = (CGXVerticalMenuListContainerViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [cell updateWithCellModel:list];
    }
}

- (void)listWillAppear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<CGXVerticalMenuListContainerViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        [self listWillVCAppearAtIndex:index];
    }else {
        //当前列表未被创建（页面初始化或通过点击触发的listWillAppear）
        BOOL canInitList = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
            canInitList = [self.delegate listContainerView:self canInitListAtIndex:index];
        }
        if (canInitList) {
            id<CGXVerticalMenuListContainerViewDelegate> list = _validListDict[@(index)];
            if (list == nil) {
                list = [self.delegate listContainerView:self initListForIndex:index];
                if ([list isKindOfClass:[UIViewController class]]) {
                    [self.containerVC addChildViewController:(UIViewController *)list];
                }
                _validListDict[@(index)] = list;
            }
            if (self.containerType == CGXVerticalMenuListContainerType_ScrollView) {
                if ([list listView].superview == nil) {
                    if (self.isHorizontal) {
                        [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
                    } else{
                        [list listView].frame = CGRectMake(0, index*self.scrollView.bounds.size.height, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
                    }
                    
                    [self.scrollView addSubview:[list listView]];
                    [self listWillVCAppearAtIndex:index];
                }
            }else {
                CGXVerticalMenuListContainerViewCell *cell = (CGXVerticalMenuListContainerViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
                [cell updateWithCellModel:list];

                if (list && [list respondsToSelector:@selector(listWillAppearAtIndex:)]) {
                    [list listWillAppearAtIndex:index];
                }
                if ([list isKindOfClass:[UIViewController class]]) {
                    UIViewController *listVC = (UIViewController *)list;
                    [listVC beginAppearanceTransition:YES animated:NO];
                }
            }
        }
    }
}

- (void)listDidAppear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    self.currentIndex = index;
    id<CGXVerticalMenuListContainerViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidAppearAtIndex:)]) {
        [list listDidAppearAtIndex:index];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC endAppearanceTransition];
    }
}

- (void)listWillDisappear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<CGXVerticalMenuListContainerViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listWillDisappearAtIndex:)]) {
        [list listWillDisappearAtIndex:index];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC beginAppearanceTransition:NO animated:NO];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<CGXVerticalMenuListContainerViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappearAtIndex:)]) {
        [list listDidDisappearAtIndex:index];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC endAppearanceTransition];
    }
}

- (BOOL)checkIndexValid:(NSInteger)index {
    NSUInteger count = [self.delegate numberOfListsInlistContainerView:self];
    if (count <= 0 || index >= count) {
        return NO;
    }
    return YES;
}

- (void)listDidAppearOrDisappear:(UIScrollView *)scrollView {
    CGFloat currentIndexPercent = scrollView.contentOffset.y/scrollView.bounds.size.height;
    if (self.isHorizontal) {
        currentIndexPercent = scrollView.contentOffset.x/scrollView.bounds.size.width;
    }
    if (self.willAppearIndex != -1 || self.willDisappearIndex != -1) {
        NSInteger disappearIndex = self.willDisappearIndex;
        NSInteger appearIndex = self.willAppearIndex;
        if (self.willAppearIndex > self.willDisappearIndex) {
            //将要出现的列表在右边
            if (currentIndexPercent >= self.willAppearIndex) {
                self.willDisappearIndex = -1;
                self.willAppearIndex = -1;
                [self listDidDisappear:disappearIndex];
                [self listDidAppear:appearIndex];
            }
        }else {
            //将要出现的列表在左边
            if (currentIndexPercent <= self.willAppearIndex) {
                self.willDisappearIndex = -1;
                self.willAppearIndex = -1;
                [self listDidDisappear:disappearIndex];
                [self listDidAppear:appearIndex];
            }
        }
    }
}
- (void)listWillVCAppearAtIndex:(NSInteger)index
{
    if (![self checkIndexValid:index]) {
        return;
    }
    id<CGXVerticalMenuListContainerViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listWillAppearAtIndex:)]) {
        [list listWillAppearAtIndex:index];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC beginAppearanceTransition:YES animated:NO];
    }
}

- (void)scrollSelectedItemAtIndex:(NSInteger)index
{
    if (self.containerType == CGXVerticalMenuListContainerType_ScrollView) {
        if (self.isHorizontal) {
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*index, self.scrollView.bounds.size.height);
        }else{
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height*index);
        }
    }else{
        if (self.isHorizontal) {
            [self.collectionView setContentOffset:CGPointMake(CGRectGetWidth(self.frame)*index, 0) animated:NO];
        }else{
            [self.collectionView setContentOffset:CGPointMake(0, CGRectGetHeight(self.frame)*index) animated:NO];
        }
        [self.collectionView reloadData];
    }
}

@end

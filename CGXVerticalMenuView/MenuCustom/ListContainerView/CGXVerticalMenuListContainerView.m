//
//  CGXVerticalMenuListContainerView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuListContainerView.h"
#import <objc/runtime.h>

#import "CGXVerticalMenuListContainerViewController.h"


@interface CGXVerticalMenuListContainerView () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) id<CGXVerticalMenuListContainerViewDataSource> delegate;
@property (nonatomic, assign,readwrite) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<CGXVerticalMenuListContainerViewDelegate>> *validListDict;
@property (nonatomic, assign) NSInteger willAppearIndex;
@property (nonatomic, assign) NSInteger willDisappearIndex;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CGXVerticalMenuListContainerViewController *containerVC;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation CGXVerticalMenuListContainerView

- (instancetype)initWithDelegate:(id<CGXVerticalMenuListContainerViewDataSource>)delegate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _delegate = delegate;
        self.backgroundColor = [UIColor whiteColor];
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
    
    if (self.isHorizontal) {
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    } else{
        self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    self.collectionView.collectionViewLayout = self.layout;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}
- (void)initializeViews {
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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass( [UICollectionViewCell class])];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    if (@available(iOS 10.0, *)) {
        self.collectionView.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        if ([self.collectionView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    [self.containerVC.view addSubview:self.collectionView];
    
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
    self.collectionView.backgroundColor = self.backgroundColor;
    if (CGRectEqualToRect(self.collectionView.frame, CGRectZero) ||  !CGSizeEqualToSize(self.collectionView.bounds.size, self.bounds.size)) {
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
    self.collectionView.frame = self.bounds;
    [self scrollSelectedItemAtIndex:self.currentIndex];
    [self.collectionView reloadData];
}


- (void)setinitListPercent:(CGFloat)initListPercent {
    _initListPercent = initListPercent;
    if (initListPercent <= 0 || initListPercent >= 1) {
        NSAssert(NO, @"initListPercent值范围为开区间(0,1)，即不包括0和1");
    }
}

- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    self.collectionView.bounces = bounces;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.delegate numberOfListsInlistContainerView:self];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.backgroundColor;
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
        for (UIView *subview in cell.contentView.subviews) {
            [subview removeFromSuperview];
        }
        if (list != nil) {
            [list listView].frame = cell.contentView.bounds;
            [cell.contentView addSubview:[list listView]];
        }
        
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
    
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    if (list != nil) {
        [list listView].frame = cell.contentView.bounds;
        [cell.contentView addSubview:[list listView]];
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
            
            UICollectionViewCell *cell = (UICollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
            for (UIView *subview in cell.contentView.subviews) {
                [subview removeFromSuperview];
            }
            if (list != nil) {
                [list listView].frame = cell.contentView.bounds;
                [cell.contentView addSubview:[list listView]];
            }
            
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


- (UIScrollView *)contentScrollView {
    return self.collectionView;
}

- (void)setDefaultSelectedIndex:(NSInteger)index {
    self.currentIndex = index;
}

- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex {
    if (rightIndex == selectedIndex) {
        //当前选中的在右边，用户正在从右边往左边滑动
        if (ratio < (1 - self.initListPercent)) {
            [self initListIfNeededAtIndex:leftIndex];
        }
        if (self.willAppearIndex == -1) {
            self.willAppearIndex = leftIndex;
            if (self.validListDict[@(leftIndex)] != nil) {
                [self listWillAppear:self.willAppearIndex];
            }
        }
        if (self.willDisappearIndex == -1) {
            self.willDisappearIndex = rightIndex;
            [self listWillDisappear:self.willDisappearIndex];
        }
    }else {
        //当前选中的在左边，用户正在从左边往右边滑动
        if (ratio > self.initListPercent) {
            [self initListIfNeededAtIndex:rightIndex];
        }
        if (self.willAppearIndex == -1) {
            self.willAppearIndex = rightIndex;
            if (_validListDict[@(rightIndex)] != nil) {
                [self listWillAppear:self.willAppearIndex];
            }
        }
        if (self.willDisappearIndex == -1) {
            self.willDisappearIndex = leftIndex;
            [self listWillDisappear:self.willDisappearIndex];
        }
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

- (void)scrollSelectedItemAtIndex:(NSInteger)index
{
    if (![self checkIndexValid:index]) {
        return;
    }
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    if (self.isHorizontal) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    }
    self.currentIndex = index;
    [self.collectionView reloadData];
}
- (void)reloadData {
    for (id<CGXVerticalMenuListContainerViewDelegate> list in _validListDict.allValues) {
        [[list listView] removeFromSuperview];
        if ([list isKindOfClass:[UIViewController class]]) {
            [(UIViewController *)list removeFromParentViewController];
        }
    }
    [_validListDict removeAllObjects];
    
    [self.collectionView reloadData];
    [self listWillAppear:self.currentIndex];
    [self listDidAppear:self.currentIndex];
}
@end

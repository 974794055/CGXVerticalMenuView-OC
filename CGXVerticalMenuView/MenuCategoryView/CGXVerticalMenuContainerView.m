//
//  CGXVerticalMenuContainerView.m
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2019/9/20.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuContainerView.h"
@interface CGXVerticalMenuContainerView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) CGXVerticalMenuContainerCollectionView *collectionView;

@property (nonatomic , assign) NSInteger currentInteger;

@property (nonatomic, assign) BOOL isFirstLayoutSubviews;



@end
@implementation CGXVerticalMenuContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    self.animated = NO;
    self.isClickScroll = YES;
    self.currentInteger = 0;
   self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[CGXVerticalMenuContainerCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.scrollsToTop = NO;
     self.collectionView.scrollEnabled = NO;
    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = self.backgroundColor;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    if (@available(iOS 10.0, *)) {
        self.collectionView.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
     self.collectionView.frame = self.bounds;
    if (!CGRectEqualToRect(self.collectionView.frame, self.bounds)) {
        self.collectionView.frame = self.bounds;
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
    if (self.currentInteger >=0 && [self.dataSouce numberOfRowsInListContainerView:self] >= self.currentInteger + 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentInteger inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    if (self.isFirstLayoutSubviews) {
        self.isFirstLayoutSubviews = NO;
        [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.bounds.size.height*self.currentInteger) animated:NO];
    }
}

- (void)reloadDataToItemAtIndex:(NSInteger)integer
{
     [self.collectionView reloadData];
    
    if (self.dataSouce == nil) {
        return;
    }
    if (integer >= [self.dataSouce numberOfRowsInListContainerView:self]) {
        return;
    }
    self.currentInteger = integer;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentInteger inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:(self.isClickScroll ? NO:self.animated)];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSouce == nil) {
        return 0;
    }
    return [self.dataSouce numberOfRowsInListContainerView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIView *listView = [self.dataSouce verticalListContainerView:self listViewInRow:indexPath.item];
    listView.frame = cell.bounds;
    [cell.contentView addSubview:listView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate verticalListContainerView:self willDisplayCellAtRow:indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate verticalListContainerView:self didEndDisplayingCellAtRow:indexPath.item];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return false;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {

    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

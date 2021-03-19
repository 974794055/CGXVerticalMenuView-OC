//
//  CGXVerticalMenuMoreListView.m
//  App
//
//  Created by MacMini-1 on 2021/3/15.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListView.h"
#import "CGXVerticalMenuMoreListViewCell.h"
#import "CGXVerticalMenuMoreListViewItemCell.h"
#import "CGXVerticalMenuMoreListTitleView.h"

@interface CGXVerticalMenuMoreListView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,CGXVerticalMenuMoreListViewCellDelegate>
{
    CGSize imageSize;
}
@property (strong ,nonatomic) UITableView *mainTable;
@property (strong ,nonatomic) UIView *headerView;
@property (strong ,nonatomic) UIImageView *ppImageView;
@property (strong ,nonatomic) CGXVerticalMenuMoreListTitleView *titleView;
@property (nonatomic , assign) NSInteger selectedIndex;
@property (nonatomic , assign) NSInteger selectedTitleIndex;
@property (nonatomic , strong) CGXVerticalMenuMoreListModel *listModel;

@end

@implementation CGXVerticalMenuMoreListView
- (UIView *)listView
{
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedIndex = 0;
        self.selectedTitleIndex = 0;
        self.dataArray = [NSMutableArray array];
        _mainTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.bounces = YES;
        _mainTable.alwaysBounceVertical = YES;
        _mainTable.showsVerticalScrollIndicator = YES;
        _mainTable.showsHorizontalScrollIndicator = NO;
        _mainTable.tableHeaderView = [[UIView alloc] init];
        _mainTable.tableFooterView = [[UIView alloc] init];
        [_mainTable registerClass:[CGXVerticalMenuMoreListViewCell class] forCellReuseIdentifier:NSStringFromClass([CGXVerticalMenuMoreListViewCell class])];
        [self addSubview:_mainTable];
        [_mainTable reloadData];

    }
    return self;
}
- (void)setListDelegate:(id<CGXVerticalMenuMoreListViewDelegate>)listDelegate
{
    _listDelegate = listDelegate;
 
}
- (void)refreshHeaderView
{
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(verticalMenuMoreListView:HeaderAtIndex:)] && [self.listDelegate verticalMenuMoreListView:self HeaderAtIndex:self.selectedIndex]) {
        self.headerView = [self.listDelegate verticalMenuMoreListView:self HeaderAtIndex:self.selectedIndex];
        self.headerView.backgroundColor = self.listModel.headColor;
        self.mainTable.tableHeaderView = self.headerView;
    } else{
        self.headerView = [[UIView alloc] init];
        self.headerView.backgroundColor = self.listModel.headColor;
        self.ppImageView = [[UIImageView alloc] init];
        self.ppImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.ppImageView.layer.masksToBounds = YES;
        self.ppImageView.clipsToBounds = YES;
        self.ppImageView.layer.borderColor = [self.listModel.headBorderColor CGColor];
        self.ppImageView.layer.borderWidth = self.listModel.headBorderWidth;
        self.ppImageView.layer.cornerRadius = self.listModel.headCornerRadius;
        [self.headerView addSubview:self.ppImageView];
        self.mainTable.tableHeaderView = self.headerView;
    }
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(verticalMenuMoreListView:FooterAtIndex:)] && [self.listDelegate verticalMenuMoreListView:self FooterAtIndex:self.selectedIndex]) {
        UIView *footerView = [self.listDelegate verticalMenuMoreListView:self FooterAtIndex:self.selectedIndex];
        footerView.backgroundColor = self.backgroundColor;
        _mainTable.tableFooterView = footerView;
    } else{
        _mainTable.tableFooterView = [UIView new];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _mainTable.frame = self.bounds;
    _mainTable.backgroundColor = self.backgroundColor;

    if ([self.listModel.headUrl hasPrefix:@"http:"] || [self.listModel.headUrl hasPrefix:@"https:"]) {
        NSURL *url = [NSURL URLWithString:self.listModel.headUrl];
       __block BOOL open = NO;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"HEAD"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                open = NO;
            }else{
                open = YES;
            }
        }];
        [task resume];
        if (open) {
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            imageSize = image.size;
            if (self.menu_ImageCallback) {
                self.menu_ImageCallback(self.ppImageView, url);
            }
        }
    } else{
        UIImage *image = [UIImage imageNamed:self.listModel.headUrl];
        if (!image) {
            image = [UIImage imageWithContentsOfFile:self.listModel.headUrl];
            self.ppImageView.image = image;
        }
        imageSize = image.size;
        if (self.menu_ImageCallback) {
            self.menu_ImageCallback(self.ppImageView, [NSURL URLWithString:@""]);
        }
    }
    if (imageSize.width > 0 && imageSize.height > 0) {
        CGFloat width = CGRectGetWidth(_mainTable.frame)-self.listModel.headEdgeInsets.left-self.listModel.headEdgeInsets.right;
        CGFloat height = ceil(imageSize.height / imageSize.width * width);
        self.ppImageView.frame = CGRectMake(self.listModel.headEdgeInsets.left, self.listModel.headEdgeInsets.top, CGRectGetWidth(self.frame)-self.listModel.headEdgeInsets.left-self.listModel.headEdgeInsets.right, height);
        self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth(_mainTable.frame), height+self.listModel.headEdgeInsets.top+self.listModel.headEdgeInsets.bottom);
    }
    [_mainTable reloadData];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuMoreListSectionModel *listModel = self.dataArray[indexPath.row];
    CGFloat space1 = listModel.insets.left+listModel.insets.right;
    CGFloat space0 = listModel.borderInsets.left+listModel.borderInsets.right;
    
    CGFloat space3 = listModel.insets.top+listModel.insets.bottom;
    CGFloat space4 = listModel.borderInsets.top+listModel.borderInsets.bottom;
    
    if (listModel.roundModel.isCalculateFooter && listModel.footerHeight > 0) {
        space4 = space4 +listModel.borderInsets.bottom;
    }
    if (listModel.roundModel.isCalculateHeader && listModel.headerHeight > 0) {
        space4 = space4 +listModel.borderInsets.top;
    }
    
    CGFloat width = floor( (CGRectGetWidth(self.frame)-space1-space0-(listModel.rowCount-1)*listModel.minimumLineSpacing)/listModel.rowCount);
    CGFloat height = width * listModel.itemSpace+listModel.itemHeight;
    NSInteger count1 = listModel.dataArray.count / listModel.rowCount;
    NSInteger count2 = listModel.dataArray.count % listModel.rowCount;
    NSInteger count = count1 + (count2 > 0 ? 1:0);
    return height*count + listModel.headerHeight+listModel.footerHeight + (count-1)*listModel.minimumInteritemSpacing+space3+space4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.listModel.haveTitleView) {
        return self.listModel.titleHeight;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderView"];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderView"];
    }
    headerView.contentView.backgroundColor = self.listModel.headColor;
    if (self.listModel.haveTitleView) {
        headerView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), self.listModel.titleHeight);
        [headerView.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        CGXVerticalMenuMoreListTitleView *titleView = [[CGXVerticalMenuMoreListTitleView alloc] init];
        titleView.frame = CGRectMake(0, self.listModel.titleSpace/2.0, CGRectGetWidth(headerView.frame), CGRectGetHeight(headerView.frame)-self.listModel.titleSpace);;
        [headerView.contentView addSubview:titleView];
        NSMutableArray *titieArr = [NSMutableArray array];
        for (CGXVerticalMenuMoreListSectionModel *listM in self.dataArray) {
            [titieArr addObject:listM.headNameModel.text];
        }
        [titleView updateDataTitieArray:titieArr TitleModel:self.listModel.titleModel Inter:self.selectedTitleIndex];
        titleView.titieSelectBlock = ^(NSInteger integer) {
            self.selectedTitleIndex = integer;
            [self.mainTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:integer inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        };
        self.titleView = titleView;
    }
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewFooterView"];
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewFooterView"];
    }
    footerView.contentView.backgroundColor = tableView.backgroundColor;
    return footerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGXVerticalMenuMoreListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CGXVerticalMenuMoreListViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = tableView.backgroundColor;
    CGXVerticalMenuMoreListSectionModel *listModel = self.dataArray[indexPath.row];
    [cell updateWithListModel:listModel];
    cell.delegate = self;
    return cell;
}
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClass
{
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(verticalMenuMoreListViewCustomCollectionViewCellClass)]) {
        return [self.listDelegate verticalMenuMoreListViewCustomCollectionViewCellClass];
    }
    return nil;
}

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
- (Class)customCollectionViewCellNib
{
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(verticalMenuMoreListViewCustomCollectionViewCellNib)]) {
        return [self.listDelegate verticalMenuMoreListViewCustomCollectionViewCellNib];
    }
    return nil;
}
/**
 每个分区自定义cell
 */
- (UICollectionViewCell *)moreListCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(verticalMenuMoreListView:CollectionView:AtIndex:cellForItemAtIndexPath:)]) {
        return [self.listDelegate verticalMenuMoreListView:self CollectionView:collectionView AtIndex:self.selectedIndex cellForItemAtIndexPath:indexPath];
    }
    CGXVerticalMenuMoreListViewItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuMoreListViewItemCell class]) forIndexPath:indexPath];
    CGXVerticalMenuMoreListSectionModel *listModel = self.dataArray[indexPath.section];
    [cell reloadData:listModel.dataArray[indexPath.row] TitleHeight:listModel.itemHeight];
    return cell;
}
/**
 每个分区头自定义view
 */
- (UIView *)moreListCollectionView:(UICollectionView *)collectionView KindHeadAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(verticalMenuMoreListView:AtIndex:KindHeadAtIndexPath:)]) {
        return [self.listDelegate verticalMenuMoreListView:self AtIndex:self.selectedIndex KindHeadAtIndexPath:indexPath];
    }
    return nil;
}
/**
 每个分区脚自定义view
 */
- (UIView *)moreListCollectionView:(UICollectionView *)collectionView KindFootAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(verticalMenuMoreListView:AtIndex:KindFootAtIndexPath:)]) {
        return [self.listDelegate verticalMenuMoreListView:self AtIndex:self.selectedIndex KindFootAtIndexPath:indexPath];
    }
    return nil;
}

/**
 点击调用该方法
 */
- (void)moreListCollectionView:(UICollectionView *)collectionView didClickSelectedItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listDelegate && [self.listDelegate respondsToSelector:@selector(verticalMenuMoreListView:AtIndex:didClickSelectedItemAtIndexPath:)]) {
        [self.listDelegate verticalMenuMoreListView:self AtIndex:self.selectedIndex didClickSelectedItemAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.listModel.haveTitleView) {
        if (!(scrollView.isTracking || scrollView.isDecelerating)) {
            //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
            return;
        }
        //用户滚动的才处理
        //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
        NSArray <NSIndexPath *>*topIndexPaths = [self.mainTable indexPathsForRowsInRect:CGRectMake(0, scrollView.contentOffset.y+self.listModel.titleHeight, self.mainTable.bounds.size.width, self.listModel.titleHeight)];
        NSIndexPath *topIndexPath = topIndexPaths.firstObject;
        NSUInteger topSection = topIndexPath.row;
        if (topIndexPath != nil && topSection < self.dataArray.count) {
            if (self.selectedTitleIndex != topSection) {
                //不相同才切换
                self.selectedTitleIndex = topSection;
                [self.titleView scrollAtIndex:topSection];
            }
        }
    }
}

- (void)updateWithListModel:(CGXVerticalMenuMoreListModel *)listModel AtIndex:(NSInteger)index
{
    self.listModel = listModel;
    self.selectedIndex = index;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:listModel.dataArray];
    [self.mainTable reloadData];
    [self refreshHeaderView];
}

@end

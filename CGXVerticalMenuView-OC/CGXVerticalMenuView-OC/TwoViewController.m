//
//  TwoViewController.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "TwoViewController.h"
#import "CGXVerticalMenu.h"
#import "TitleHeaderView.h"
#import "CGXVerticalMenuCategoryView.h"

@interface TwoViewController ()<CGXVerticalMenuCategoryViewDelegate,CGXVerticalMenuCategoryViewDataSouce>


@property (nonatomic , strong) CGXVerticalMenuCategoryView *menuView;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
      self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.menuView = [[CGXVerticalMenuCategoryView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSafeVCHeight)];
    self.menuView.backgroundColor = [UIColor whiteColor];
    self.menuView.delegate = self;
     self.menuView.dataSouce = self;
    [self.view addSubview:self.menuView];
    self.menuView.titleWidth = (SCREEN_WIDTH-50)/4.0;
    
    self.menuView.leftBgColor = [UIColor colorWithRed:29.0/255.0f green:35.0/255.0f blue:69.0/255.0f alpha:1.0];;
    self.menuView.rightBgColor = [UIColor whiteColor];
    self.menuView.scrollAnimated = YES;
    
    CGXVerticalMenuIndicatorBackgroundView *backgroundView = [[CGXVerticalMenuIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewColor = [UIColor orangeColor];
    backgroundView.backgroundViewHeight = 30;
    backgroundView.backgroundViewWidth = (SCREEN_WIDTH-50)/4.0;
    CGXVerticalMenuIndicatorLineView *lineView = [[CGXVerticalMenuIndicatorLineView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    lineView.positionType = CGXVerticalMenuIndicatorLinePosition_Left;
    self.menuView.indicators = @[lineView,backgroundView];
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"推荐",@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财", nil];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (int i = 0; i<titleArr.count; i++) {
        CGXVerticalMenuCategoryListModel *listModel = [[CGXVerticalMenuCategoryListModel alloc] init];
        
        CGXVerticalMenuTitleModel *itemModel = [[CGXVerticalMenuTitleModel alloc] init];
        //            itemModel.isMoreClick = NO;
        itemModel.title = titleArr[i];
        itemModel.titleNormalColor = [UIColor whiteColor];
        itemModel.titleSelectedColor = [UIColor redColor];
        itemModel.titleFont = [UIFont systemFontOfSize:14];
        itemModel.titleSelectedFont = [UIFont systemFontOfSize:16];
        //                    [dataArr addObject:itemModel];
        listModel.leftModel = itemModel;
        
        
        NSMutableArray *dataRightArr = [NSMutableArray array];
        for (int i = 0; i<arc4random() % 2 + 3; i++) {
            CGXVerticalMenuCollectionSectionModel *sectionModel = [[CGXVerticalMenuCollectionSectionModel alloc] init];
            sectionModel.headerHeight = 30;
            sectionModel.footerHeight = 10;
            sectionModel.headerBgColor = [UIColor orangeColor];
            sectionModel.footerBgColor = [UIColor colorWithWhite:0.93 alpha:1];
            sectionModel.rowCount = arc4random() % 2 + 2;
            NSMutableArray *rowArr = [NSMutableArray array];
            for (int j = 0; j<6; j++) {
                CGXVerticalMenuCollectionItemModel *itemModel = [[CGXVerticalMenuCollectionItemModel alloc] init];
                itemModel.itemBgColor = APPRandomColor;
                [rowArr addObject:itemModel];
            }
            sectionModel.rowArray = [NSMutableArray arrayWithArray:rowArr];
            [dataRightArr addObject:sectionModel];
        }
        listModel.rightArray = dataRightArr;
        
        [dataArr addObject:listModel];
    }
    [self.menuView updateListWithDataArray:dataArr];
    
}
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView RefreshScrollView:(UIScrollView *)scrollView listViewInRow:(NSInteger)row
{
    CGXRefreshHeader *header =  [CGXRefreshHeader headerWithRefreshingBlock:^{
        NSLog(@"结束刷新....");
        [categoryView refreshLoadData];
        [scrollView.mj_header endRefreshing];
    }];
    if (row>0) {
        CGXVerticalMenuCategoryListModel *listModel = categoryView.dataArray[row-1];
        header.title = [NSString stringWithFormat:@"下拉继续浏览 %@",listModel.leftModel.title];
    }
    scrollView.mj_header = header;
    
    CGXRefreshBackFooter *footer =  [CGXRefreshBackFooter footerWithRefreshingBlock:^{
        NSLog(@"结束刷新....");
        [categoryView refreshMoreLoadData];
        [scrollView.mj_footer endRefreshing];
    }];
    if (row < categoryView.dataArray.count-1) {
        CGXVerticalMenuCategoryListModel *listModel = categoryView.dataArray[row+1];
        footer.title = [NSString stringWithFormat:@"上拉继续浏览 %@",listModel.leftModel.title];
    }
    scrollView.mj_footer = footer;

    if (row==0 || row == categoryView.dataArray.count-1) {
        scrollView.mj_header.hidden = YES;
        scrollView.mj_footer.hidden = YES;
    } else{
         scrollView.mj_header.hidden = NO;
        scrollView.mj_footer.hidden = NO;
    }
}
/** 左侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"左侧点击 %ld",(long)index);
}

/**  右侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param indexPath 选中的indexPath
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemDetailsAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"右侧点击 %ld--%ld",(long)indexPath.section,(long)indexPath.row);
}
/**
 背景图点击事件
 @param categoryView categoryView description
 @param indexPath 点击背景图的indexPath
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectDecorationViewAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"右侧背景图点击 %ld--%ld",(long)indexPath.section,(long)indexPath.row);
}
/**  将要显示
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param row 选中的row
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView willDisplayCellAtRow:(NSInteger)row
{
    NSLog(@"将要显示 %ld",(long)row);
}
/**  将要消失
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param row 选中的row
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didEndDisplayingCellAtRow:(NSInteger)row
{
    NSLog(@"将要消失 %ld",(long)row);
}

- (UICollectionViewCell *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView ListView:(CGXVerticalMenuCollectionView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath listViewInRow:(NSInteger)row;
{
    CGXVerticalMenuCollectionCell *cell = [listView.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionCell class]) forIndexPath:indexPath];
    CGXVerticalMenuCollectionSectionModel *sectionModel = listView.dataArray[indexPath.section];
    CGXVerticalMenuCollectionItemModel *itemModel = sectionModel.rowArray[indexPath.row];
    [cell reloadData:itemModel];
    return cell;
}
- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView ListView:(CGXVerticalMenuCollectionView *)listView KindHeadAtIndexPath:(NSIndexPath *)indexPath listViewInRow:(NSInteger)row
{
    TitleHeaderView *titleView = [[TitleHeaderView alloc] init];
    CGXVerticalMenuCategoryListModel *listModel = categoryView.dataArray[row];
    titleView.titleLabel.text = [NSString stringWithFormat:@"%@--%ld",listModel.leftModel.title,(long)indexPath.section];
    return titleView;
}
- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView ListView:(CGXVerticalMenuCollectionView *)listView KindFootAtIndexPath:(NSIndexPath *)indexPath listViewInRow:(NSInteger)row
{
    return [[UICollectionReusableView alloc] init];
}
/**
 每个分区背景颜色  默认背景色
 */
- (UIColor *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView BackgroundColorForSection:(NSInteger)section
{
    NSArray *colorArr = @[[UIColor redColor], [UIColor greenColor],[UIColor yellowColor],[UIColor blueColor]];
    NSInteger inter = arc4random() % 3;
    return [colorArr objectAtIndex:inter];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

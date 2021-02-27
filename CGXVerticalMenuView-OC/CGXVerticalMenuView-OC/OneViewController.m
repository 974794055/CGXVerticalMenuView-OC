//
//  OneViewController.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "OneViewController.h"


#import "CGXVerticalMenu.h"
#import "TitleHeaderView.h"

@interface OneViewController ()<CGXVerticalMenuCategoryViewDelegate,CGXVerticalMenuCategoryViewDataSouce>


@property (nonatomic , strong) CGXVerticalMenuCategoryView *menuView;

@property (nonatomic , assign) BOOL sectionClick;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.sectionClick = NO;
    
    self.menuView = [[CGXVerticalMenuCategoryView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSafeVCHeight)];
    self.menuView.backgroundColor = [UIColor whiteColor];
    self.menuView.delegate = self;
    self.menuView.dataSouce = self;
    [self.view addSubview:self.menuView];
    self.menuView.titleWidth = 100;
    self.menuView.leftBgColor = [UIColor colorWithWhite:0.93 alpha:1];;
    self.menuView.rightBgColor = [UIColor whiteColor];
    
    CGXVerticalMenuIndicatorBackgroundView *backgroundView = [[CGXVerticalMenuIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewColor = [UIColor orangeColor];
    //    backgroundView.backgroundViewHeight = 30;
    backgroundView.backgroundViewCornerRadius = 0;
    //    backgroundView.backgroundViewWidth = (SCREEN_WIDTH-50)/4.0;
    CGXVerticalMenuIndicatorLineView *lineView = [[CGXVerticalMenuIndicatorLineView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    lineView.positionType = CGXVerticalMenuIndicatorLinePosition_Left;
    self.menuView.indicators = @[lineView,backgroundView];
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"推荐",@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财", nil];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (int i = 0; i<titleArr.count; i++) {
        CGXVerticalMenuCategoryListModel *listModel = [[CGXVerticalMenuCategoryListModel alloc] init];
        CGXVerticalMenuTitleModel *itemModel = [[CGXVerticalMenuTitleModel alloc] init];
        //      itemModel.isMoreClick = NO;
        itemModel.title = titleArr[i];
        itemModel.titleNormalColor = [UIColor blackColor];
        itemModel.titleSelectedColor = [UIColor redColor];
        itemModel.titleFont = [UIFont systemFontOfSize:14];
        itemModel.titleSelectedFont = [UIFont systemFontOfSize:18];
        listModel.leftModel = itemModel;
        listModel.rightArray = [self rightDataArr];
        [dataArr addObject:listModel];
    }
    [self.menuView updateListWithDataArray:dataArr];
    
    UIBarButtonItem *item1  =[[UIBarButtonItem alloc] initWithTitle:@"白色" style:UIBarButtonItemStyleDone target:self action:@selector(sectionLeftClick:)];
    
    UIBarButtonItem *item2 =[[UIBarButtonItem alloc] initWithTitle:@"随机色" style:UIBarButtonItemStyleDone target:self action:@selector(sectionRightClick:)];
    UIBarButtonItem *item3  =[[UIBarButtonItem alloc] initWithTitle:@"背景图" style:UIBarButtonItemStyleDone target:self action:@selector(sectionThreeClick:)];
    self.navigationItem.rightBarButtonItems = @[item1,item2,item3];
}

- (NSMutableArray<CGXVerticalMenuCollectionSectionModel *> *)rightDataArr
{
    NSMutableArray *dataRightArr = [NSMutableArray array];
    for (int i = 0; i<arc4random() % 6 + 6; i++) {
        CGXVerticalMenuCollectionSectionModel *sectionModel = [[CGXVerticalMenuCollectionSectionModel alloc] init];
        sectionModel.headerHeight = 30;
        sectionModel.footerHeight = 0;
//        sectionModel.headerBgColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];;
//        sectionModel.footerBgColor = [[UIColor redColor] colorWithAlphaComponent:0.4];;
        
                sectionModel.headerBgColor = [[UIColor orangeColor] colorWithAlphaComponent:0];;
                sectionModel.footerBgColor = [[UIColor redColor] colorWithAlphaComponent:0];;
        sectionModel.rowCount = arc4random() % 2+3;
        sectionModel.borderInsets = UIEdgeInsetsMake(10, 10, 0, 10);
        sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);;
        if (i==0) {
        sectionModel.headersHovering = YES;
        }
        
        CGXVerticalMenuRoundModel *roundModel = [[CGXVerticalMenuRoundModel alloc] init];
        roundModel.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        roundModel.borderWidth = 1;
        roundModel.cornerRadius = 10;
        roundModel.backgroundColor = [UIColor redColor];
        roundModel.isCalculateHeader = YES;
        roundModel.isCalculateFooter = YES;
        roundModel.hotStr = @"";
        roundModel.backgroundColor = APPRandomColor;
        roundModel.menu_ImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotURL) {
            [hotImageView sd_setImageWithURL:hotURL];
        };
        sectionModel.roundModel = roundModel;
        
        NSMutableArray *rowArr = [NSMutableArray array];
        for (int j = 0; j<arc4random() % 2 * 3 + 9; j++) {
            CGXVerticalMenuCollectionItemModel *itemModel = [[CGXVerticalMenuCollectionItemModel alloc] init];
            itemModel.itemCornerRadius = 10;
            itemModel.itemText = @"花生油";
            itemModel.itemUrlStr = @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.ewebweb.com%2Fuploads%2F20191224%2F22%2F1577196989-uEbmQBWcyP.jpg&refer=http%3A%2F%2Fimg.ewebweb.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1616852474&t=655390d70cbf2cd161aec3c824dcdbbc";
            
            itemModel.menu_ImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                [hotImageView sd_setImageWithURL:hotImageURL];
            };
            [rowArr addObject:itemModel];
        }
        sectionModel.rowArray = [NSMutableArray arrayWithArray:rowArr];
        [dataRightArr addObject:sectionModel];
    }
    return dataRightArr;
}

- (void)sectionLeftClick:(UIBarButtonItem *)bar
{
    self.sectionClick = NO;
    for (int i = 0; i<self.menuView.dataArray.count; i++) {
        CGXVerticalMenuCategoryListModel *listModel = self.menuView.dataArray[i];
        for (int j = 0; j<listModel.rightArray.count; j++) {
            CGXVerticalMenuCollectionSectionModel *sectionM =listModel.rightArray[j];
            sectionM.roundModel.hotStr = @"";
            sectionM.roundModel.backgroundColor = [UIColor whiteColor];
            [listModel.rightArray replaceObjectAtIndex:j withObject:sectionM];
        }
        [self.menuView updateListWistAtIndex:i ItemModel:listModel];
    }
}
- (void)sectionRightClick:(UIBarButtonItem *)bar
{
    self.sectionClick = YES;
    for (int i = 0; i<self.menuView.dataArray.count; i++) {
        CGXVerticalMenuCategoryListModel *listModel = self.menuView.dataArray[i];
        for (int j = 0; j<listModel.rightArray.count; j++) {
            CGXVerticalMenuCollectionSectionModel *sectionM =listModel.rightArray[j];
            sectionM.roundModel.hotStr = @"";
            sectionM.roundModel.backgroundColor = APPRandomColor;
            [listModel.rightArray replaceObjectAtIndex:j withObject:sectionM];
        }
        [self.menuView updateListWistAtIndex:i ItemModel:listModel];
    }
}
- (void)sectionThreeClick:(UIBarButtonItem *)bar
{
    self.sectionClick = YES;
    for (int i = 0; i<self.menuView.dataArray.count; i++) {
        CGXVerticalMenuCategoryListModel *listModel = self.menuView.dataArray[i];
        for (int j = 0; j<listModel.rightArray.count; j++) {
            CGXVerticalMenuCollectionSectionModel *sectionM =listModel.rightArray [j];
            sectionM.roundModel.hotStr = @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2216726832,2803715051&fm=26&gp=0.jpg";;
            [listModel.rightArray replaceObjectAtIndex:j withObject:sectionM];
        }
        [self.menuView updateListWistAtIndex:i ItemModel:listModel];
    }
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
    if (self.sectionClick) {
        NSArray *colorArr = @[[UIColor redColor], [UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor], [UIColor blueColor],[UIColor blackColor]];
        NSInteger inter = arc4random() % 6;
        return [colorArr objectAtIndex:inter];
    }
    return categoryView.rightBgColor;
}
/**
 每个分区的高度 不实现  默认宽高相等
 */
- (CGFloat)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView sizeForItemAtSection:(NSInteger)section ItemWidth:(CGFloat)itemWidth
{
    return itemWidth+30;
}
/** 左侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"左侧点击 %ld",(long)index);
    CGXVerticalMenuCategoryListModel *listModel = categoryView.dataArray[index];
    listModel.rightArray = [self rightDataArr];
    [categoryView.dataArray replaceObjectAtIndex:index withObject:listModel];
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
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectDecorationViewAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"右侧空白点击 %ld--%ld",(long)indexPath.section,(long)indexPath.row);
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

/**  将要显示的右侧分区
 点击选中、滚动选中的情况才会调用该方法
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView willDisplaViewElementKind:(NSString *)elementKind
   atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"将要显示的右侧分区--%ld" , indexPath.section);
}

/**  将要消失的右侧分区
 点击选中、滚动选中的情况才会调用该方法
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didEndDisplayingElementKind:(NSString *)elementKind
   atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"将要消失的右侧分区--%ld" , indexPath.section);
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

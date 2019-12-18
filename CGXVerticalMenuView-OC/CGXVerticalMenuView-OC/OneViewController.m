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
    self.menuView.titleWidth = (SCREEN_WIDTH-50)/4.0;
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
//                    itemModel.isMoreClick = NO;
        itemModel.title = titleArr[i];
        itemModel.titleNormalColor = [UIColor blackColor];
        itemModel.titleSelectedColor = [UIColor redColor];
        itemModel.titleFont = [UIFont systemFontOfSize:14];
        itemModel.titleSelectedFont = [UIFont systemFontOfSize:18];
        listModel.leftModel = itemModel;
        
        
        NSMutableArray *dataRightArr = [NSMutableArray array];
        for (int i = 0; i<arc4random() % 6 + 2; i++) {
            CGXVerticalMenuCollectionSectionModel *sectionModel = [[CGXVerticalMenuCollectionSectionModel alloc] init];
            sectionModel.headerHeight = 30;
            sectionModel.footerHeight = 10;
            sectionModel.headerBgColor = [UIColor orangeColor];
            sectionModel.footerBgColor = [UIColor colorWithWhite:0.93 alpha:1];
            sectionModel.rowCount = 3;
            NSMutableArray *rowArr = [NSMutableArray array];
            for (int j = 0; j<arc4random() % 2 * 3 + 9; j++) {
                CGXVerticalMenuCollectionItemModel *itemModel = [[CGXVerticalMenuCollectionItemModel alloc] init];
                [rowArr addObject:itemModel];
            }
            sectionModel.rowArray = [NSMutableArray arrayWithArray:rowArr];
            [dataRightArr addObject:sectionModel];
        }
        listModel.rightArray = dataRightArr;
        
        [dataArr addObject:listModel];
    }
    [self.menuView updateListWithDataArray:dataArr];
    
     UIBarButtonItem *item1  =[[UIBarButtonItem alloc] initWithTitle:@"右侧背景白色" style:UIBarButtonItemStyleDone target:self action:@selector(sectionLeftClick:)];
    
     UIBarButtonItem *item2 =[[UIBarButtonItem alloc] initWithTitle:@"随机右侧背景色" style:UIBarButtonItemStyleDone target:self action:@selector(sectionRightClick:)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}
- (void)sectionLeftClick:(UIBarButtonItem *)bar
{
    self.sectionClick = NO;
    [self.menuView selectItemAtIndex:self.menuView.currentInteger];
}
- (void)sectionRightClick:(UIBarButtonItem *)bar
{
    self.sectionClick = YES;
    [self.menuView selectItemAtIndex:self.menuView.currentInteger];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

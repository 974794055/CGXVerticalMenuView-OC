//
//  ViewController.m
//  CGXCategoryListView-OC
//
//  Created by 曹贵鑫 on 2019/9/4.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import "ThreeViewController.h"

#import "CGXVerticalMenu.h"
#import "TitleHeaderView.h"

@interface ThreeViewController ()<CGXVerticalMenuCategoryViewDelegate>


@property (nonatomic , strong) CGXVerticalMenuCategoryView *menuView;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;

    
    
    self.menuView = [[CGXVerticalMenuCategoryView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSafeVCHeight)];
    self.menuView.backgroundColor = [UIColor whiteColor];
    self.menuView.delegate = self;
    [self.view addSubview:self.menuView];
    self.menuView.titleWidth = (SCREEN_WIDTH-50)/4.0;
    self.menuView.leftBgColor = [UIColor colorWithRed:29.0/255.0f green:35.0/255.0f blue:69.0/255.0f alpha:1.0];;
    self.menuView.righttBgColor = [UIColor whiteColor];
    self.menuView.isKeepScrollState  = NO;
//     self.menuView.rightView.stopTop  = YES;
    
    CGXVerticalMenuIndicatorBackgroundView *backgroundView = [[CGXVerticalMenuIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewColor = [UIColor orangeColor];
    backgroundView.backgroundViewHeight = 30;
    backgroundView.backgroundViewWidth = (SCREEN_WIDTH-50)/4.0-20;
    CGXVerticalMenuIndicatorLineView *lineView = [[CGXVerticalMenuIndicatorLineView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    lineView.positionType = CGXVerticalMenuIndicatorLinePosition_Left;
    self.menuView.leftView.indicators = @[lineView,backgroundView];
    
    
    
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
        itemModel.titleSelectedFont = [UIFont systemFontOfSize:18];
        //                    [dataArr addObject:itemModel];
        listModel.leftModel = itemModel;
        
        
        NSMutableArray *dataRightArr = [NSMutableArray array];
        for (int i = 0; i<arc4random() % 6 + 3; i++) {
            CGXVerticalMenuCollectionSectionModel *sectionModel = [[CGXVerticalMenuCollectionSectionModel alloc] init];
            sectionModel.headerHeight = 30;
            sectionModel.footerHeight = 10;
            sectionModel.headerBgColor = [UIColor orangeColor];
            sectionModel.footerBgColor = [UIColor yellowColor];
            sectionModel.rowCount = 3;
            NSMutableArray *rowArr = [NSMutableArray array];
            for (int j = 0; j<6; j++) {
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
    
    
}
- (UICollectionViewCell *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuCollectionCell *cell = [categoryView.rightView.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionCell class]) forIndexPath:indexPath];
    CGXVerticalMenuCollectionSectionModel *sectionModel = categoryView.rightView.dataArray[indexPath.section];
    CGXVerticalMenuCollectionItemModel *itemModel = sectionModel.rowArray[indexPath.row];
    [cell reloadData:itemModel];
    return cell;
}

- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath
{
    TitleHeaderView *titleView = [[TitleHeaderView alloc] init];
    CGXVerticalMenuCategoryListModel *listModel = categoryView.dataArray[categoryView.leftView.selectedIndex];
    titleView.titleLabel.text = [NSString stringWithFormat:@"%@--%ld--%ld",listModel.leftModel.title,indexPath.section,indexPath.row];
    return titleView;
}
- (UICollectionReusableView *)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView KindFootAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *titleView = [[UICollectionReusableView alloc] init];
    return titleView;
}
/** 左侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"左侧点击 %ld",index);
}

/**  右侧点击
 点击选中、滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param indexPath 选中的indexPath
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemDetailsAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"右侧点击 %ld--%ld",indexPath.section,indexPath.row);
}
@end

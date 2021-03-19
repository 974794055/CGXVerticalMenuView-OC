//
//  ThreeViewController.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/4.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "ThreeViewController.h"
#import "MoreViewCell.h"
#import "MoreSectionFootView.h"
#import "MoreSectionHeadView.h"
@interface ThreeViewController ()<CGXVerticalMenuMoreViewDelegate>
@property (nonatomic, strong) CGXVerticalMenuMoreView *moreView;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.moreView = [[CGXVerticalMenuMoreView alloc] init];
    self.moreView.delegate = self;
    self.moreView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTopHeight);;;
    [self.view addSubview:self.moreView];
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"推荐",@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财", nil];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (int i = 0; i<titleArr.count; i++) {
        CGXVerticalMenuMoreListModel *listModel = [[CGXVerticalMenuMoreListModel alloc] init];
        CGXVerticalMenuTitleModel *itemModel = [[CGXVerticalMenuTitleModel alloc] init];
        itemModel.title = titleArr[i];
        itemModel.titleNormalColor = [UIColor blackColor];
        itemModel.titleSelectedColor = [UIColor redColor];
        itemModel.titleFont = [UIFont systemFontOfSize:14];
        itemModel.titleSelectedFont = [UIFont systemFontOfSize:18];
        listModel.leftModel = itemModel;
        
//        listModel.haveTitleView = NO;
        listModel.headEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        listModel.headUrl = [NSString stringWithFormat:@"HotIcon%d",i % 5];
        listModel.menu_ImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
            [hotImageView sd_setImageWithURL:hotImageURL];
            hotImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"HotIcon%d",i % 5]];
        };
        
        CGXVerticalMenuMoreListTitleModel *titleModel = [[CGXVerticalMenuMoreListTitleModel alloc] init];
        titleModel.textNormalColor = [UIColor blackColor];
        titleModel.textSelectColor = [UIColor redColor];
        titleModel.textNormalBgColor = [UIColor colorWithWhite:0.93 alpha:1];
        titleModel.textSelectBgColor = RGBColorA(251, 234, 230, 1);
        titleModel.textNormalFont = [UIFont systemFontOfSize:14];
        titleModel.textSelectFont = [UIFont systemFontOfSize:14];
        titleModel.textNormalBorderColor = [UIColor colorWithWhite:0.93 alpha:1];
        titleModel.textSelectBorderColor = [UIColor redColor];
        titleModel.textSelectBorderWidth = 1;
        titleModel.textNormalBorderWidth = 0;
        titleModel.textNormalBorderRadius = 15;
        titleModel.textSelectBorderRadius = 15;
        titleModel.titleSpace = 10;
        listModel.titleModel = titleModel;
        listModel.titleHeight = 50;
        listModel.titleSpace= 20;
        
        NSMutableArray *dataRightArr = [NSMutableArray array];
        for (int j = 0; j<6; j++) {
            CGXVerticalMenuMoreListSectionModel *sectionModel = [[CGXVerticalMenuMoreListSectionModel alloc] init];
            sectionModel.headerHeight = 40;
            sectionModel.footerHeight = 0;
            sectionModel.headerBgColor = [APPRandomColor colorWithAlphaComponent:0.7];;
            sectionModel.footerBgColor = [[UIColor redColor] colorWithAlphaComponent:0.4];;
            sectionModel.rowCount = 1;
            sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);;
            sectionModel.borderInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            
            sectionModel.headNameModel.text = [NSString stringWithFormat:@"%@-%d",titleArr[i],j];
            
            
            sectionModel.roundModel.backgroundColor = APPRandomColor;
                sectionModel.roundModel.isCalculateHeader = NO;
                sectionModel.roundModel.isCalculateFooter = NO;
   
            
            sectionModel.roundModel.backgroundColor = [UIColor whiteColor];
            
            sectionModel.itemHeight = 30;
            sectionModel.itemSpace = 0.3;
            NSMutableArray *rowArr = [NSMutableArray array];
            for (int k = 0; k<6; k++) {
                CGXVerticalMenuMoreListSectionItemModel *itemModel = [[CGXVerticalMenuMoreListSectionItemModel alloc] init];
                itemModel.itemBgColor = [UIColor whiteColor];
                itemModel.itemCornerRadius = 10;
                itemModel.itemBorderColor = [UIColor redColor];
                itemModel.itemBborderWidth = 1;
                itemModel.itemText = [NSString stringWithFormat:@"%@-%d-%d",titleArr[i],j,k];;
                itemModel.itemUrlStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];;
                itemModel.menu_ImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                    [hotImageView sd_setImageWithURL:hotImageURL];
                    hotImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"HotIcon%d",i % 5]];
                };
                [rowArr addObject:itemModel];
            }
            sectionModel.dataArray = [NSMutableArray arrayWithArray:rowArr];
            [dataRightArr addObject:sectionModel];
        }
        listModel.dataArray = dataRightArr;
        [dataArr addObject:listModel];
    }
    [self.moreView updateListWithDataArray:dataArr];
}
/**
 自定义头部
// */
//- (UIView *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView HeadAtIndex:(NSInteger)index
//{
//        MoreSectionHeadView *view = [[MoreSectionHeadView alloc] init];
//        view.titleLabel.backgroundColor  =[UIColor redColor];
//        view.frame = CGRectMake(0, 0, moreView.frame.size.width, 200);
//        view.titleLabel.text = [NSString stringWithFormat:@"自定义头-%ld" , index];
//        return view;
//}

/**
 自定义脚部
 */
//- (UIView *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView FootAtIndex:(NSInteger)index
//{
//    if (self.selectBO) {
//        MoreSectionFootView *view = [[MoreSectionFootView alloc] init];
//        view.backgroundColor  = [UIColor orangeColor];
//        view.frame = CGRectMake(0, 0, moreView.frame.size.width, 50);
//        view.titleLabel.text = [NSString stringWithFormat:@"自定义脚-%ld" , index];
//        return view;
//    }
//    return nil;
//}
- (Class)verticalMenuMoreViewCustomCollectionViewCellClass
{
    return [MoreViewCell class];
}
///**
// 每个分区自定义cell
// */
- (UICollectionViewCell *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView CollectionView:(nonnull UICollectionView *)collectionView AtIndex:(NSInteger)index cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
        MoreViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MoreViewCell class]) forIndexPath:indexPath];
        CGXVerticalMenuMoreListModel *listModel = moreView.dataArray[index];
        CGXVerticalMenuMoreListSectionModel *sectionModel = listModel.dataArray[indexPath.section];
        CGXVerticalMenuMoreListSectionItemModel *itemModel = sectionModel.dataArray[indexPath.row];
        [cell reloadData:itemModel];
        return cell;
}
/**
 每个分区头自定义view
 */
//- (UIView *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView AtIndex:(NSInteger)index KindHeadAtIndexPath:(NSIndexPath *)indexPath
//{
//        return [[UIView alloc] init];
//    return nil;
//}
///**
// 每个分区脚自定义view
// */
//- (UIView *)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView AtIndex:(NSInteger)index KindFootAtIndexPath:(NSIndexPath *)indexPath
//{
//        return [[UIView alloc] init];
//    return nil;
//}

/** 左侧点击
 @param moreView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didSelectedItemAtIndex--:%ld",index);
}

/**  右侧点击
 @param moreView categoryView description
 @param indexPath 选中的indexPath
 */
- (void)verticalMenuMoreView:(CGXVerticalMenuMoreView *)moreView AtIndex:(NSInteger)index didSelectedItemDetailsAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectedItemAtIndex--:%ld--%@",index,indexPath);
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

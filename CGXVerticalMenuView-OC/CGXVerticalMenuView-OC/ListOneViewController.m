//
//  ListOneViewController.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/4.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "ListOneViewController.h"

@interface ListOneViewController ()<CGXVerticalMenuCollectionViewDelegate,CGXVerticalMenuCollectionViewDataSouce>

@property (nonatomic , strong) CGXVerticalMenuCollectionView *listScrollView;
@end

@implementation ListOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listScrollView = [[CGXVerticalMenuCollectionView alloc] init];
    [self.view addSubview:self.listScrollView];
    self.listScrollView.delegate = self;
    self.listScrollView.dataSouce = self;
    self.listScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame)-100, SCREEN_HEIGHT-kTopHeight-kSafeHeight);
  
    NSMutableArray *dataRightArr = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
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
    [self.listScrollView updateRightWithDataArray:dataRightArr];
}
/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView
{
    return self.view;
}
/**
// 可选实现，列表显示的时候调用
// */
//- (void)listDidAppearAtIndex:(NSInteger)index
//{
//    NSLog(@"listDidAppearAtIndex--%ld",index);
//}
//
///**
// 可选实现，列表消失的时候调用
// */
//- (void)listDidDisappearAtIndex:(NSInteger)index
//{
//    NSLog(@"listDidDisappearAtIndex--%ld",index);
//}
///**
// 可选实现，列表将要显示的时候调用
// */
//- (void)listWillAppearAtIndex:(NSInteger)index
//{
//    NSLog(@"listWillAppearAtIndex--%ld",index);
//}
//
//
//
///**
// 可选实现，列表将要消失的时候调用
// */
//- (void)listWillDisappearAtIndex:(NSInteger)index
//{
//    NSLog(@"listWillDisappearAtIndex--%ld",index);
//}

- (void)listWillDidAppearAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(listWillDidAppearAtIndex:)]) {
        [self.delegate listWillDidAppearAtIndex:index];
    }
}
- (UICollectionViewCell *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuCollectionCell *cell = [categoryView.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuCollectionCell class]) forIndexPath:indexPath];
    CGXVerticalMenuCollectionSectionModel *sectionModel = categoryView.dataArray[indexPath.section];
    CGXVerticalMenuCollectionItemModel *itemModel = sectionModel.rowArray[indexPath.row];
    [cell reloadData:itemModel];
    return cell;
}
/**
 每个分区背景颜色  默认背景色
 */
- (UIColor *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView BackgroundColorForSection:(NSInteger)section
{
    CGXVerticalMenuCollectionSectionModel *sectionModel = categoryView.dataArray[section];
    return sectionModel.sectionColor;
}
- (CGFloat)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView sizeForItemAtSection:(NSInteger)section ItemWidth:(CGFloat)itemWidth
{
    return itemWidth+30;
}
- (UICollectionReusableView *)categoryRightView:(CGXVerticalMenuCollectionView *)categoryView KindHeadAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UICollectionReusableView alloc] init];
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


//
//  TitleViewController.m
//  CGXVerticalMenuView-OC
//
//  Created by 曹贵鑫 on 2019/9/14.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "TitleViewController.h"
#import "CGXVerticalMenuTitleView.h"
#import "CGXVerticalMenuIndicatorLineView.h"
#import "CGXVerticalMenuIndicatorBackgroundView.h"

@interface TitleViewController ()<CGXVerticalMenuTitleViewDelegate>

@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStyleDone target:self action:@selector(topText)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStyleDone target:self action:@selector(bottomText)];
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:
                           [NSNumber numberWithInteger:CGXVerticalMenuIndicatorLinePosition_Left],
                           [NSNumber numberWithInteger:CGXVerticalMenuIndicatorLinePosition_Right],
                           [NSNumber numberWithInteger:CGXVerticalMenuIndicatorLinePosition_Top],
                           [NSNumber numberWithInteger:CGXVerticalMenuIndicatorLinePosition_Bottom],
                           nil];
    for (int i = 0; i<arr.count; i++) {
        CGXVerticalMenuTitleView *listView = [[CGXVerticalMenuTitleView alloc] initWithFrame:CGRectMake(((SCREEN_WIDTH-50)/4.0+10)*i, 0, (SCREEN_WIDTH-50)/4.0, kVCHeight)];
        listView.delegate = self;
        listView.backgroundColor = [UIColor colorWithRed:29.0/255.0f green:35.0/255.0f blue:69.0/255.0f alpha:1.0];
        [self.view addSubview:listView];
        listView.tag =  10000+i;
        CGXVerticalMenuIndicatorBackgroundView *backgroundView = [[CGXVerticalMenuIndicatorBackgroundView alloc] init];
        backgroundView.backgroundViewColor = [UIColor orangeColor];
        if (i==0) {
            backgroundView.backgroundViewHeight = 30;
            backgroundView.backgroundViewWidth = (SCREEN_WIDTH-50)/4.0-20;
        } else if (i==1){
            backgroundView.backgroundViewHeight = 30;
            backgroundView.backgroundViewCornerRadius = 0;
            backgroundView.backgroundViewWidth = (SCREEN_WIDTH-50)/4.0-20;
        }else if (i==2){
            backgroundView.backgroundViewCornerRadius = 25;
            backgroundView.backgroundViewWidth = (SCREEN_WIDTH-50)/4.0-20;
        }else if (i==3){
            backgroundView.backgroundViewCornerRadius = 0;
        }
        CGXVerticalMenuIndicatorLineView *lineView = [[CGXVerticalMenuIndicatorLineView alloc] init];
        lineView.backgroundColor = [UIColor redColor];
        
        lineView.positionType = [arr[i] integerValue];
        
        listView.indicators = @[lineView,backgroundView];
        
        NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"推荐",@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财", nil];
        NSMutableArray *dataArr = [NSMutableArray array];
        for (int i = 0; i<titleArr.count; i++) {
            CGXVerticalMenuTitleModel *itemModel = [[CGXVerticalMenuTitleModel alloc] init];
            //            itemModel.isMoreClick = NO;
            itemModel.title = titleArr[i];
            itemModel.titleNormalColor = [UIColor whiteColor];
            itemModel.titleSelectedColor = [UIColor redColor];
            itemModel.titleFont = [UIFont systemFontOfSize:14];
            itemModel.titleSelectedFont = [UIFont systemFontOfSize:18];
            [dataArr addObject:itemModel];
        }
        [listView updateMenuWithDataArray:dataArr];
    }
    
}

- (void)topText
{
    CGXVerticalMenuTitleView *listView1 = [self.view viewWithTag:10000];
    CGXVerticalMenuTitleView *listView2 = [self.view viewWithTag:10001];
    CGXVerticalMenuTitleView *listView3 = [self.view viewWithTag:10002];
    CGXVerticalMenuTitleView *listView4 = [self.view viewWithTag:10003];
    [listView1 scrollerItemAtIndex:listView1.selectedIndex-1];
    [listView2 scrollerItemAtIndex:listView2.selectedIndex-1];
    [listView3 scrollerItemAtIndex:listView3.selectedIndex-1];
    [listView4 scrollerItemAtIndex:listView4.selectedIndex-1];
}
- (void)bottomText
{
    CGXVerticalMenuTitleView *listView1 = [self.view viewWithTag:10000];
    CGXVerticalMenuTitleView *listView2 = [self.view viewWithTag:10001];
    CGXVerticalMenuTitleView *listView3 = [self.view viewWithTag:10002];
    CGXVerticalMenuTitleView *listView4 = [self.view viewWithTag:10003];
    [listView1 scrollerItemAtIndex:listView1.selectedIndex+1];
    [listView2 scrollerItemAtIndex:listView2.selectedIndex+1];
    [listView3 scrollerItemAtIndex:listView3.selectedIndex+1];
    [listView4 scrollerItemAtIndex:listView4.selectedIndex+1];
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"点击选中 %@--%ld",categoryView,index);
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didScrollerSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"滚动选中 %@--%ld",categoryView,index);
}
- (void)verticalMenuTitleView:(CGXVerticalMenuTitleView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"点击或者滚动选中 %@--%ld",categoryView,index);
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

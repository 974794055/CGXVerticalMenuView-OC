//
//  ViewController.m
//  CGXCategoryListView-OC
//
//  Created by 曹贵鑫 on 2019/9/4.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) UITableView *tableView;


@property (nonatomic , strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.dataArray =  [NSMutableArray array];
    
    //    self.listView = [[CGXCategoryListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kVCHeight)];
    //    self.listView.leftView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    //    self.listView.delegate = self;
    //    [self.view addSubview:self.listView];
    //
    //    [self loadType1];
    
    [self creatTableView];
    
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"不联动，点击左侧切换右侧",
                      @"联动，一个分区联动",
                      @"联动，上下拉更新",
                      @"联动，垂直分页",
                      @"联动，水平分页",
                      nil];
    
    [self.tableView reloadData];
}
- (void)creatTableView
{
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kVCHeight) style:UITableViewStyleGrouped];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    //    [myTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.estimatedRowHeight = 0;
    myTableView.backgroundColor = [UIColor whiteColor];
    myTableView.estimatedSectionFooterHeight  = 0;
    myTableView.estimatedSectionHeaderHeight = 0;
    [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    if (@available(iOS 11.0, *)) {
        myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:myTableView];
    self.tableView =myTableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    }
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    }
    footerView.contentView.backgroundColor = [UIColor whiteColor];;
    
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    NSString *title = self.dataArray[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        OneViewController *vc = [[OneViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        TwoViewController *vc = [[TwoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
        ThreeViewController *vc = [[ThreeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3){
        ThreeViewController *vc = [[ThreeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4){
        ThreeViewController *vc = [[ThreeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

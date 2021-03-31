# CGXVerticalMenuView-OC

## 仿京东、淘宝等主流APP商品分类菜单

- 下载链接：https://github.com/974794055/CGXVerticalMenuView-OC.git
-  pod名称 ：CGXVerticalMenuView-OC
- 最新版本号： 1.2.2

## 支持效果：
- 1、左侧自定义标签view
- 2、右侧多分区滑动
- 3、右侧每个分区定义不同背景色
- 4、左右联动，右侧下拉上滑翻页

## 效果预览
### 效果预览图
说明 | Gif |
----|------|
不联动  |  <img src="https://github.com/974794055/CGXVerticalMenuView-OC/blob/master/CGXVerticalMenuViewOCGif/menuImage1.gif" width="287" height="600"> |
联动  |  <img src="https://github.com/974794055/CGXVerticalMenuView-OC/blob/master/CGXVerticalMenuViewOCGif/menuImage2.gif" width="287" height="600"> |
UICollectionView单行联动  |  <img src="https://github.com/974794055/CGXVerticalMenuView-OC/blob/master/CGXVerticalMenuViewOCGif/menuImage3.gif" width="287" height="600"> |
UICollectionView多行联动  |  <img src="https://github.com/974794055/CGXVerticalMenuView-OC/blob/master/CGXVerticalMenuViewOCGif/menuImage4.gif" width="287" height="600"> |

### 目的：
- 参考学习如何自定义
- 快速实现自己的需求

## 要求
- iOS 8.0+
- Xcode 9+
- Objective-C

## 安装
### 手动
Clone代码，把CGXVerticalMenuView文件夹拖入项目，#import "CGXVerticalMenu.h"，就可以使用了；
### CocoaPods
```ruby
target '<Your Target Name>' do
    pod 'CGXVerticalMenuView-OC'
end
```
先执行`pod repo update`，再执行`pod install`

## 结构图
<img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main0..png" width="933" height="482">

## 使用

### CGXVerticalMenuView-OC普通布局使用示例

1.初始化CGXPageCollectionGeneralView
```Objective-C
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
```
2.加载CGXPageCollectionGeneralView数据源
```Objective-C
NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"推荐",@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财", nil];
NSMutableArray *dataArr = [NSMutableArray array];
for (int i = 0; i<titleArr.count; i++) {
    CGXVerticalMenuCategoryListModel *listModel = [[CGXVerticalMenuCategoryListModel alloc] init];
    CGXVerticalMenuTitleModel *itemModel = [[CGXVerticalMenuTitleModel alloc] init];
    itemModel.title = titleArr[i];
    itemModel.titleNormalColor = [UIColor blackColor];
    itemModel.titleSelectedColor = [UIColor redColor];
    itemModel.titleFont = [UIFont systemFontOfSize:14];
    itemModel.titleSelectedFont = [UIFont systemFontOfSize:18];
    listModel.leftModel = itemModel;
    
    NSMutableArray *dataRightArr = [NSMutableArray array];
    for (int j = 0; j<arc4random() % 6 + 6; j++) {
        CGXVerticalMenuCollectionSectionModel *sectionModel = [[CGXVerticalMenuCollectionSectionModel alloc] init];
        sectionModel.headerHeight = 30;
        sectionModel.footerHeight = 0;
        sectionModel.headerBgColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];;
        sectionModel.footerBgColor = [[UIColor redColor] colorWithAlphaComponent:0.4];;
        sectionModel.rowCount = arc4random() % 2+3;
        sectionModel.borderInsets = UIEdgeInsetsMake(10, 10, 0, 10);
        sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);;

        sectionModel.headNameModel.text = [NSString stringWithFormat:@"%@-%d",titleArr[i],j];
        
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
        for (int k = 0; k<arc4random() % 2 * 3 + 9; k++) {
            CGXVerticalMenuCollectionItemModel *itemModel = [[CGXVerticalMenuCollectionItemModel alloc] init];
            itemModel.itemCornerRadius = 10;
            itemModel.itemText = [NSString stringWithFormat:@"%@-%d-%d",titleArr[i],j,k];;
            itemModel.itemUrlStr = @"HotIcon0";
            itemModel.menu_ImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotImageURL) {
                [hotImageView sd_setImageWithURL:hotImageURL];
                hotImageView.image = [UIImage imageNamed:@"HotIcon0"];
            };
            [rowArr addObject:itemModel];
        }
        sectionModel.rowArray = [NSMutableArray arrayWithArray:rowArr];
        [dataRightArr addObject:sectionModel];
    }
    
    listModel.rightArray = dataRightArr;
    [dataArr addObject:listModel];
}
[self.menuView updateListWithDataArray:dataArr];
```
3.可选实现`CGXPageCollectionUpdateViewDelegate`代理
```Objective-C
/**
 每个分区的高度 不实现  默认宽高相等
 */
- (CGFloat)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView sizeForItemAtSection:(NSInteger)section ItemWidth:(CGFloat)itemWidth
{
    return itemWidth+30;
}
/** 左侧点击
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"左侧点击 %ld",(long)index);
}

/**  右侧点击
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
 @param categoryView categoryView description
 @param row 选中的row
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView willDisplayCellAtRow:(NSInteger)row
{
    NSLog(@"将要显示 %ld",(long)row);
}
/**  将要消失
 @param categoryView categoryView description
 @param row 选中的row
 */
- (void)verticalMenuView:(CGXVerticalMenuCategoryView *)categoryView didEndDisplayingCellAtRow:(NSInteger)row
{
    NSLog(@"将要消失 %ld",(long)row);
}
```
## 更新记录
## 补充

如果刚开始使用`CGXVerticalMenuView-OC`，当开发过程中需要支持某种特性时，请务必先搜索使用文档或者源代码。确认是否已经实现支持了想要的特性。请别不要文档和源代码都没有看，就直接提问，这对于大家都是一种时间浪费。如果没有支持想要的特性，欢迎提Issue讨论，或者自己实现提一个PullRequest。

该仓库保持随时更新，对于主流新的列表效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮    箱：974794055@qq.com </br>
群名称：潮流App-iOS交流</br>
QQ  群：227219165</br>
QQ  号：974794055</br>

<img src="https://github.com/974794055/CGXVerticalMenuView-OC/blob/master/CGXVerticalMenuViewOCGif/authorGroup.png" width="300" height="411">

喜欢就star❤️一下吧

## License

CGXVerticalMenuView-OC is released under the MIT license.







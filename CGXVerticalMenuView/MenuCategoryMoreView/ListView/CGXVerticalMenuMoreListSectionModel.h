//
//  CGXVerticalMenuMoreListSectionModel.h
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2021/3/15.
//  Copyright © 2021 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGXVerticalMenuMoreListSectionItemModel.h"
#import "CGXVerticalMenuRoundModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuMoreListSectionModel : NSObject

@property (nonatomic, assign) CGFloat  itemSpace;//图片宽高比例 默认等宽等高
@property (nonatomic, assign) CGFloat  itemHeight;//文字高度 默认 0 有文字时必传

@property (nonatomic, assign) NSInteger  rowCount;//每行几个
@property (nonatomic , assign) NSInteger minimumLineSpacing;//默认是10
@property (nonatomic , assign) NSInteger minimumInteritemSpacing;//默认是10
@property (nonatomic) UIEdgeInsets insets;//默认是UIEdgeInsetsMake(10, 10, 10, 10);

@property (nonatomic , strong) id footerData;
@property (nonatomic , assign) CGFloat footerHeight;
@property (nonatomic , strong) UIColor *footerBgColor;

@property (nonatomic , strong) id headerData;
@property (nonatomic , assign) CGFloat headerHeight;
@property (nonatomic , strong) UIColor *headerBgColor;

// 头标题文字
@property (nonatomic, strong) NSString *headerText;
/** 头标题颜色  [UIColor blackColor]; */
@property (nonatomic, strong) UIColor *headerTextColor;
/** 头标题字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *headerTextFont;
@property (nonatomic, assign) NSTextAlignment headertextAlignment;
@property (nonatomic, assign) UIEdgeInsets headTextEdgeInsets;
// 每个分区颜色 默认无色
@property (nonatomic , strong) UIColor *sectionColor;

// 每个分区颜色 默认无色
@property (nonatomic , strong) CGXVerticalMenuRoundModel *roundModel;

@property (nonatomic) UIEdgeInsets borderInsets;//默认是UIEdgeInsetsMake(0, 0, 0, 0); 

@property (nonatomic, strong) NSMutableArray<CGXVerticalMenuMoreListSectionItemModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END

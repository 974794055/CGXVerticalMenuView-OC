//
//  CGXVerticalMenuMoreListModel.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGXVerticalMenuMoreListSectionModel.h"
#import "CGXVerticalMenuTitleModel.h"
#import "CGXVerticalMenuMoreListTitleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuMoreListModel : NSObject

// 左侧数据源
@property (nonatomic , strong) CGXVerticalMenuTitleModel *leftModel;

// 右侧自定义头部数据
@property (nonatomic , strong) NSObject *headModel;
@property (nonatomic , assign) UIEdgeInsets headEdgeInsets;
@property (nonatomic , strong) UIColor *headColor;
@property (nonatomic , assign) CGFloat headCornerRadius;
@property (nonatomic , assign) CGFloat headBorderWidth;
@property (nonatomic , strong) UIColor *headBorderColor;
// 默认头部图片
@property (nonatomic , strong) NSString *headUrl;
// 头部图片加载
@property (nonatomic, copy) void(^menu_ImageCallback)(UIImageView *hotImageView, NSURL *hotImageURL);
/** 滚到标题  */
@property (nonatomic, strong) CGXVerticalMenuMoreListTitleModel *titleModel;
// 标题文字高度
@property (nonatomic , assign) CGFloat titleHeight;
// 标题文字上下间距
@property (nonatomic , assign) CGFloat titleSpace;
// 是否有标题菜单 默认有
@property (nonatomic , assign) BOOL haveTitleView;

@property (nonatomic, strong) NSMutableArray<CGXVerticalMenuMoreListSectionModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END

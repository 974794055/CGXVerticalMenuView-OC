//
//  CGXVerticalMenuCollectionItemModel.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCollectionItemModel : NSObject

@property (nonatomic , strong) id dataModel;
@property (nonatomic , assign) CGFloat itemCornerRadius;
@property (nonatomic , assign) CGFloat itemBborderWidth;
@property (nonatomic , strong) UIColor *itemBorderColor;
@property (nonatomic , strong) UIColor *itemBgColor;

// 图片对应的文字显示
@property (nonatomic, strong) NSString *itemText;
/** 轮播文字label颜色  [UIColor blackColor]; */
@property (nonatomic, strong) UIColor *itemColor;
/** 轮播文字label字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *itemFont;
// 文字高度 默认 30
@property (nonatomic , assign) CGFloat itemHeight;
/*  默认一行。为1*/
@property (nonatomic, assign) NSInteger numberOfLines;
// 图文间距 默认 0
@property (nonatomic , assign) CGFloat itemSpace;


@property (nonatomic , strong) NSString *itemUrlStr; 
/** 图片加载 */
@property (nonatomic, copy) void(^menu_ImageCallback)(UIImageView *hotImageView, NSURL *hotImageURL);

@end

NS_ASSUME_NONNULL_END

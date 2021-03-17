//
//  CGXVerticalMenuRoundModel.h
//  CGXVerticalMenuRoundFlowLayout
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuRoundModel : NSObject

/// 外圈line边显示宽度
@property (assign, nonatomic) CGFloat borderWidth;
/// 外圈line边显示颜色
@property (strong, nonatomic) UIColor *borderColor;
/// 投影相关参数
@property (strong, nonatomic) UIColor *shadowColor;
@property (assign, nonatomic) CGSize shadowOffset;
@property (assign, nonatomic) CGFloat shadowOpacity;
@property (assign, nonatomic) CGFloat shadowRadius;
/// 圆角
@property (assign, nonatomic) CGFloat cornerRadius;
/// 是否计算header（若实现collectionView: layout: isCalculateHeaderViewIndex:）该字段不起作用
@property (assign, nonatomic) BOOL isCalculateHeader;
/// 是否计算footer（若实现collectionView: layout: isCalculateFooterViewIndex:）该字段不起作用
@property (assign, nonatomic) BOOL isCalculateFooter;
/// 背景颜色
@property (strong, nonatomic) UIColor *backgroundColor;

/* UIImage名称、网络连接  */
@property (strong, nonatomic) NSString *hotStr;// 背景图片名称
/** 图片加载 */
@property (nonatomic, copy) void(^menu_ImageCallback)(UIImageView *hotImageView,NSURL *hotURL);


@end

NS_ASSUME_NONNULL_END

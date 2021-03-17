//
//  CGXVerticalMenuMoreListTitleModel.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuMoreListTitleModel : NSObject

/** 文字label颜色  [UIColor blackColor]; */
@property (nonatomic, strong) UIColor *textNormalColor;
@property (nonatomic, strong) UIColor *textSelectColor;
/** 文字背景颜 默认无 [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *textNormalBgColor;
/** 文字背景颜 默认无 [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *textSelectBgColor;
/** 文字字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *textNormalFont;
@property (nonatomic, strong) UIFont  *textSelectFont;
/** 下标对应文字背景颜  [UIColor redColor]; */
@property (nonatomic, strong) UIColor *textNormalBorderColor;
@property (nonatomic, strong) UIColor *textSelectBorderColor;

@property (nonatomic, assign) CGFloat textSelectBorderWidth;
@property (nonatomic, assign) CGFloat textNormalBorderWidth;
@property (nonatomic, assign) CGFloat textNormalBorderRadius;
@property (nonatomic, assign) CGFloat textSelectBorderRadius;

// 文字两边间距
@property (nonatomic , assign) CGFloat titleSpace;


@end

NS_ASSUME_NONNULL_END

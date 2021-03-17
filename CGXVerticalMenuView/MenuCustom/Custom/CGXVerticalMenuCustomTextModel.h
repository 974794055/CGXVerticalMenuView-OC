//
//  CGXVerticalMenuCustomTextModel.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCustomTextModel : NSObject

/** 文字显示*/
@property (nonatomic, strong) NSString *text;
/** 文字label颜色  [UIColor blackColor]; */
@property (nonatomic, strong) UIColor *textColor;
/** 文字背景颜 默认无 [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *bgColor;
/** 文字背景颜 默认无 [UIColor whiteColor]; */
@property (nonatomic, strong) UIColor *bgSelectColor;
/** 文字字体大小  [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont  *textFont;
/** 文字上间距  默认 0 */
@property (nonatomic, assign) CGFloat spaceTop;
/** 文字下间距  默认 0 */
@property (nonatomic, assign) CGFloat spaceBottom;
/** 文字左间距  默认0 */
@property (nonatomic, assign) CGFloat spaceLeft;
/** 文字右间距  默认0 */
@property (nonatomic, assign) CGFloat spaceRight;
/* 默认剧中*/
@property (nonatomic, assign) NSTextAlignment textAlignment;
/*  默认一行。为1*/
@property (nonatomic, assign) NSInteger numberOfLines;
/** --cell边框--- */
/** 下标对应文字背景颜  [UIColor redColor]; */
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat borderRadius;

@end

NS_ASSUME_NONNULL_END

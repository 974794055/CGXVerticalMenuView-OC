//
//  CGXVerticalMenuIndicatorBackgroundView.h
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuIndicatorComponentView.h"

@interface CGXVerticalMenuIndicatorBackgroundView : CGXVerticalMenuIndicatorComponentView

//背景指示器的宽度。默认CGXCategoryViewAutomaticDimension（与cellWidth相等）
@property (nonatomic, assign) CGFloat backgroundViewWidth;
//背景指示器的高度。默认CGXCategoryViewAutomaticDimension（与cell高度相等）
@property (nonatomic, assign) CGFloat backgroundViewHeight;

//背景指示器的圆角值。默认CGXCategoryViewAutomaticDimension(即backgroundViewHeight/2)
@property (nonatomic, assign) CGFloat backgroundViewCornerRadius;
//背景指示器的颜色。默认为[UIColor redColor]
@property (nonatomic, strong) UIColor *backgroundViewColor;


@end

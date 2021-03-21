//
//  CGXVerticalMenuCustomTableView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCustomTableView.h"

@implementation CGXVerticalMenuCustomTableView

- (void)layoutSubviews {
    [super layoutSubviews];

}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.gestureDelegate respondsToSelector:@selector(pageTableView:gestureRecognizerShouldBegin:)]) {
        return [self.gestureDelegate pageTableView:self gestureRecognizerShouldBegin:gestureRecognizer];
    }
    
    return YES;
}

// 允许多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.gestureDelegate respondsToSelector:@selector(pageTableView:gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [self.gestureDelegate pageTableView:self gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];;
    }
    return [gestureRecognizer.view isKindOfClass:[UIScrollView class]] && [otherGestureRecognizer.view isKindOfClass:[UIScrollView class]];
}
@end

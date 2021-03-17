//
//  CGXVerticalMenuCustomCollectionView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/10.
//

#import "CGXVerticalMenuCustomCollectionView.h"

@implementation CGXVerticalMenuCustomCollectionView
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.gestureDelegate respondsToSelector:@selector(gx_pageHomeCollectionView:gestureRecognizerShouldBegin:)]) {
        return [self.gestureDelegate gx_pageHomeCollectionView:self gestureRecognizerShouldBegin:gestureRecognizer];
    }else {
        if (self.isNestEnabled) {
            if ([gestureRecognizer isMemberOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")]) {
                CGFloat velocityX = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:gestureRecognizer.view].x;
                // x大于0就是右滑
                if (velocityX > 0) {
                    if (self.contentOffset.x == 0) {
                        return NO;
                    }
                }else if (velocityX < 0) { // x小于0是往左滑
                    if (self.contentOffset.x + self.bounds.size.width == self.contentSize.width) {
                        return NO;
                    }
                }
            }
        }
    }
    
    if ([self panBack:gestureRecognizer]) return NO;
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.gestureDelegate respondsToSelector:@selector(gx_pageHomeCollectionView:gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [self.gestureDelegate gx_pageHomeCollectionView:self gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    
    if ([self panBack:gestureRecognizer]) return YES;
    
    return NO;
}

- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panGestureRecognizer) {
        CGPoint point = [self.panGestureRecognizer translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        
        // 设置手势滑动的位置距屏幕左边的区域
        CGFloat locationDistance = [UIScreen mainScreen].bounds.size.width;
        
        if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStatePossible) {
            CGPoint location = [gestureRecognizer locationInView:self];
            if (point.x > 0 && location.x < locationDistance && self.contentOffset.x <= 0) {
                return YES;
            }
        }
    }
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

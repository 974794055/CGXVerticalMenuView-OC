//
//  CGXVerticalMenuCustomBaseView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/9.
//

#import "CGXVerticalMenuCustomBaseView.h"

@implementation CGXVerticalMenuCustomBaseView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)next;
            if (@available(iOS 11.0, *)) {
                vc.automaticallyAdjustsScrollViewInsets = NO;
            }
            break;
        }
        next = next.nextResponder;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

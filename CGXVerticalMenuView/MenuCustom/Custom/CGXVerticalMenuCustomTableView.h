//
//  CGXVerticalMenuCustomTableView.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CGXVerticalMenuCustomTableView;

@protocol CGXVerticalMenuCustomTableViewDelegate <NSObject>

@optional

- (BOOL)pageTableView:(CGXVerticalMenuCustomTableView *)tableView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;

- (BOOL)pageTableView:(CGXVerticalMenuCustomTableView *)tableView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end
@interface CGXVerticalMenuCustomTableView : UITableView<UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<CGXVerticalMenuCustomTableViewDelegate> gestureDelegate;

@end

NS_ASSUME_NONNULL_END

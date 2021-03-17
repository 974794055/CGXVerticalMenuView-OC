//
//  ListOneViewController.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/4.
//  Copyright © 2021 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ListOneViewControllerDelegate <NSObject>


/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppear;

/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappear;

- (void)listWillDidAppearAtIndex:(NSInteger)index;;

@end
@interface ListOneViewController : UIViewController<CGXVerticalMenuListContainerViewDelegate>
@property (nonatomic, weak) id<ListOneViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

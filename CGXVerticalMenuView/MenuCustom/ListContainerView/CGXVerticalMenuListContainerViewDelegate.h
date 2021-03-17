//
//  CGXVerticalMenuListContainerViewDelegate.h
//  App
//
//  Created by MacMini-1 on 2021/3/8.
//  Copyright © 2021 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CGXVerticalMenuListContainerViewDelegate <NSObject>

/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView;

@optional

/**
 可选实现，列表将要显示的时候调用
 */
- (void)listWillAppearAtIndex:(NSInteger)index;

/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppearAtIndex:(NSInteger)index;

/**
 可选实现，列表将要消失的时候调用
 */
- (void)listWillDisappearAtIndex:(NSInteger)index;

/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappearAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

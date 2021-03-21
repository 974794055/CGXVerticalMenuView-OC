//
//  CGXVerticalMenuListContainerViewController.h
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuListContainerViewController : UIViewController

@property (copy) void(^ __nullable viewWillAppearBlock)(void);
@property (copy) void(^__nullable viewDidAppearBlock)(void);
@property (copy) void(^__nullable viewWillDisappearBlock)(void);
@property (copy) void(^__nullable viewDidDisappearBlock)(void);

@end

NS_ASSUME_NONNULL_END

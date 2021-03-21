//
//  CustomTitleView.h
//  CGXHotBrandView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTitleView : UIView

@property (nonatomic, assign,readonly) NSInteger selectedIndex;
/** 加载图片 */
@property (nonatomic, copy) void(^titieSelectBlock)(NSInteger integer);

- (void)updateDataTitieArray:(NSMutableArray<NSString *> *)titleArray;

- (void)selectItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

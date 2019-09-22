//
//  CGXVerticalMenuCollectionItemModel.h
//  CGXCategoryListView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCollectionItemModel : NSObject


// cell高
@property (nonatomic, assign) CGFloat  rowHeight;

// UICollectionViewCell类
@property (nonatomic , strong) Class cellClass;
/*
 //类型 UICollectionViewCell 类
 */
@property (nonatomic , strong,readonly) NSString *cellIdentifier;


@property (nonatomic , strong) id dataModel;

@property (nonatomic , assign) CGFloat cornerRadius;
@property (nonatomic , assign) CGFloat borderWidth;
@property (nonatomic , strong) UIColor *borderColor;

@property (nonatomic , strong) UIColor *bgColor;
@end

NS_ASSUME_NONNULL_END

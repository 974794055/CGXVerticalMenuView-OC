//
//  CGXVerticalMenuCollectionSectionModel.h
//  CGXCategoryListView-OC
//
//  Created by MacMini-1 on 2019/9/5.
//  Copyright © 2019 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGXVerticalMenuCollectionItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXVerticalMenuCollectionSectionModel : NSObject
@property (nonatomic, strong) NSMutableArray <CGXVerticalMenuCollectionItemModel *> *rowArray;

// 每个分区个数
@property (nonatomic, assign) NSInteger  rowCount;

@property (nonatomic , assign) NSInteger minimumLineSpacing;//默认是10
@property (nonatomic , assign) NSInteger minimumInteritemSpacing;//默认是10
@property (nonatomic) UIEdgeInsets insets;//默认是UIEdgeInsetsMake(10, 10, 10, 10);

@property (nonatomic , assign) CGFloat footerHeight;
@property (nonatomic , strong) UIColor *footerBgColor;

@property (nonatomic , assign) CGFloat headerHeight;
@property (nonatomic , strong) UIColor *headerBgColor;


@property (nonatomic , strong) id headerData;
@property (nonatomic , strong) id footerData;
@end

NS_ASSUME_NONNULL_END

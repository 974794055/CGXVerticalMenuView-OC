//
//  CGXVerticalMenuTitleCell.m
//  CGXCategoryListView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuTitleCell.h"

@interface CGXVerticalMenuTitleCell()

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) CGXVerticalMenuTitleModel *model;

@end

@implementation CGXVerticalMenuTitleCell
- (void)initializeViews
{
    [super initializeViews];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame))];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView sendSubviewToBack:self.titleLabel];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
}
- (void)reloadData:(CGXVerticalMenuTitleModel *)model IsSelect:(BOOL)isSelect
{
    self.model = model;
    self.titleLabel.text = model.title;
    if (isSelect) {
        self.titleLabel.textColor = model.titleSelectedColor;
        self.titleLabel.font = model.titleSelectedFont;
    } else{
        self.titleLabel.textColor = model.titleNormalColor;
        self.titleLabel.font = model.titleFont;
    }
}

@end

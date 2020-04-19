//
//  CGXVerticalMenuTitleCell.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuTitleCell.h"

@interface CGXVerticalMenuTitleCell()

@property (nonatomic , strong) UILabel *titleLabel;



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
- (void)reloadData:(CGXVerticalMenuBaseModel *)model
{
    [super reloadData:model];
    CGXVerticalMenuTitleModel *cellModel = (CGXVerticalMenuTitleModel *)model;
    self.titleLabel.text = cellModel.title;
    if (cellModel.isSelected) {
        self.titleLabel.textColor = cellModel.titleSelectedColor;
        self.titleLabel.font = cellModel.titleSelectedFont;
    } else{
        self.titleLabel.textColor = cellModel.titleNormalColor;
        self.titleLabel.font = cellModel.titleFont;
    }
}

@end

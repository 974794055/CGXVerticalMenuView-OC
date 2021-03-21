//
//  MoreViewCell.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "MoreViewCell.h"

@interface MoreViewCell()

@property (nonatomic , strong) CGXVerticalMenuMoreListSectionItemModel *model;


@end
@implementation MoreViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    self.urlImageView = [[UIImageView alloc] init];
    self.urlImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.urlImageView];
    self.urlImageView.frame = self.bounds;
    self.urlImageView.layer.masksToBounds = YES;
    self.urlImageView.clipsToBounds = YES;
    
    
    self.titleLabel  =[[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)reloadData:(CGXVerticalMenuMoreListSectionItemModel *)model
{
    self.model = model;
    
    self.urlImageView.frame = CGRectMake(10, 10, CGRectGetHeight(self.contentView.frame)-20, CGRectGetHeight(self.contentView.frame)-20);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.urlImageView.frame)+20, 0, CGRectGetWidth(self.contentView.frame)-CGRectGetMaxX(self.urlImageView.frame)-30, CGRectGetHeight(self.contentView.frame));
    
    self.contentView.backgroundColor = model.itemBgColor;
    self.urlImageView.layer.cornerRadius = model.itemCornerRadius;
    self.contentView.layer.borderWidth = model.itemBborderWidth;
    self.contentView.layer.borderColor = [model.itemBorderColor CGColor];
    self.contentView.layer.cornerRadius = model.itemCornerRadius;
    
    __weak typeof(self) weakSelf = self;
    if ([model.itemUrlStr hasPrefix:@"http:"] || [model.itemUrlStr hasPrefix:@"https:"]) {
        if (model.menu_ImageCallback) {
            model.menu_ImageCallback(weakSelf.urlImageView, [NSURL URLWithString:model.itemUrlStr]);
        }
    } else{
        UIImage *image = [UIImage imageNamed:model.itemUrlStr];
        if (!image) {
            image = [UIImage imageWithContentsOfFile:model.itemUrlStr];
        }
        self.urlImageView.image = image;
    }

    self.titleLabel.text = model.itemText;
    self.titleLabel.textColor = model.itemColor;
    self.titleLabel.font = model.itemFont;
    self.titleLabel.numberOfLines = model.numberOfLines;

}
@end

//
//  CGXVerticalMenuCollectionCell..m
//  CGXCategoryListView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCollectionCell.h"
@interface CGXVerticalMenuCollectionCell()

@property (nonatomic , strong) CGXVerticalMenuCollectionItemModel *model;

@end
@implementation CGXVerticalMenuCollectionCell

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
    self.urlImageView = [[UIImageView alloc] init];
    self.urlImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.urlImageView];
    self.urlImageView.frame = self.bounds;
    self.urlImageView.layer.masksToBounds = YES;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.urlImageView.frame = self.bounds;
    self.contentView.backgroundColor = self.model.bgColor;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.urlImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.model.cornerRadius, self.model.cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.urlImageView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.urlImageView.layer.mask = maskLayer;

    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.urlImageView.bounds;
    borderLayer.path = maskPath.CGPath;
    borderLayer.lineWidth = self.model.borderWidth;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = self.model.borderColor.CGColor;
    [self.urlImageView.layer addSublayer:borderLayer];
}
- (void)reloadData:(CGXVerticalMenuCollectionItemModel *)model
{
    self.model = model;
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}
@end

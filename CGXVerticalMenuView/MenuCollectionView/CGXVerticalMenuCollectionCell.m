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

@property (nonatomic , strong) UIView *borderView;
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
    self.borderView = [[UIView alloc] init];
    [self.contentView addSubview:self.borderView];
    self.borderView.frame = self.bounds;
    
    self.urlImageView = [[UIImageView alloc] init];
    self.urlImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.urlImageView];
    self.urlImageView.frame = self.bounds;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.urlImageView.frame = self.bounds;
    
    self.borderView.frame = self.bounds;

    self.borderView.backgroundColor = self.model.bgColor;


}
- (void)reloadData:(CGXVerticalMenuCollectionItemModel *)model
{
    self.model = model;
  
    
    self.borderView.layer.masksToBounds = YES;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.borderView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.model.cornerRadius, self.model.cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.borderView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.borderView.layer.mask = maskLayer;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.borderView.bounds;
    borderLayer.path = maskPath.CGPath;
    borderLayer.lineWidth = self.model.borderWidth;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = self.model.borderColor.CGColor;
    [self.borderView.layer addSublayer:borderLayer];
 
}
@end

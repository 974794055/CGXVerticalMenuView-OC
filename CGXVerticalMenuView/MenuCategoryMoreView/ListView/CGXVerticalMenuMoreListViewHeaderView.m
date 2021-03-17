//
//  CGXVerticalMenuMoreListViewHeaderView.m
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2021/3/15.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListViewHeaderView.h"
@interface CGXVerticalMenuMoreListViewHeaderView()

@property (nonatomic , strong) NSLayoutConstraint *hotTitleTop;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleleft;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleBottom;

@end
@implementation CGXVerticalMenuMoreListViewHeaderView

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
    
    
    self.titleLabel  =[[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.hotTitleleft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.hotTitleRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    self.hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    self.hotTitleTop = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self addConstraint:self.hotTitleleft];
    [self addConstraint:self.hotTitleRight];
    [self addConstraint:self.hotTitleBottom];
    [self addConstraint:self.hotTitleTop];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)updateWithSectionModel:(CGXVerticalMenuMoreListSectionModel *)sectionModel
{
    self.titleLabel.text = sectionModel.headerText;
    self.titleLabel.textColor = sectionModel.headerTextColor;
    self.titleLabel.font = sectionModel.headerTextFont;
    self.titleLabel.textAlignment = sectionModel.headertextAlignment;
    self.hotTitleleft.constant = sectionModel.headTextEdgeInsets.left;
    self.hotTitleRight.constant = -sectionModel.headTextEdgeInsets.right;;
    self.hotTitleTop.constant = sectionModel.headTextEdgeInsets.top;
    self.hotTitleBottom.constant = -sectionModel.headTextEdgeInsets.bottom;
    
}
@end

//
//  CGXVerticalMenuMoreListViewItemCell.m
//  CGXVerticalMenuView-OC
//
//  Created by MacMini-1 on 2021/3/15.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListViewItemCell.h"

@interface CGXVerticalMenuMoreListViewItemCell()

@property (nonatomic , strong) CGXVerticalMenuMoreListSectionItemModel *model;
@property (nonatomic , strong) NSLayoutConstraint *hotImageTop;
@property (nonatomic , strong) NSLayoutConstraint *hotImageLeft;
@property (nonatomic , strong) NSLayoutConstraint *hotImageRight;
@property (nonatomic , strong) NSLayoutConstraint *hotImageBottom;

@property (nonatomic , strong) NSLayoutConstraint *hotTitleHeight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleleft;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleBottom;


@end
@implementation CGXVerticalMenuMoreListViewItemCell

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
    self.urlImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.titleLabel  =[[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.hotImageTop = [NSLayoutConstraint constraintWithItem:self.urlImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    self.hotImageLeft = [NSLayoutConstraint constraintWithItem:self.urlImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.hotImageRight = [NSLayoutConstraint constraintWithItem:self.urlImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    self.hotImageBottom = [NSLayoutConstraint constraintWithItem:self.urlImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.hotImageTop];
    [self.contentView addConstraint:self.hotImageLeft];
    [self.contentView addConstraint:self.hotImageRight];
    [self.contentView addConstraint:self.hotImageBottom];
    
    self.hotTitleHeight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [self.titleLabel addConstraint:self.hotTitleHeight];
    
    self.hotTitleleft = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    self.hotTitleRight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    self.hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.hotTitleleft];
    [self.contentView addConstraint:self.hotTitleRight];
    [self.contentView addConstraint:self.hotTitleBottom];
    
    
    self.titleLabel.hidden = YES;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}
- (void)reloadData:(CGXVerticalMenuMoreListSectionItemModel *)model TitleHeight:(CGFloat)titleHeight
{
    self.model = model;
    self.contentView.backgroundColor = model.itemBgColor;
    self.hotImageTop.constant = 0;
    self.hotImageLeft.constant = 0;;
    self.hotImageRight.constant = 0;
    self.hotImageBottom.constant = 0;

    self.hotTitleHeight.constant = titleHeight;
    self.hotTitleleft.constant = 0;
    self.hotTitleRight.constant = 0;
    self.hotTitleBottom.constant = 0;

    self.titleLabel.hidden = YES;
    if (titleHeight > 0) {
        self.titleLabel.hidden = NO;
        self.hotImageBottom.constant = - titleHeight;
    }
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
            self.urlImageView.image = image;
        }
        if (model.menu_ImageCallback) {
            model.menu_ImageCallback(weakSelf.urlImageView, [NSURL URLWithString:@""]);
        }
        
    }

    self.titleLabel.text = model.itemText;
    self.titleLabel.textColor = model.itemColor;
    self.titleLabel.font = model.itemFont;
    self.titleLabel.numberOfLines = model.numberOfLines;

}
@end

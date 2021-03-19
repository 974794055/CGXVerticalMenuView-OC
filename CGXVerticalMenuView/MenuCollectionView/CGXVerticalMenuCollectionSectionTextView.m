//
//  CGXVerticalMenuCollectionSectionTextView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/12.
//

#import "CGXVerticalMenuCollectionSectionTextView.h"

@implementation CGXVerticalMenuCollectionSectionTextView
 - (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        UILabel *ppLabel  =[[UILabel alloc] init];
        ppLabel.textColor = [UIColor blackColor];
        ppLabel.font = [UIFont systemFontOfSize:14];
        ppLabel.numberOfLines = 0;
        ppLabel.textAlignment = NSTextAlignmentCenter;
        ppLabel.layer.masksToBounds = YES;
        ppLabel.layer.borderWidth = 0;
        ppLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        ppLabel.layer.cornerRadius = 0;
        ppLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:ppLabel];
        self.titleLabel = ppLabel;
    }
    return self;
}
- (void)updateWithTextModel:(CGXVerticalMenuCustomTextModel *)textModel
{
    self.titleLabel.text = textModel.text;
    self.titleLabel.textColor = textModel.textColor;
    self.titleLabel.font = textModel.textFont;
    self.titleLabel.numberOfLines = textModel.numberOfLines;
    self.titleLabel.textAlignment = textModel.textAlignment;
    self.titleLabel.layer.borderWidth = textModel.borderWidth;
    self.titleLabel.layer.borderColor = textModel.borderColor.CGColor;
    self.titleLabel.layer.cornerRadius = textModel.borderRadius;
    self.titleLabel.backgroundColor = textModel.textBgColor;
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:textModel.spaceTop];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:textModel.spaceLeft];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-textModel.spaceRight];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-textModel.spaceBottom];
    [self addConstraint:top];
    [self addConstraint:left];
    [self addConstraint:right];
    [self addConstraint:bottom];
    
}
@end

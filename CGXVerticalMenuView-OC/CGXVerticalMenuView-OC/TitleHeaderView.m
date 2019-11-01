//
//  TitleHeaderView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2019/9/12.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "TitleHeaderView.h"
#import "CGXVerticalMenuCollectionViewLayoutAttributes.h"
@implementation TitleHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        self.titleLabel.textColor = [UIColor blackColor];
        
        
        self.urlImageView = [[UIImageView alloc] init];
        self.urlImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.urlImageView];
        self.urlImageView.frame = self.bounds;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
      self.urlImageView.frame = self.bounds;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[CGXVerticalMenuCollectionViewLayoutAttributes class]]) {
        CGXVerticalMenuCollectionViewLayoutAttributes *attr = (CGXVerticalMenuCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}
@end

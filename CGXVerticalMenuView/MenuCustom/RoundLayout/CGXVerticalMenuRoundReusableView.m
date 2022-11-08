//
//  CGXVerticalMenuCollectionSectionReusableView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuRoundReusableView.h"

@interface CGXVerticalMenuRoundReusableView()

@property (nonatomic , strong) UIImageView *bgImageView;

@property (nonatomic , strong) NSLayoutConstraint *hotImageTop;
@property (nonatomic , strong) NSLayoutConstraint *hotImageLeft;
@property (nonatomic , strong) NSLayoutConstraint *hotImageRight;
@property (nonatomic , strong) NSLayoutConstraint *hotImageBottom;


@end
@implementation CGXVerticalMenuRoundReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImageView = [[UIImageView alloc]init];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.clipsToBounds = YES;
        self.bgImageView.layer.masksToBounds = YES;
        self.bgImageView.layer.shouldRasterize = YES; // 缓存
        [self addSubview:self.bgImageView];
        
        self.bgImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.hotImageTop = [NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        self.hotImageLeft = [NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        self.hotImageRight = [NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        self.hotImageBottom = [NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraint:self.hotImageTop];
        [self addConstraint:self.hotImageLeft];
        [self addConstraint:self.hotImageRight];
        [self addConstraint:self.hotImageBottom];
        
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    self.bgImageView.frame = self.bounds;
    self.hotImageTop.constant = 0;
    self.hotImageLeft.constant = 0;
    self.hotImageRight.constant = 0;
    self.hotImageBottom.constant = 0;
    CGXVerticalMenuRoundLayoutAttributes *attr = (CGXVerticalMenuRoundLayoutAttributes *)layoutAttributes;
    _myCacheAttr = attr;
    [self toChangeCollectionReusableViewRoundInfoWithLayoutAttributes:attr];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    [self toChangeCollectionReusableViewRoundInfoWithLayoutAttributes:_myCacheAttr];
}

- (void)toChangeCollectionReusableViewRoundInfoWithLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    CGXVerticalMenuRoundLayoutAttributes *attr = (CGXVerticalMenuRoundLayoutAttributes *)layoutAttributes;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    __weak typeof(self) weakSelf = self;
    if (attr.myConfigModel) {
        CGXVerticalMenuRoundModel *model = attr.myConfigModel;
        UIImage *bgImage = [self gx_pageImageWithColor:model.backgroundColor];
        if (model.hotStr && model.hotStr.length>0) {
            bgImage = [UIImage imageNamed:model.hotStr];
            if (!bgImage) {
                bgImage = [UIImage imageWithContentsOfFile:model.hotStr];
            }
        }
        self.bgImageView.image = bgImage;
        
        if (model.menu_ImageCallback) {
            model.menu_ImageCallback(weakSelf.bgImageView,[NSURL URLWithString:model.hotStr]);
        }
        if (@available(iOS 13.0, *)) {
            self.bgImageView.layer.borderColor = [model.borderColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
        } else {
            self.bgImageView.layer.borderColor = model.borderColor.CGColor;
        }
        self.bgImageView.layer.shadowOffset = model.shadowOffset;
        self.bgImageView.layer.shadowOpacity = model.shadowOpacity;
        self.bgImageView.layer.shadowRadius = model.shadowRadius;
        self.bgImageView.layer.borderWidth = model.borderWidth;
        self.bgImageView.layer.cornerRadius = model.cornerRadius;
    } else{
        self.bgImageView.backgroundColor = self.backgroundColor;
    }
    [CATransaction commit];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (event.type == UIEventTypeTouches) {
        //touchType
        [self decorationViewUserDidSelectEvent];
    }
}

#pragma mark - touchEvent

- (void)decorationViewUserDidSelectEvent {
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    if ([collectionView isKindOfClass:[UICollectionView class]]) {
        //is CollectionView
        id <CGXVerticalMenuRoundFlowLayoutDelegate> delegate  = (id <CGXVerticalMenuRoundFlowLayoutDelegate>)collectionView.delegate;
        if ([delegate respondsToSelector:@selector(collectionView:didSelectDecorationViewAtIndexPath:)]) {
            [delegate collectionView:collectionView didSelectDecorationViewAtIndexPath:_myCacheAttr.indexPath];
        }
    }
}

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
- (UIImage *)gx_pageImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

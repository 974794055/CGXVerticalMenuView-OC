//
//  CGXVerticalMenuCollectionSectionReusableView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCollectionReusableView.h"
#import "CGXVerticalMenuCollectionViewLayoutAttributes.h"
@implementation CGXVerticalMenuCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[CGXVerticalMenuCollectionViewLayoutAttributes class]]) {
        CGXVerticalMenuCollectionViewLayoutAttributes *attr = (CGXVerticalMenuCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}

@end

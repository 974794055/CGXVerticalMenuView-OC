//
//  CGXVerticalMenuMoreListTitleView.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuMoreListTitleView.h"

@interface CGXVerticalMenuMoreListTitleViewCell:UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
- (void)updatwWithModel:(CGXVerticalMenuMoreListTitleModel *)model Text:(NSString *)text IsSelect:(BOOL)isSelect;
@end

@implementation CGXVerticalMenuMoreListTitleViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = ({
            UILabel *ppLabel  =[[UILabel alloc] init];
            ppLabel.textColor = [UIColor blackColor];
            ppLabel.font = [UIFont systemFontOfSize:14];
            ppLabel.numberOfLines = 1;
            ppLabel.textAlignment = NSTextAlignmentCenter;
            ppLabel.layer.masksToBounds = YES;
            ppLabel.layer.borderWidth = 1;
            ppLabel.layer.borderColor = [UIColor blackColor].CGColor;
            ppLabel.layer.cornerRadius = 8;
            ppLabel;
        });
        
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = [UIColor whiteColor];;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}
- (void)updatwWithModel:(CGXVerticalMenuMoreListTitleModel *)model Text:(NSString *)text IsSelect:(BOOL)isSelect
{
    self.titleLabel.text = text;
    if (isSelect) {
        self.titleLabel.backgroundColor = model.textSelectBgColor;
        self.titleLabel.textColor = model.textSelectColor;
        self.titleLabel.font = model.textSelectFont;
        self.titleLabel.layer.borderWidth = model.textSelectBorderWidth;
        self.titleLabel.layer.borderColor = model.textSelectBorderColor.CGColor;
        self.titleLabel.layer.cornerRadius = model.textSelectBorderRadius;
    } else{
        self.titleLabel.backgroundColor = model.textNormalBgColor;
        self.titleLabel.textColor = model.textNormalColor;
        self.titleLabel.font = model.textNormalFont;
        self.titleLabel.layer.borderWidth = model.textNormalBorderWidth;
        self.titleLabel.layer.borderColor = model.textNormalBorderColor.CGColor;
        self.titleLabel.layer.cornerRadius = model.textNormalBorderRadius;
    }
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:top];
    [self.contentView addConstraint:left];
    [self.contentView addConstraint:right];
    [self.contentView addConstraint:bottom];
    
}
@end

@interface CGXVerticalMenuMoreListTitleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong,readwrite) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray<NSString *> *titleArray;
@property (nonatomic , assign,readwrite) NSInteger currentInter;
@property (nonatomic , strong) CGXVerticalMenuMoreListTitleModel *titleModel;

@end
@implementation CGXVerticalMenuMoreListTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentInter = 0;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        [self.collectionView registerClass:[CGXVerticalMenuMoreListTitleViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuMoreListTitleViewCell class])];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        if (@available(iOS 11.0, *)) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        //    mCollectionView.alwaysBounceVertical = YES;
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.collectionView];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraint:top];
    [self addConstraint:left];
    [self addConstraint:right];
    [self addConstraint:bottom];

    
}
- (NSMutableArray<NSString *> *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.titleModel.titleSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.titleModel.titleSpace;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.titleArray[indexPath.row];
    BOOL select = (self.currentInter == indexPath.row ? YES:NO);
    UIFont *font = select ? self.titleModel.textSelectFont:self.titleModel.textSelectFont;
    CGFloat radius = select ? self.titleModel.textSelectBorderRadius:self.titleModel.textNormalBorderRadius;
    CGFloat width = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size.width;
    return CGSizeMake(width+radius*2+self.titleModel.titleSpace, CGRectGetHeight(collectionView.frame));
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        view.backgroundColor = collectionView.backgroundColor;
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        view.backgroundColor = collectionView.backgroundColor;;
        return view;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXVerticalMenuMoreListTitleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXVerticalMenuMoreListTitleViewCell class]) forIndexPath:indexPath];
    NSString *text = self.titleArray[indexPath.row];
    [cell updatwWithModel:self.titleModel Text:text IsSelect:(self.currentInter == indexPath.row ? YES:NO)];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self clickAtIndex:indexPath.row];
}
- (void)updateDataTitieArray:(NSMutableArray<NSString *> *)titleArray TitleModel:(CGXVerticalMenuMoreListTitleModel *)titleModel Inter:(NSInteger)inter
{
    self.currentInter = inter;
    self.titleModel = titleModel;
    [self.titleArray removeAllObjects];
    [self.titleArray addObjectsFromArray:titleArray];
    [self.collectionView reloadData];
}
- (void)clickAtIndex:(NSInteger)index
{
    [self scrollAtIndex:index];
    if (self.titieSelectBlock) {
        self.titieSelectBlock(index);
    }
}
- (void)scrollAtIndex:(NSInteger)index
{
    if (self.titleArray.count==0 && index >= self.titleArray.count) {
        return;
    }
    self.currentInter = index;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.collectionView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

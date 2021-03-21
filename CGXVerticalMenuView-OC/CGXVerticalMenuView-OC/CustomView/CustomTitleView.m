//
//  CustomTitleView.m
//  CGXHotBrandView-OC
//
//  Created by CGX on 2018/05/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CustomTitleView.h"
@interface CustomTitleView ()
{
    UIScrollView *mainScrollViewH;
}
@property (nonatomic, assign,readwrite) NSInteger selectedIndex;
@property (nonatomic , strong) NSMutableArray<NSString *> *titleArray;
@property (nonatomic , strong) UIView *lineView;
@property (nonatomic , assign) BOOL isFirst;
@property (nonatomic , strong) UIButton *btn;
@end
@implementation CustomTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isFirst = YES;
        self.selectedIndex= 0;
        mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        mainScrollViewH.bounces = YES;
        mainScrollViewH.scrollEnabled = YES;
        mainScrollViewH.showsHorizontalScrollIndicator = NO;
        mainScrollViewH.showsVerticalScrollIndicator = NO;
        [self addSubview:mainScrollViewH];
        mainScrollViewH.translatesAutoresizingMaskIntoConstraints = NO;
        mainScrollViewH.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor redColor];
        [mainScrollViewH addSubview:self.lineView];
        [mainScrollViewH bringSubviewToFront:self.lineView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    mainScrollViewH.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:mainScrollViewH attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:mainScrollViewH attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:mainScrollViewH attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:mainScrollViewH attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraint:top];
    [self addConstraint:left];
    [self addConstraint:right];
    [self addConstraint:bottom];
    
    CGFloat x = 10;
    for (int i = 0; i<self.titleArray.count; i++) {
        NSString *str = self.titleArray[i];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainScrollViewH addSubview:btn1];
        btn1.tag = 10000+i;
        [btn1 setTitle:str forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        
        CGFloat width = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width+20;
        btn1.frame = CGRectMake(x, 0, width, 50);
        x = x + width;
        if (i==0) {
            
            self.lineView.frame = CGRectMake(CGRectGetMinX(btn1.frame)+(CGRectGetWidth(btn1.frame)-20)/2.0, 40, 20, 3);
        }
        if (i==0) {
            self.selectedIndex = i;
            [self btnClick:btn1];
        }
    }
    CGFloat scrollViewWidth = CGRectGetMaxX(mainScrollViewH.subviews.lastObject.frame);
    mainScrollViewH.contentSize = CGSizeMake(scrollViewWidth+10,50);
    
}
- (NSMutableArray<NSString *> *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
- (void)updateDataTitieArray:(NSMutableArray<NSString *> *)titleArray
{
    [self.titleArray removeAllObjects];
    [self.titleArray addObjectsFromArray:titleArray];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)btnClick:(UIButton *)btn
{
    if (self.selectedIndex == btn.tag-10000 ) {
        if (!self.isFirst) {
            return;
        }
    }
    self.btn = btn;
    self.isFirst = NO;
    self.selectedIndex = btn.tag-10000;
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.5 animations:^{
            weakSelf.lineView.frame = CGRectMake(CGRectGetMinX(btn.frame)+(CGRectGetWidth(btn.frame)-20)/2.0, weakSelf.lineView.frame.origin.y, weakSelf.lineView.frame.size.width, weakSelf.lineView.frame.size.height);
    }];
    // 计算偏移量
    CGFloat offsetX = btn.center.x - CGRectGetWidth(mainScrollViewH.frame) * 0.5;
    if (offsetX < 0) offsetX = 0;
    // 获取最大滚动范围
    CGFloat maxOffsetX = mainScrollViewH.contentSize.width - CGRectGetWidth(mainScrollViewH.frame);
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    // 滚动标题滚动条
    [mainScrollViewH setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    if (self.titieSelectBlock) {
        self.titieSelectBlock(btn.tag-10000);
    }
    [self selectItemAtIndex:self.selectedIndex];
}
- (void)selectItemAtIndex:(NSInteger)index
{
    self.isFirst = NO;
    self.selectedIndex = index;
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.5 animations:^{
            weakSelf.lineView.frame = CGRectMake(CGRectGetMinX(self.btn.frame)+(CGRectGetWidth(self.btn.frame)-20)/2.0, weakSelf.lineView.frame.origin.y, weakSelf.lineView.frame.size.width, weakSelf.lineView.frame.size.height);
    }];
    // 计算偏移量
    CGFloat offsetX = self.btn.center.x - CGRectGetWidth(mainScrollViewH.frame) * 0.5;
    if (offsetX < 0) offsetX = 0;
    // 获取最大滚动范围
    CGFloat maxOffsetX = mainScrollViewH.contentSize.width - CGRectGetWidth(mainScrollViewH.frame);
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    // 滚动标题滚动条
    [mainScrollViewH setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    if (self.titieSelectBlock) {
        self.titieSelectBlock(self.btn.tag-10000);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

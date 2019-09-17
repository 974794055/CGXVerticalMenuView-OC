//
//  CGXVerticalMenuCategoryTableViewCell.m
//  CGXVerticalMenuView-OC
//
//  Created by 曹贵鑫 on 2019/9/17.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXVerticalMenuCategoryTableViewCell.h"


@interface CGXVerticalMenuCategoryTableViewCell()

@property (nonatomic, strong) NSMutableArray <CGXVerticalMenuCollectionSectionModel *> *dataArray;
@property (nonatomic , assign) NSInteger currentInteger;
@end
@implementation CGXVerticalMenuCategoryTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.dataArray = [NSMutableArray array];
        self.rightView = [[CGXVerticalMenuCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
//        self.rightView.delegate = self;
//        self.rightView.backgroundColor = self.righttBgColor;
        [self.contentView addSubview:self.rightView];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.rightView.frame = self.bounds;
}
- (void)updateCellWithDataArray:(NSMutableArray<CGXVerticalMenuCollectionSectionModel *> *)dataArray AtIndex:(NSInteger)index
{
    self.currentInteger = index;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.rightView updateRightWithDataArray:self.dataArray];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

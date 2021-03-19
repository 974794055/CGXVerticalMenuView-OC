//
//  CGXVerticalMenuCustomTextModel.m
//  CGXVerticalMenuView-OC
//
//  Created by CGX on 2021/3/11.
//

#import "CGXVerticalMenuCustomTextModel.h"

@implementation CGXVerticalMenuCustomTextModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (instancetype)init
{
     self = [super init];
    if (self) {
        self.textColor = [UIColor blackColor];
        self.textBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];;
        self.textFont = [UIFont systemFontOfSize:14];
        self.spaceLeft = 10;
        self.spaceRight = 10;
        self.spaceTop = 0;
        self.spaceBottom = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.numberOfLines = 1;
        self.borderColor = [UIColor whiteColor];
        self.borderWidth = 0;
        self.borderRadius = 0;
    }
    return self;
}
@end

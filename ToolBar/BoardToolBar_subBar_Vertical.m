//
//  BoardToolBar_subBar_Vertical.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar_subBar_Vertical.h"

#define kSelfWidth  self.frame.size.width
#define kSelfHeight self.frame.size.height
#define kScreenScaleWidthWithOriginal(x)   (kSelfWidth/55 * x)
#define kScreenScaleHeightWithOriginal(x)  (kSelfHeight/375 * x)

#define kboardSubBarLeftSubBarWidth kScreenScaleHeightWithOriginal(116)
#define kboardSubBarTopMidDistance  kScreenScaleWidthWithOriginal(12)
#define kboardSubBarMidLineWidth    kScreenScaleHeightWithOriginal(1.5)

@interface BoardToolBar_subBar_Vertical ()

@property(nonatomic,strong)UIView *midLineView;

@end

@implementation BoardToolBar_subBar_Vertical


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.sizeBar = [[BoardToolBar_chooseSizeBar_Vertical alloc]initWithFrame:CGRectMake(0, 0,
                                                                                        kSelfWidth,
                                                                                        kboardSubBarLeftSubBarWidth)];
    [self addSubview:self.sizeBar];
    
    self.colorBar = [[BoardToolBar_chooseColorBar_Vertical alloc]initWithFrame:CGRectMake(0,
                                                                                          kboardSubBarLeftSubBarWidth +
                                                                                          kboardSubBarMidLineWidth,
                                                                                          kSelfWidth,
                                                                                          kSelfHeight -
                                                                                          kboardSubBarLeftSubBarWidth -
                                                                                          kboardSubBarMidLineWidth)];
    [self addSubview:self.colorBar];
    
    self.midLineView = [[UIView alloc]initWithFrame:CGRectMake(kboardSubBarTopMidDistance,
                                                               kboardSubBarLeftSubBarWidth,
                                                               kSelfWidth - 2 * kboardSubBarTopMidDistance,
                                                               kboardSubBarMidLineWidth)];
    
    [self addSubview:self.midLineView];
    
    return self;
}

- (void)setHighLightedColor:(UIColor *)highLightedColor{
    _highLightedColor = highLightedColor;
    
    for (BoardToolBar_colorItem *item in self.colorBar.itemArr) {
        item.highLightedColor = highLightedColor;
    }
    for (BoardToolBar_RootBarItem *item in self.sizeBar.itemArr) {
        item.highLightedColor = highLightedColor;
    }
}
- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.midLineView.backgroundColor = lineColor;
}

@end

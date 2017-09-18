//
//  BoardToolBar_subBar.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar_subBar.h"

#define kSelfWidth  self.frame.size.width
#define kSelfHeight self.frame.size.height
#define kScreenScaleWidthWithOriginal(x)   (kSelfWidth/375 * x)
#define kScreenScaleHeightWithOriginal(x)  (kSelfHeight/55 * x)

#define kboardSubBarLeftSubBarWidth kScreenScaleWidthWithOriginal(116)
#define kboardSubBarTopMidDistance  kScreenScaleHeightWithOriginal(12)
#define kboardSubBarMidLineWidth    kScreenScaleHeightWithOriginal(1.5)

@interface BoardToolBar_subBar ()

//分割线
@property(nonatomic,strong)UIView *midLineView;

@end

@implementation BoardToolBar_subBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.sizeBar = [[BoardToolBar_chooseSizeBar alloc]initWithFrame:CGRectMake(0, 0,
                                                                               kboardSubBarLeftSubBarWidth,
                                                                               kSelfHeight)];
    [self addSubview:self.sizeBar];
    
    self.colorBar = [[BoardToolBar_chooseColorBar alloc]initWithFrame:CGRectMake(kboardSubBarLeftSubBarWidth +
                                                                                 kboardSubBarMidLineWidth, 0,
                                                                                 kSelfWidth -
                                                                                 kboardSubBarLeftSubBarWidth -
                                                                                 kboardSubBarMidLineWidth,
                                                                                 kSelfHeight)];
    [self addSubview:self.colorBar];
    
    self.midLineView = [[UIView alloc]initWithFrame:CGRectMake(kboardSubBarLeftSubBarWidth,
                                                               kboardSubBarTopMidDistance,
                                                               kboardSubBarMidLineWidth,
                                                               kSelfHeight - 2 * kboardSubBarTopMidDistance)];
    
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

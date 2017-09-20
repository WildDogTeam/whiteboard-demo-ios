//
//  BoardToolBar_chooseColorBar.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar_chooseColorBar.h"

#define kSelfWidth  self.frame.size.width
#define kSelfHeight self.frame.size.height
#define kScreenScaleWidthWithOriginal(x)   (kSelfWidth/255 * x)
#define kScreenScaleHeightWithOriginal(x)  (kSelfHeight/55 * x)

#define kboardColorBarTopMidDistance  kScreenScaleHeightWithOriginal(10)
#define kboardColorBarLeftMidDistance kScreenScaleWidthWithOriginal(12)
#define kboardColorBarItemMidDistance kScreenScaleWidthWithOriginal(6.5)

#define kboardColorBarItemWidth  ((kSelfWidth-2*kboardColorBarLeftMidDistance-5*kboardColorBarItemMidDistance)/6)
#define kboardColorBarItemHeight (kSelfHeight-2*kboardColorBarTopMidDistance)


@interface BoardToolBar_chooseColorBar ()

@property(nonatomic,strong)NSArray *colorArr;

@end

@implementation BoardToolBar_chooseColorBar

-(NSArray *)colorArr{
    return @[
             [UIColor colorWithRed:0.992 green:0.243 blue:0.224 alpha:1.000],
             [UIColor colorWithRed:0.992 green:0.584 blue:0.153 alpha:1.000],
             [UIColor colorWithRed:0.318 green:0.843 blue:0.416 alpha:1.000],
             [UIColor colorWithRed:0.086 green:0.502 blue:0.980 alpha:1.000],
             [UIColor colorWithWhite:0.796 alpha:1.000],
             [UIColor colorWithWhite:0.042 alpha:1.000]
             ];
}

-(NSMutableArray *)itemArr{
    if(!_itemArr){
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    for (int i=0; i<self.colorArr.count; i++) {
        UIColor *color = self.colorArr[i];
        BoardToolBar_colorItem *item = [[BoardToolBar_colorItem alloc]
                                        initWithFrame:CGRectMake(kboardColorBarLeftMidDistance +
                                                                 i * (kboardColorBarItemWidth +
                                                                      kboardColorBarItemMidDistance),
                                                                 kboardColorBarTopMidDistance,
                                                                 kboardColorBarItemWidth,
                                                                 kboardColorBarItemHeight)];
        item.color = color;
        
        [item.btn addTarget:self action:@selector(choosedColor:)
           forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:item];
        [self.itemArr addObject:item];
    }
    
    return self;
}

- (void)choosedColor:(UIButton *)btn{
    for (BoardToolBar_colorItem *item in self.itemArr) {
        if(item.btn != btn){
            [item unchoose];
        }else{
            [item choose];
        }
    }
}

@end

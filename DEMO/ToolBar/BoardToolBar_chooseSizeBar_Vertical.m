//
//  BoardToolBar_chooseSizeBar_Vertical.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar_chooseSizeBar_Vertical.h"

#define kSelfWidth  self.frame.size.width
#define kSelfHeight self.frame.size.height
#define kScreenScaleWidthWithOriginal(x)   (kSelfWidth/55 * x)
#define kScreenScaleHeightWithOriginal(x)  (kSelfHeight/116 * x)

#define kboardSizeBarTopMidDistance  kScreenScaleWidthWithOriginal(12)
#define kboardSizeToolItemWidth     kScreenScaleHeightWithOriginal(32)
#define kboardSizeToolItemHeight    (kSelfWidth-2*kboardSizeBarTopMidDistance)
#define kboardSizeFirstItemLeft     kScreenScaleHeightWithOriginal(10)
#define kboardSizeSecItemLeft       kScreenScaleHeightWithOriginal(40)
#define kboardSizeThirdItemLeft     kScreenScaleHeightWithOriginal(78)

@interface BoardToolBar_chooseSizeBar_Vertical ()



@end

@implementation BoardToolBar_chooseSizeBar_Vertical


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    BoardToolBar_RootBarItem *firstItem = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(kboardSizeBarTopMidDistance,
                                                                                                    kboardSizeFirstItemLeft,
                                                                                                    kboardSizeToolItemHeight,
                                                                                                    kboardSizeToolItemWidth)];
    firstItem.icon = [UIImage imageNamed:@"boardTool_small-circle.png"];
    [self addSubview:firstItem];
    [self.itemArr addObject:firstItem];
    
    BoardToolBar_RootBarItem *secItem = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(kboardSizeBarTopMidDistance,
                                                                                                  kboardSizeSecItemLeft,
                                                                                                  kboardSizeToolItemHeight,
                                                                                                  kboardSizeToolItemWidth)];
    secItem.icon = [UIImage imageNamed:@"boardTool_mid-circle.png"];
    [self addSubview:secItem];
    [self.itemArr addObject:secItem];
    
    BoardToolBar_RootBarItem *thirdItem = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(kboardSizeBarTopMidDistance,
                                                                                                    kboardSizeThirdItemLeft,
                                                                                                    kboardSizeToolItemHeight,
                                                                                                    kboardSizeToolItemWidth)];
    thirdItem.icon = [UIImage imageNamed:@"boardTool_big-circle.png"];
    [self addSubview:thirdItem];
    [self.itemArr addObject:thirdItem];
    
    
    for (BoardToolBar_RootBarItem *item in self.itemArr) {
        [item.btn addTarget:self action:@selector(choosedSize:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)choosedSize:(UIButton *)btn{
    for (BoardToolBar_RootBarItem *item in self.itemArr) {
        if(item.btn != btn){
            [item unchoose];
        }else{
            [item choose];
        }
    }
}

-(NSMutableArray *)itemArr{
    if(!_itemArr){
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}


@end

//
//  BoardToolBar_chooseSizeBar.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar_chooseSizeBar.h"

#define kSelfWidth  self.frame.size.width
#define kSelfHeight self.frame.size.height
#define kScreenScaleWidthWithOriginal(x)   (kSelfWidth/116 * x)
#define kScreenScaleHeightWithOriginal(x)  (kSelfHeight/55 * x)

#define kboardSizeBarTopMidDistance  kScreenScaleHeightWithOriginal(12)
#define kboardSizeToolItemWidth kScreenScaleWidthWithOriginal(32)
#define kboardSizeToolItemHeight (kSelfHeight-2*kboardSizeBarTopMidDistance)
#define kboardSizeFirstItemLeft kScreenScaleWidthWithOriginal(10)
#define kboardSizeSecItemLeft kScreenScaleWidthWithOriginal(40)
#define kboardSizeThirdItemLeft kScreenScaleWidthWithOriginal(78)

@interface BoardToolBar_chooseSizeBar ()

@end

@implementation BoardToolBar_chooseSizeBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    BoardToolBar_RootBarItem *firstItem = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(kboardSizeFirstItemLeft,
                                                                                                    kboardSizeBarTopMidDistance,
                                                                                                    kboardSizeToolItemWidth,
                                                                                                    kboardSizeToolItemHeight)];
    firstItem.icon = [UIImage imageNamed:@"boardTool_small-circle.png"];
    [self addSubview:firstItem];
    [self.itemArr addObject:firstItem];
    
    BoardToolBar_RootBarItem *secItem = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(kboardSizeSecItemLeft,
                                                                                                  kboardSizeBarTopMidDistance,
                                                                                                  kboardSizeToolItemWidth,
                                                                                                  kboardSizeToolItemHeight)];
    secItem.icon = [UIImage imageNamed:@"boardTool_mid-circle.png"];
    [self addSubview:secItem];
    [self.itemArr addObject:secItem];
    
    BoardToolBar_RootBarItem *thirdItem = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(kboardSizeThirdItemLeft,
                                                                                                    kboardSizeBarTopMidDistance,
                                                                                                    kboardSizeToolItemWidth,
                                                                                                    kboardSizeToolItemHeight)];
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

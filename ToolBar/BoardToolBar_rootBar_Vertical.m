//
//  BoardToolBar_Vertical.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar_rootBar_Vertical.h"

#define kSelfWidth  self.frame.size.width
#define kSelfHeight self.frame.size.height
#define kScreenScaleWidthWithOriginal(x)   (kSelfWidth/55 * x)
#define kScreenScaleHeightWithOriginal(x)  (kSelfHeight/375 * x)

#define kboardBarTopMidDistance  kScreenScaleWidthWithOriginal(12)
#define kboardBarLeftMidDistance kScreenScaleHeightWithOriginal(10)
#define kboardBarItemMidDistance kScreenScaleHeightWithOriginal(14)

#define kboardBarItemWidth  ((kSelfHeight-2*kboardBarLeftMidDistance-7*kboardBarItemMidDistance)/8)
#define kboardBarItemHeight (kSelfWidth-2*kboardBarTopMidDistance)

@interface BoardToolBar_rootBar_Vertical ()

@property(nonatomic,strong)NSArray *staticItemArr;
@property(nonatomic,strong)NSArray *activeItemArr;

@end

@implementation BoardToolBar_rootBar_Vertical


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self AddItems];
    
    return self;
}


- (void)setHighLightedColor:(UIColor *)highLightedColor{
    _highLightedColor = highLightedColor;
    for (BoardToolBar_RootBarItem *item in self.itemArr) {
        item.highLightedColor = highLightedColor;
    }
}

- (void)AddItems{
    for (int i=0; i<self.itemArr.count; i++) {
        BoardToolBar_RootBarItem *item = self.itemArr[i];
        item.frame = CGRectMake(kboardBarTopMidDistance
                                ,kboardBarLeftMidDistance +
                                i * (kboardBarItemWidth + kboardBarItemMidDistance),
                                kboardBarItemHeight,
                                kboardBarItemWidth
                                );
        [self addSubview:item];
        
        [item.btn addTarget:self action:@selector(choosedTool:)
           forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)choosedTool:(UIButton *)btn{
    BOOL isActiveItem = NO;
    for (BoardToolBar_RootBarItem *item in self.activeItemArr) {
        if(item.btn == btn){
            isActiveItem = YES;
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [item unchoose];
            });
        }
    }
    if(!isActiveItem){
        for (BoardToolBar_RootBarItem *item in self.staticItemArr) {
            if(item.btn != btn){
                [item unchoose];
            }
        }
    }
}

- (NSArray *)itemArr{
    return @[self.item_pen,
             self.item_line,
             self.item_rect,
             self.item_circle,
             self.item_image,
             self.item_text,
             self.item_undo,
             self.item_clear];
}

-(NSArray *)staticItemArr{
    return @[self.item_pen,
             self.item_line,
             self.item_rect,
             self.item_circle,
             self.item_text];
}

-(NSArray *)activeItemArr{
    return @[self.item_image,
             self.item_undo,
             self.item_clear];
}

- (BoardToolBar_RootBarItem *)item_pen{
    if(!_item_pen){
        _item_pen = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(0, 0,
                                                                              kboardBarItemHeight,
                                                                              kboardBarItemWidth)];
        _item_pen.icon = [UIImage imageNamed:@"boardTool_pen.png"];
    }
    return _item_pen;
}
- (BoardToolBar_RootBarItem *)item_line{
    if(!_item_line){
        _item_line = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(0, 0,
                                                                               kboardBarItemHeight,
                                                                               kboardBarItemWidth)];
        _item_line.icon = [UIImage imageNamed:@"boardTool_line.png"];
    }
    return _item_line;
}
- (BoardToolBar_RootBarItem *)item_rect{
    if(!_item_rect){
        _item_rect = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(0, 0,
                                                                               kboardBarItemHeight,
                                                                               kboardBarItemWidth)];
        _item_rect.icon = [UIImage imageNamed:@"boardTool_rect.png"];
    }
    return _item_rect;
}
- (BoardToolBar_RootBarItem *)item_circle{
    if(!_item_circle){
        _item_circle = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(0, 0,
                                                                                 kboardBarItemHeight,
                                                                                 kboardBarItemWidth)];
        _item_circle.icon = [UIImage imageNamed:@"boardTool_circle.png"];
    }
    return _item_circle;
}
- (BoardToolBar_RootBarItem *)item_image{
    if(!_item_image){
        _item_image = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(0, 0,
                                                                                kboardBarItemHeight,
                                                                                kboardBarItemWidth)];
        _item_image.icon = [UIImage imageNamed:@"boardTool_image.png"];
    }
    return _item_image;
}
- (BoardToolBar_RootBarItem *)item_text{
    if(!_item_text){
        _item_text = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(0, 0,
                                                                               kboardBarItemHeight,
                                                                               kboardBarItemWidth)];
        _item_text.icon = [UIImage imageNamed:@"boardTool_text.png"];
    }
    return _item_text;
}
- (BoardToolBar_RootBarItem *)item_undo{
    if(!_item_undo){
        _item_undo = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(0, 0,
                                                                               kboardBarItemHeight,
                                                                               kboardBarItemWidth)];
        _item_undo.icon = [UIImage imageNamed:@"boardTool_undo.png"];
    }
    return _item_undo;
}
- (BoardToolBar_RootBarItem *)item_clear{
    if(!_item_clear){
        _item_clear = [[BoardToolBar_RootBarItem alloc]initWithFrame:CGRectMake(0, 0,
                                                                                kboardBarItemHeight,
                                                                                kboardBarItemWidth)];
        _item_clear.icon = [UIImage imageNamed:@"boardTool_clear.png"];
    }
    return _item_clear;
}


@end

//
//  BoardToolBar_rootBar.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BoardToolBar_RootBarItem.h"

@interface BoardToolBar_rootBar : UIView

@property(nonatomic,strong)UIColor *highLightedColor;

@property(nonatomic,strong)NSArray *itemArr;

@property(nonatomic,strong)BoardToolBar_RootBarItem *item_pen;
@property(nonatomic,strong)BoardToolBar_RootBarItem *item_line;
@property(nonatomic,strong)BoardToolBar_RootBarItem *item_rect;
@property(nonatomic,strong)BoardToolBar_RootBarItem *item_circle;
@property(nonatomic,strong)BoardToolBar_RootBarItem *item_image;
@property(nonatomic,strong)BoardToolBar_RootBarItem *item_text;
@property(nonatomic,strong)BoardToolBar_RootBarItem *item_undo;
@property(nonatomic,strong)BoardToolBar_RootBarItem *item_clear;

@end

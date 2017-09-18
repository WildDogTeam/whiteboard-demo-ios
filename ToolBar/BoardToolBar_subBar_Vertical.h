//
//  BoardToolBar_subBar_Vertical.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BoardToolBar_chooseColorBar_Vertical.h"
#import "BoardToolBar_chooseSizeBar_Vertical.h"

@interface BoardToolBar_subBar_Vertical : UIView

@property(nonatomic,strong)BoardToolBar_chooseSizeBar_Vertical  *sizeBar;
@property(nonatomic,strong)BoardToolBar_chooseColorBar_Vertical *colorBar;

@property(nonatomic,strong)UIColor *lineColor;
@property(nonatomic,strong)UIColor *highLightedColor;

@end

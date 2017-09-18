//
//  BoardToolBar_subBar.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BoardToolBar_chooseColorBar.h"
#import "BoardToolBar_chooseSizeBar.h"

@interface BoardToolBar_subBar : UIView

@property(nonatomic,strong)BoardToolBar_chooseSizeBar  *sizeBar;
@property(nonatomic,strong)BoardToolBar_chooseColorBar *colorBar;

@property(nonatomic,strong)UIColor *lineColor;
@property(nonatomic,strong)UIColor *highLightedColor;

@end

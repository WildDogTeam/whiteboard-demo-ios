//
//  BoardToolBar_colorItem.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardToolBar_colorItem : UIView

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)UIColor *highLightedColor;

@property(nonatomic,strong)UIColor *color;

@property(nonatomic,strong)NSString *des;

- (void)choose;

- (void)unchoose;

@end

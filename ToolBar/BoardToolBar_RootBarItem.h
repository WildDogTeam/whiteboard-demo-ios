//
//  BoardToolBar_RootBarItem.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardToolBar_RootBarItem : UIView

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)UIColor *highLightedColor;

@property(nonatomic,strong)UIImage *icon;

@property(nonatomic,strong)NSString *des;

- (void)choose;

- (void)unchoose;

@end

//
//  BoardToolBar_colorItem.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar_colorItem.h"


#define kSelfWidth   self.frame.size.width
#define kSelfHeight  self.frame.size.height
#define kScreenScaleWidthWithOriginal(x)   ((kSelfWidth<kSelfHeight?kSelfWidth:kSelfHeight)/33.5 * x)

#define kboardRootColorItemRedius        kScreenScaleWidthWithOriginal(9)
#define kboardRootColorItemColorRedius   kScreenScaleWidthWithOriginal(5)
#define kboardRootColorItemBoarderWidth  kScreenScaleWidthWithOriginal(3)

@interface BoardToolBar_colorItem ()

@property(nonatomic,strong)UIView *colorView;

@property(nonatomic,strong)UIView *highLightedView;

@end

@implementation BoardToolBar_colorItem

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.masksToBounds = NO;
    
    CGFloat hilightedViewWidth = 0;
    if(self.frame.size.width < self.frame.size.height){
        hilightedViewWidth = self.frame.size.width;
    }else{
        hilightedViewWidth = self.frame.size.height;
    }
    
    self.colorView = [[UIView alloc]initWithFrame:CGRectMake(kboardRootColorItemBoarderWidth,
                                                             kboardRootColorItemBoarderWidth,
                                                             hilightedViewWidth -
                                                             2 * kboardRootColorItemBoarderWidth,
                                                             hilightedViewWidth -
                                                             2 * kboardRootColorItemBoarderWidth)];
    self.colorView.center = CGPointMake(self.frame.size.width/2,
                                        self.frame.size.height/2);
    self.colorView.layer.cornerRadius = kboardRootColorItemColorRedius;
    
    self.highLightedView = [[UIView alloc]initWithFrame:self.colorView.frame];
    self.highLightedView.layer.cornerRadius = kboardRootColorItemRedius;
    
    [self addSubview:self.highLightedView];
    [self addSubview:self.colorView];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = self.bounds;
    [self addSubview:self.btn];
    
    [self.btn addTarget:self action:@selector(choose)
       forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)setHighLightedColor:(UIColor *)highLightedColor{
    _highLightedColor = highLightedColor;
    self.highLightedView.backgroundColor = highLightedColor;
}

-(void)setColor:(UIColor *)color{
    _color = color;
    self.colorView.backgroundColor = color;
}

-(void)choose{
    CGFloat hilightedViewWidth = 0;
    if(self.frame.size.width < self.frame.size.height){
        hilightedViewWidth = self.frame.size.width;
    }else{
        hilightedViewWidth = self.frame.size.height;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.highLightedView.frame = CGRectMake(0, 0, hilightedViewWidth, hilightedViewWidth);
        self.highLightedView.center = CGPointMake(self.frame.size.width/2,
                                                  self.frame.size.height/2);
    }];
}

-(void)unchoose{
    [UIView animateWithDuration:0.3 animations:^{
        self.highLightedView.frame = self.colorView.frame;
    }];
}

@end

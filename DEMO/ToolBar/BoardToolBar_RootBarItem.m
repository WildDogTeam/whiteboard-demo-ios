//
//  BoardToolBar_RootBarItem.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar_RootBarItem.h"

#define kSelfWidth  self.frame.size.width
#define kScreenScaleWidthWithOriginal(x)   (kSelfWidth/32 * x)

#define kboardRootBarItemRedius   kScreenScaleWidthWithOriginal(5)

@interface BoardToolBar_RootBarItem ()

@property (nonatomic,strong) UIImageView *IMGV;
@property (nonatomic,strong) UIView *highLightedView;

@end

@implementation BoardToolBar_RootBarItem

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.highLightedView = [[UIView alloc]init];
    self.highLightedView.frame = CGRectZero;
    self.highLightedView.center = CGPointMake(self.frame.size.width/2,
                                              self.frame.size.height/2);
    self.highLightedView.layer.cornerRadius = kboardRootBarItemRedius;
    [self addSubview:self.highLightedView];
    
    self.IMGV = [[UIImageView alloc]initWithFrame:self.bounds];
    self.IMGV.contentMode = UIViewContentModeScaleAspectFit;
    self.IMGV.backgroundColor = [UIColor clearColor];
    [self addSubview:self.IMGV];
    
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

-(void)setIcon:(UIImage *)icon{
    _icon = icon;
    self.IMGV.image = icon;
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
        self.highLightedView.frame = CGRectZero;
        self.highLightedView.center = CGPointMake(self.frame.size.width/2,
                                                  self.frame.size.height/2);
    }];
}
@end

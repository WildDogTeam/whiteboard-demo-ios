//
//  ViewController.m
//  WilddogBoardDemo2
//
//  Created by problemchild on 2017/8/31.
//  Copyright © 2017年 freakyyang. All rights reserved.
//

#import "ViewController.h"

#import "BoardToolBar.h"

@import WilddogBoard;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.894 alpha:1.000];
    
    //本DEMO为iPhone横屏演示
    WDGBoardOptions *option = [WDGBoardOptions defaultOptions];
    //画布尺寸
    option.canvasSize = CGSizeMake(920, 720);
    
    WDGBoard *boardView = [WDGBoard creatBoardWithAppID:@"************"
                                                   Path:@"************"
                                                 userID:@"************"
                                               opthions:option];
    
    boardView.frame = CGRectMake(55, 0,
                                 self.view.frame.size.width-55,
                                 self.view.frame.size.height);
    
    
    [self.view addSubview:boardView];
    
    BoardToolBar *toolbar = [BoardToolBar new];
    [toolbar setupWithBoard:boardView
                  direction:BoardToolBarDirectionVertical
                      theme:BoardToolThemeDark
                      frame:CGRectMake(0,0,55,self.view.frame.size.height)
     ];
    
    [self.view addSubview:toolbar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

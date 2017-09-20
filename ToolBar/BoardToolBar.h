//
//  BoardToolBar.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@import WilddogBoard;

#define QiniuAK       @"qSIHb2rWYZNiE80039Uyk7PpiaWTNwdPnRsvzmM-"
#define QiniuSK       @"3bKGdYSjVgnIATs-fOJFH9pIxx0192h-8vd28EWO"
#define QiniuRoomName @"whiteboard"
#define QiniuRoomURL  @"http://ovwpvt4dz.bkt.clouddn.com/"


@interface BoardToolBar : UIView

//显示方向
typedef NS_ENUM (NSInteger , BoardToolBarDirection){
    //水平显示
    BoardToolBarDirectionHorizontal,
    //垂直显示
    BoardToolBarDirectionVertical
};

//主题
typedef NS_ENUM (NSInteger , BoardToolTheme){
    //目前只有暗色主题
    BoardToolThemeDark
};

/**
 *  初始化
 *
 *  @param board     白板控件
 *  @param direction 显示方向，水平/垂直
 *  @param frame     frame
 */
- (void)setupWithBoard:(WDGBoard *)board
             direction:(BoardToolBarDirection)direction
                 theme:(BoardToolTheme)theme
                 frame:(CGRect)frame;



@end

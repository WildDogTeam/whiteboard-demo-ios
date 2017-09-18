# iOS WilddogBoard & ToolBar 使用指南

## 一，集成部分
### 1，集成WilddogBoard - SDK 即白板SDK
方法一：直接把WilddogBoard.framework拖入工程中

方法二：使用pod，引入源码包，在podfile中把地址引到“SDK”目录。
example：```pod 'WilddogBoard', :path => '../SDK/'```

### 2，集成ToolBar
直接把整个ToolBar文件夹拖入工程中，注意拖入过程中的选择。
 ![image](https://github.com/WildDogTeam/whiteboard-demo-ios/blob/master/DEMO/ScreenShot/屏幕快照%202017-08-31%2014.39.49.png)

### 3,集成工具栏所需依赖库
七牛云储存：

```objc
pod 'Qiniu'
```

## 二，使用部分

### 1，引入 白板SDK

```objc
@import WilddogBoard;
```
### 2，引入 工具栏

```objc
#import "BoardToolBar.h"
```

### 3，配置七牛
打开“ToolBar/BoardToolBar.h”修改如下部分
![image](https://github.com/WildDogTeam/whiteboard-demo-ios/blob/master/DEMO/ScreenShot/屏幕快照%202017-08-31%2017.48.08.png)
### 4，建立白板
```objc
WDGBoard *boardView = [WDGBoard creatBoardWithAppID:@"wd**********"
                                                Path:@"path***********"
                                                userID:@"user**********"];
    
boardView.frame = CGRectMake(0, 0,300,300);
[self.view addSubview:boardView];
```

##### 画布大小默认640*480，如果需要自定义画布大小：

```objc
WDGBoardOptions *boardOption = [WDGBoardOptions defaultOptions];
boardOption.canvasSize = CGSizeMake(1000, 1000);
WDGBoard *boardView = [WDGBoard creatBoardWithAppID:@"WDid**********"
                                                   Path:@"pat**********h"
                                                 userID:@"userid**********"
                                               opthions:boardOption];
```
- 画布大小应该和其它端应该保持统一。
- 画布大小会 以适应的方式 进行缩放，显示到白板控件中去。
- 白板更详细使用方法，可以查看framework包中WDGBoard.h和其它等公开的头文件内的说明。


### 5，建立工具栏
```objc
BoardToolBar *toolbar = [BoardToolBar new];
[toolbar setupWithBoard:boardView
                  direction:BoardToolBarDirectionVertical
                      theme:BoardToolThemeDark
                      frame:CGRectMake(0,0,55,375)];
    
[self.view addSubview:toolbar];
```

- 横向和纵向显示，在这里分别传不同的direction即可。
- 主题暂时只有暗色主题
- 排版已做自适应，可以根据根据屏幕的尺寸任意设置



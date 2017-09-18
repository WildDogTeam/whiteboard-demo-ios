//
//  BoardToolBar.m
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/29.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import "BoardToolBar.h"

#import "BoardToolBar_rootBar.h"
#import "BoardToolBar_subBar.h"
#import "BoardToolBar_rootBar_Vertical.h"
#import "BoardToolBar_subBar_Vertical.h"
#import "WDBQiNiuTokenGenerator.h"
#import "ZLPhotoActionSheet.h"

#import "QiniuSDK.h"
#import "QNResolver.h"
#import "QNDnsManager.h"
#import "QNNetworkInfo.h"

#define kSelfWidth  self.originalFrame.size.width
#define kSelfHeight self.originalFrame.size.height
#define kScreenScaleWidthWithOriginal(x)   (kSelfWidth/375 * x)
#define kScreenScaleHeightWithOriginal(x)  (kSelfHeight/55 * x)

#define kboardBarCornerRaidius   kScreenScaleWidthWithOriginal(3)
#define kboardBarSubDistance     kScreenScaleHeightWithOriginal(2)

#define kboardBarCornerRaidius_vertical   ((kSelfHeight/375) * 3)
#define kboardBarSubDistance_vertical     ((kSelfWidth/55) * 2)

#define objectSizeIndex(x) (((NSNumber *)self.objectSizeArray[x]).doubleValue)
#define textSizeIndex(x)   (((NSNumber *)self.textSizeArray[x]).doubleValue)

#define convasWidth  self.board.option.canvasSize.width
#define convasHeight self.board.option.canvasSize.height
#define imageScaleWidth  convasWidth*0.5
#define imageScaleHeight convasHeight*0.5

@interface BoardToolBar ()

@property (nonatomic,strong) WDGBoard *board;
@property (nonatomic,assign) NSInteger choosingToolIndex;

@property (nonatomic,strong) WDGBoardObject *selectingObject;
//不支持操作的元素，但是可以删除
@property (nonatomic,strong) WDGBoardObject *selectingStaticObject;

@property (nonatomic,assign) BoardToolBarDirection direction;

@property (nonatomic,strong) BoardToolBar_rootBar *RootBar;
@property (nonatomic,strong) BoardToolBar_subBar  *subBar;
@property (nonatomic,strong) BoardToolBar_rootBar_Vertical *RootBar_Vertical;
@property (nonatomic,strong) BoardToolBar_subBar_Vertical  *subBar_Vertical;

@property(nonatomic,strong)NSArray *toolItemArray;
@property(nonatomic,strong)NSArray *sizeItemArray;
@property(nonatomic,strong)NSArray *colorItemArray;

@property (nonatomic,strong) NSMutableDictionary *sizeSavedDic;
@property (nonatomic,strong) NSMutableDictionary *colorSavedDic;


@property(nonatomic,assign)CGRect originalFrame;

@property(nonatomic,strong)NSArray *objectSizeArray;
@property(nonatomic,strong)NSArray *textSizeArray;

@property BOOL fromeInternal;
@property BOOL subBarShowed;
@property BOOL selectMode;
@property BOOL prepareOpenSelectMode;
@property double imageScale;

@end

@implementation BoardToolBar

- (NSArray *)objectSizeArray{
    return @[@2,@6,@10];
}

- (NSArray *)textSizeArray{
    return @[@18,@28,@40];
}

- (void)setupWithBoard:(WDGBoard *)board
             direction:(BoardToolBarDirection)direction
                 theme:(BoardToolTheme)theme
                 frame:(CGRect)frame
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    //用来保操作记录的容器
    self.sizeSavedDic  = [NSMutableDictionary dictionary];
    self.colorSavedDic = [NSMutableDictionary dictionary];
    
    //自身设置
    self.fromeInternal = YES;
    self.frame = frame;
    self.originalFrame = frame;
    self.backgroundColor = [UIColor clearColor];
    self.direction = direction;
    self.board = board;
    [board setToolWithType:WDGBoardToolTypeDefault options:nil];
    self.selectMode = YES;
    
    //主题配色
    UIColor *BackgroundColor    = [UIColor whiteColor];
    UIColor *SubBackgroundColor = [UIColor whiteColor];
    UIColor *HighLightedColor   = [UIColor blackColor];
    UIColor *subBarLineColor    = [UIColor whiteColor];
    switch (theme) {
        case BoardToolThemeDark:
            BackgroundColor = [UIColor colorWithWhite:0.222 alpha:1.000];
            SubBackgroundColor = [UIColor colorWithWhite:0.365 alpha:1.000];
            HighLightedColor = [UIColor colorWithWhite:0.106 alpha:1.000];
            subBarLineColor = [UIColor colorWithWhite:0.600 alpha:1.000];
            break;
        default:
            break;
    }
    //方向
    switch (direction) {
        case BoardToolBarDirectionHorizontal:
        {
            self.subBar = [[BoardToolBar_subBar alloc]initWithFrame:self.bounds];
            self.subBar.layer.cornerRadius = kboardBarCornerRaidius;
            self.subBar.backgroundColor    = SubBackgroundColor;
            self.subBar.highLightedColor   = HighLightedColor;
            self.subBar.lineColor          = subBarLineColor;
            [self addSubview:self.subBar];
            
            self.RootBar = [[BoardToolBar_rootBar alloc]initWithFrame:self.bounds];
            self.RootBar.layer.cornerRadius = kboardBarCornerRaidius;
            self.RootBar.backgroundColor    = BackgroundColor;
            self.RootBar.highLightedColor   = HighLightedColor;
            [self addSubview:self.RootBar];
            
            self.toolItemArray = self.RootBar.itemArr;
            self.sizeItemArray = self.subBar.sizeBar.itemArr;
            self.colorItemArray = self.subBar.colorBar.itemArr;
        }
            break;
        case BoardToolBarDirectionVertical:
        {
            self.subBar_Vertical = [[BoardToolBar_subBar_Vertical alloc]initWithFrame:self.bounds];
            self.subBar_Vertical.layer.cornerRadius = kboardBarCornerRaidius_vertical;
            self.subBar_Vertical.backgroundColor    = SubBackgroundColor;
            self.subBar_Vertical.highLightedColor   = HighLightedColor;
            self.subBar_Vertical.lineColor          = subBarLineColor;
            [self addSubview:self.subBar_Vertical];
            
            self.RootBar_Vertical = [[BoardToolBar_rootBar_Vertical alloc]initWithFrame:self.bounds];
            self.RootBar_Vertical.layer.cornerRadius = kboardBarSubDistance_vertical;
            self.RootBar_Vertical.backgroundColor    = BackgroundColor;
            self.RootBar_Vertical.highLightedColor   = HighLightedColor;
            [self addSubview:self.RootBar_Vertical];
            
            self.toolItemArray = self.RootBar_Vertical.itemArr;
            self.sizeItemArray = self.subBar_Vertical.sizeBar.itemArr;
            self.colorItemArray = self.subBar_Vertical.colorBar.itemArr;
        }
            break;
        default:
            break;
    }
    
    //点击的时候展示自工具栏
    [self setupToolWithOpenSubToolbar];
    
    [self setupObserve];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self.fromeInternal = YES;
    self = [super initWithFrame:frame];
    return self;
}

- (void)setFrame:(CGRect)frame{
    if(self.fromeInternal){
        [super setFrame:frame];
        self.fromeInternal = NO;
    }else{
        @throw @"请使用初始化方法设置frame";
    }
}

- (void)setupToolWithOpenSubToolbar{
    //点击展开
    for (BoardToolBar_RootBarItem *item in self.toolItemArray) {
        [item.btn addTarget:self action:@selector(choosedTool:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (BoardToolBar_RootBarItem *item in self.sizeItemArray) {
        [item.btn addTarget:self action:@selector(choosedSize:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (BoardToolBar_colorItem *item in self.colorItemArray) {
        [item.btn addTarget:self action:@selector(choosedColor:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//展开子工具栏
- (void)showSubBar{
    if(!self.subBarShowed){
        self.subBarShowed = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.fromeInternal = YES;
            switch (self.direction) {
                case BoardToolBarDirectionHorizontal:
                {
                    self.RootBar.frame = CGRectMake(0,
                                                    self.RootBar.frame.size.height + kboardBarSubDistance,
                                                    self.RootBar.frame.size.width,
                                                    self.RootBar.frame.size.height);
                    self.frame = CGRectMake(self.frame.origin.x,
                                            self.frame.origin.y - self.RootBar.frame.size.height - kboardBarSubDistance,
                                            self.frame.size.width,
                                            self.RootBar.frame.size.height * 2 + kboardBarSubDistance);
                }
                    break;
                case BoardToolBarDirectionVertical:
                {
                    self.subBar_Vertical.frame = CGRectMake(self.RootBar_Vertical.frame.size.width + kboardBarSubDistance_vertical,
                                                            0,
                                                            self.RootBar_Vertical.frame.size.width,
                                                            self.RootBar_Vertical.frame.size.height);
                    self.frame = CGRectMake(self.frame.origin.x,
                                            self.frame.origin.y,
                                            self.frame.size.width * 2 + kboardBarSubDistance_vertical,
                                            self.frame.size.height);
                }
                    break;
                default:
                    break;
            }
            
        }];
    }
}

//收起
- (void)closeSubBar{
    if(self.subBarShowed){
        self.subBarShowed = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.fromeInternal = YES;
            switch (self.direction) {
                case BoardToolBarDirectionHorizontal:
                {
                    self.RootBar.frame = CGRectMake(0,0,
                                                    self.RootBar.frame.size.width,
                                                    self.RootBar.frame.size.height);
                    self.frame = CGRectMake(self.frame.origin.x,
                                            self.frame.origin.y + kboardBarSubDistance + self.RootBar.frame.size.height,
                                            self.frame.size.width,
                                            self.RootBar.frame.size.height);
                }
                    break;
                case BoardToolBarDirectionVertical:
                {
                    self.subBar_Vertical.frame = CGRectMake(0,0,
                                                            self.subBar_Vertical.frame.size.width,
                                                            self.subBar_Vertical.frame.size.height);
                    self.frame = CGRectMake(self.frame.origin.x,
                                            self.frame.origin.y,
                                            self.RootBar_Vertical.frame.size.width,
                                            self.RootBar_Vertical.frame.size.height);
                }
                    break;
                default:
                    break;
            }
        }];
    }
}


//进入选择模式
- (void)inchooseModeAndCloseSubBar:(BOOL)closeSubBar{
    if(closeSubBar){
        [self closeSubBar];
    }
    self.selectMode = YES;
    [self.board setToolWithType:WDGBoardToolTypeDefault options:nil];
    [((BoardToolBar_RootBarItem *)self.toolItemArray[self.choosingToolIndex]) unchoose];
    for (BoardToolBar_RootBarItem *item in self.sizeItemArray) {
        [item unchoose];
    }
    for (BoardToolBar_colorItem *item in self.colorItemArray) {
        [item unchoose];
    }
}

//退出选择模式
- (void)exitchooseMode{
    [self showSubBar];
    self.selectMode = NO;
    self.selectingObject = nil;
}

- (void)changeSizeItemForText{
    ((BoardToolBar_RootBarItem *)self.sizeItemArray[0]).icon = [UIImage imageNamed:@"boardTool_small-A.png"];
    ((BoardToolBar_RootBarItem *)self.sizeItemArray[1]).icon = [UIImage imageNamed:@"boardTool_mid-A.png"];
    ((BoardToolBar_RootBarItem *)self.sizeItemArray[2]).icon = [UIImage imageNamed:@"boardTool_big-A.png"];
}

- (void)changeSizeItemForObject{
    ((BoardToolBar_RootBarItem *)self.sizeItemArray[0]).icon = [UIImage imageNamed:@"boardTool_small-circle.png"];
    ((BoardToolBar_RootBarItem *)self.sizeItemArray[1]).icon = [UIImage imageNamed:@"boardTool_mid-circle.png"];
    ((BoardToolBar_RootBarItem *)self.sizeItemArray[2]).icon = [UIImage imageNamed:@"boardTool_big-circle.png"];
}

//选择了工具
- (void)choosedTool:(UIButton *)btn{
    //当前选中的item
    int choosingIndex = 0;
    for (int i = 0 ; i < self.toolItemArray.count ; i++) {
        BoardToolBar_RootBarItem *item = self.toolItemArray[i];
        if(item.btn == btn) choosingIndex = i;
    }
    
    //选中的如果不是最后两个工具
    if(choosingIndex < 6 && choosingIndex != 4){
        if(!self.selectMode &&
           !self.fromeInternal &&
           self.choosingToolIndex == choosingIndex){
            [self inchooseModeAndCloseSubBar:YES];
        }else{
            //文字的时候换图标
            if(choosingIndex == 5){
                [self changeSizeItemForText];
            }else{
                [self changeSizeItemForObject];
            }
            
            [self exitchooseMode];
            self.choosingToolIndex = choosingIndex;
            //读取历史记录
            int sizeIndex  = 1;
            int colorIndex = 0;
            UIColor *chooingColor = [UIColor whiteColor];
            if (self.sizeSavedDic[[NSNumber numberWithInteger:self.choosingToolIndex]]){
                NSNumber *choosedSize = self.sizeSavedDic[[NSNumber numberWithInteger:self.choosingToolIndex]];
                sizeIndex = choosedSize.intValue;
            }
            if (self.colorSavedDic[[NSNumber numberWithInteger:self.choosingToolIndex]]){
                NSNumber *choosedColor = self.colorSavedDic[[NSNumber numberWithInteger:self.choosingToolIndex]];
                colorIndex = choosedColor.intValue;
            }
            //恢复选中上一次的选中记录
            for (int i=0; i<self.sizeItemArray.count; i++) {
                BoardToolBar_RootBarItem *item = self.sizeItemArray[i];
                if(i == sizeIndex){
                    [item choose];
                }else{
                    [item unchoose];
                }
            }
            for (int i=0; i<self.colorItemArray.count; i++) {
                BoardToolBar_colorItem *item = self.colorItemArray[i];
                if(i == colorIndex){
                    [item choose];
                    chooingColor = item.color;
                }else{
                    [item unchoose];
                }
            }
            //调Board - API
            switch (choosingIndex) {
                case 0:
                {
                    [self.board setToolWithType:WDGBoardToolTypePen
                                        options:[WDGBoardToolOptions optionWithColor:chooingColor
                                                                                size:objectSizeIndex(sizeIndex)]];
                }
                    break;
                case 1:
                {
                    [self.board setToolWithType:WDGBoardToolTypeLine
                                        options:[WDGBoardToolOptions optionWithColor:chooingColor
                                                                                size:objectSizeIndex(sizeIndex)]];
                }
                    break;
                case 2:
                {
                    [self.board setToolWithType:WDGBoardToolTypeEmptyRect
                                        options:[WDGBoardToolOptions optionWithColor:chooingColor
                                                                                size:objectSizeIndex(sizeIndex)]];
                }
                    break;
                case 3:
                {
                    [self.board setToolWithType:WDGBoardToolTypeEmptyCricle
                                        options:[WDGBoardToolOptions optionWithColor:chooingColor
                                                                                size:objectSizeIndex(sizeIndex)]];
                }
                    break;
                case 5:
                {
                    [self.board setToolWithType:WDGBoardToolTypeText
                                        options:[WDGBoardToolOptions optionWithColor:chooingColor
                                                                                size:textSizeIndex(sizeIndex)]];
                    self.prepareOpenSelectMode = YES;
                }
                    break;
                default:
                    break;
            }
        }
    }else{
        //选中的是最后两个工具,或图片,调API
        switch (choosingIndex) {
            case 6:
            {
                [self.board undo];
            }
                break;
            case 7:
            {
                if(self.selectingObject){
                    [self.board removeObjectWithObject:self.selectingObject];
                    self.selectingObject = nil;
                }else if(self.selectingStaticObject){
                    [self.board removeObjectWithObject:self.selectingStaticObject];
                    self.selectingStaticObject = nil;
                }else{
                    //取父级VC
                    id target=self;
                    while (target) {
                        target = ((UIResponder *)target).nextResponder;
                        if ([target isKindOfClass:[UIViewController class]]) {
                            break;
                        }
                    }
                    UIViewController *VC = target;
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清空当前页"
                                                                                             message:@"确定清空当前页吗"
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                                        style:UIAlertActionStyleCancel
                                                                      handler:nil]];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"清空"
                                                                        style:UIAlertActionStyleDestructive
                                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                                          [self.board clearPage];
                                                                      }]];
                    [VC presentViewController:alertController animated:YES completion:nil];
                }
            }
                break;
            case 4:
            {
                //取父级VC
                id target=self;
                while (target) {
                    target = ((UIResponder *)target).nextResponder;
                    if ([target isKindOfClass:[UIViewController class]]) {
                        break;
                    }
                }
                UIViewController *VC = target;
                [VC.navigationController popViewControllerAnimated:YES];
                
                ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
                actionSheet.allowSelectVideo        = NO;
                actionSheet.allowTakePhotoInLibrary = NO;
                actionSheet.maxSelectCount = 1;
                actionSheet.sender = VC;
                [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images,
                                                   NSArray<PHAsset *> * _Nonnull assets,
                                                   BOOL isOriginal)
                {
                    [self uploadImage:(UIImage *)images.firstObject];
                }];
                [actionSheet showPhotoLibrary];
                
                [self inchooseModeAndCloseSubBar:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (void)choosedSize:(UIButton *)btn{
    //记录操作
    int index = 0;
    for (int i = 0 ; i < self.sizeItemArray.count ; i++) {
        BoardToolBar_RootBarItem *item = self.sizeItemArray[i];
        if(item.btn == btn) index = i;
    }
    [self.sizeSavedDic setObject:[NSNumber numberWithInt:index]
                          forKey:[NSNumber numberWithInteger:self.choosingToolIndex]];
    if(!self.selectingObject){
        //重新触发一次设置工具
        self.fromeInternal = YES;
        [self choosedTool:((BoardToolBar_RootBarItem *)self.toolItemArray[self.choosingToolIndex]).btn];
        self.fromeInternal = NO;
    }else{
        switch (self.selectingObject.ObjectType) {
            case WDGBoardObjectTypePen:
            case WDGBoardObjectTypeLine:
                self.selectingObject.size = objectSizeIndex(index);
                break;
            case WDGBoardObjectTypeText:
                [self.selectingObject setPropertyWithDictionary:@{@"fontSize":[NSNumber numberWithFloat:textSizeIndex(index)],
                                                                  @"scaleX":@1,
                                                                  @"scaleY":@1}];
                break;
            case WDGBoardObjectTypeRect:
            case WDGBoardObjectTypeCricle:
            {
                [self.selectingObject setPropertyWithDictionary:@{@"strokeWidth":[NSNumber numberWithFloat:objectSizeIndex(index)]}];
            }
                break;
            default:
                break;
        }
    }
}

- (void)choosedColor:(UIButton *)btn{
    //记录操作
    int index = 0;
    for (int i = 0 ; i < self.colorItemArray.count ; i++) {
        BoardToolBar_colorItem *item = self.colorItemArray[i];
        if(item.btn == btn) index = i;
    }
    [self.colorSavedDic setObject:[NSNumber numberWithInt:index]
                           forKey:[NSNumber numberWithInteger:self.choosingToolIndex]];
    if(!self.selectingObject){
        //重新触发一次设置工具
        self.fromeInternal = YES;
        [self choosedTool:((BoardToolBar_RootBarItem *)self.toolItemArray[self.choosingToolIndex]).btn];
        self.fromeInternal = NO;
    }else{
        if(self.selectingObject.ObjectType == WDGBoardObjectTypeText){
            [self.selectingObject setPropertyWithDictionary:@{@"fill":[self UIColorToString:((BoardToolBar_colorItem *)self.colorItemArray[index]).color]}];
        }else{
            [self.selectingObject setPropertyWithDictionary:@{@"stroke":[self UIColorToString:((BoardToolBar_colorItem *)self.colorItemArray[index]).color]}];
        }
    }
}

- (void)setupObserve{
    [self.board ObserveObjectSeletedWithBlock:^(WDGBoardObject *object, NSDictionary *allProperty) {
        if(self.prepareOpenSelectMode &&
           object.ObjectType == WDGBoardObjectTypeText &&
           [self.board.userID isEqualToString:object.userID])
        {
            [self inchooseModeAndCloseSubBar:NO];
        }
        if(object.ObjectType == WDGBoardObjectTypePen ||
           object.ObjectType == WDGBoardObjectTypeLine ||
           object.ObjectType == WDGBoardObjectTypeRect ||
           object.ObjectType == WDGBoardObjectTypeCricle ||
           object.ObjectType == WDGBoardObjectTypeText){
            self.selectingObject = object;
            UIColor *objectColor = object.color;
            if([(NSString *)allProperty[@"fill"] isEqualToString:@"rgba(0,0,0,0)"] ||
               [(NSString *)allProperty[@"fill"] isEqualToString:@"rgb(0,0,0)"] ||
               [(NSString *)allProperty[@"fill"] isEqualToString:@""]){
                NSString *colorStr = allProperty[@"stroke"];
                if(colorStr.length>0)objectColor = [self JSColorToUIColor:colorStr];
            }
            for (BoardToolBar_colorItem *item in self.colorItemArray) {
                if([self AlmostSameColor:item.color Color:objectColor]){
                    [item choose];
                }else{
                    [item unchoose];
                }
            }
            NSArray *sizeArray = self.objectSizeArray;
            if(object.ObjectType == WDGBoardObjectTypeText){
                sizeArray = self.textSizeArray;
            }
            if([sizeArray containsObject:[NSNumber numberWithDouble:object.size]])
            {
                BoardToolBar_RootBarItem *choosedSiezItem = self.sizeItemArray[[sizeArray indexOfObject:[NSNumber numberWithDouble:object.size]]];
                for (BoardToolBar_RootBarItem *item in self.sizeItemArray) {
                    if(item == choosedSiezItem){
                        [item choose];
                    }else{
                        [item unchoose];
                    }
                }
            }else{
                for (BoardToolBar_RootBarItem *item in self.sizeItemArray) {
                    [item unchoose];
                }
            }
            [self showSubBar];
            if(object.ObjectType == WDGBoardObjectTypeText){
                [self changeSizeItemForText];
            }else{
                [self changeSizeItemForObject];
            }
        }else{
            [self closeSubBar];
            [self changeSizeItemForObject];
        }
        if(object.ObjectType == WDGBoardObjectTypeImage){
            self.selectingStaticObject = object;
        }
    }];
    [self.board ObserveObjectDeseletedWithBlock:^(WDGBoardObject *object, NSDictionary *allProperty) {
        if(self.selectMode){
            self.selectingObject = nil;
            [self closeSubBar];
        }
    }];
}

//上传图片并生成图片元素显示到界面上
- (void)uploadImage:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *filename = [NSString stringWithFormat:@"image%d.png",(int)[[NSDate date] timeIntervalSince1970]];
    NSString *token = [WDBQiNiuTokenGenerator getTokenWithFileName:filename
                                                          roomName:QiniuRoomName
                                                         SecretKey:QiniuSK
                                                         AccessKey:QiniuAK];
    NSLog(@"%@",token);
    QNConfiguration *config =[QNConfiguration build:^(QNConfigurationBuilder *builder) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:[QNResolver systemResolver]];
        QNDnsManager *dns = [[QNDnsManager alloc] init:array networkInfo:[QNNetworkInfo normal]];
        //是否选择  https  上传
        builder.zone = [[QNAutoZone alloc] initWithHttps:YES dns:dns];
        //设置断点续传
        NSError *error;
        builder.recorder =  [QNFileRecorder fileRecorderWithFolder:@"temptest" error:&error];
    }];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    [upManager putData:imageData
                   key:filename
                 token:token
              complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
     {
         if(info.ok)
         {
             NSLog(@"图片上传成功");
             NSString *imageURL = [NSString stringWithFormat:@"%@%@",QiniuRoomURL,filename];
             WDGBoardObject *object = [self.board creatImageObjectWithURL:imageURL];
             
             //缩放
             double widthscale = 1;
             double heightscale = 1;
             if(image.size.width > imageScaleWidth){
                 widthscale = imageScaleWidth / image.size.width;
             }
             if(image.size.height > imageScaleHeight){
                 heightscale = imageScaleHeight / image.size.height;
             }
             self.imageScale = widthscale < heightscale ? widthscale : heightscale;
             [object setPropertyWithDictionary:@{@"scaleX":[NSNumber numberWithDouble:self.imageScale],
                                                 @"scaleY":[NSNumber numberWithDouble:self.imageScale]}];
             
             object.top  = convasHeight/2 - image.size.height*self.imageScale*0.5;
             object.left = convasWidth/2  - image.size.width*self.imageScale*0.5;
             
             //显示
             [self.board addObject:object];
         }
         else{
             NSLog(@"图片上传失败");
             NSLog(@"info ===== %@", info);
             NSLog(@"resp ===== %@", resp);
         }
     } option:nil];
}

#pragma mark ---aboutColorFormat
- (UIColor *)JSColorToUIColor:(NSString *)JSColorStr{
    NSString *frontStr = [JSColorStr substringWithRange:NSMakeRange(0, 4)];
    if([frontStr isEqualToString:@"rgba"]){
        NSString *midStr = [JSColorStr substringWithRange:NSMakeRange(5, JSColorStr.length-6)];
        NSArray *colorArr = [midStr componentsSeparatedByString:@","];
        double red   = ((NSString *)colorArr[0]).doubleValue / 255;
        double green = ((NSString *)colorArr[1]).doubleValue / 255;
        double blue  = ((NSString *)colorArr[2]).doubleValue / 255;
        double alpha = ((NSString *)colorArr[3]).doubleValue;
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }else if([frontStr isEqualToString:@"rgb("]){
        NSString *midStr = [JSColorStr substringWithRange:NSMakeRange(4, JSColorStr.length-5)];
        NSArray *colorArr = [midStr componentsSeparatedByString:@","];
        double red   = ((NSString *)colorArr[0]).doubleValue / 255;
        double green = ((NSString *)colorArr[1]).doubleValue / 255;
        double blue  = ((NSString *)colorArr[2]).doubleValue / 255;
        return [UIColor colorWithRed:red green:green blue:blue alpha:1];
    }else{
        return [UIColor blackColor];
    }
}

- (NSString *)UIColorToString:(UIColor *)UIcolor{
    NSMutableArray *arr = [self getRGBAOfColor:UIcolor];
    return [NSString stringWithFormat:@"rgba(%d,%d,%d,%f)",
            ((NSNumber *)arr[0]).intValue,
            ((NSNumber *)arr[1]).intValue,
            ((NSNumber *)arr[2]).intValue,
            ((NSNumber *)arr[3]).doubleValue];
}

- (BOOL)AlmostSameColor:(UIColor *)color1 Color:(UIColor *)color2{
    NSMutableArray *rgba1 = [self getRGBAOfColor:color1];
    NSMutableArray *rgba2 = [self getRGBAOfColor:color2];
    for (int i = 0; i < rgba1.count; i++) {
        NSNumber *number1 = rgba1[i];
        NSNumber *number2 = rgba2[i];
        if(number1.doubleValue-number2.doubleValue > 1||
           number1.doubleValue-number2.doubleValue < -1){
            return NO;
        }
    }
    return YES;
}
- (NSMutableArray *)getRGBAOfColor:(UIColor *)color{
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    int r,g,b;
    double a;
    if(RGBArr.count == 5){
        //获取红色值
        r = [[RGBArr objectAtIndex:1] doubleValue] * 255;
        //获取绿色值
        g = [[RGBArr objectAtIndex:2] doubleValue] * 255;
        //获取蓝色值
        b = [[RGBArr objectAtIndex:3] doubleValue] * 255;
        //获取透明度
        a = [[RGBArr objectAtIndex:4] doubleValue];
    }else{
        double gray = [[RGBArr objectAtIndex:1] doubleValue];
        a           = [[RGBArr objectAtIndex:2] doubleValue];
        r = 255 * gray;
        g = 255 * gray;
        b = 255 * gray;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[NSNumber numberWithInt:r]];
    [array addObject:[NSNumber numberWithInt:g]];
    [array addObject:[NSNumber numberWithInt:b]];
    [array addObject:[NSNumber numberWithDouble:a]];
    return array;
}

@end

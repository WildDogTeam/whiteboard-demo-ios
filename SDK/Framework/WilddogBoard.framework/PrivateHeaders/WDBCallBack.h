//
//  WDBCallBack.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/18.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#define kWDBObserveType_ObjectAdded    @"objectAdded"
#define kWDBObserveType_ObjectRemoved  @"objectRemoved"
#define kWDBObserveType_ObjectModified @"objectModified"
#define kWDBObserveType_ObjectSelected @"objectSelected"
#define kWDBObserveType_ObjectDeselected @"objectDeselected"
#define kWDBObserveType_FinishLoaded   @"boardInited"

#define kWDBObserveType_BoardZoomed    @"BoardZoomed"



#import <Foundation/Foundation.h>

@interface WDBCallBack : NSObject

typedef void (^CallBackBlock) (NSDictionary *message);

@property (nonatomic,copy  ) CallBackBlock block;

@property (nonatomic,strong) NSString *JSTypeDes;

@property (nonatomic,strong) NSString *OCCheckType;

@end

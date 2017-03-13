//
//  NestDataVC.h
//  XmlToOriginalo
//
//  嵌套数据列表控制器
//
//  Created by 高赛 on 2017/3/13.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^block)(NSString *name);

@interface NestDataVC : UIViewController

@property (nonatomic, copy) block myBlock;
/**
 是否单选  0单选  1多选
 */
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, copy) NSString *nameTitle;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

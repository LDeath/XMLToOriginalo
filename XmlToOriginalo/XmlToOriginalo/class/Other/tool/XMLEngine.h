//
//  XMLEngine.h
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/10.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLEngine : NSObject

@property (nonatomic, strong) NSMutableArray *dataArr;
/**
 单例方法
 */
+ (XMLEngine *)shareXMLEngine;
/**
 入口方法
 根据传进来的文件名称开始解析
 */
- (void)analysisXMLFile:(NSString *)name;

@end

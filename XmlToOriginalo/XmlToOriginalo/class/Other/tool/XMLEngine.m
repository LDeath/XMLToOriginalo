//
//  XMLEngine.m
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/10.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "XMLEngine.h"
#import "XMLReader.h"
#import "FormControlModel.h"
#import "MJExtension.h"

@implementation XMLEngine

static XMLEngine *engine;
+ (XMLEngine *)shareXMLEngine {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [[XMLEngine alloc] init];
    });
    return engine;
}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

/**
 入口方法
 根据传进来的文件名称开始解析
 */
- (void)analysisXMLFile:(NSString *)name {
    [self analysisXMLFileOfBasicInfo:name];
}
- (void)analysisXMLFileOfBasicInfo:(NSString *)name {
    NSString *xmlName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlName];
    NSError *error = nil;
    NSDictionary *xmldic = [XMLReader dictionaryForXMLData:xmlData error:&error];
    
    
    id formList = [[xmldic valueForKey:@"FormTest"] valueForKey:@"formList"];
    
    // 判断formList是数组还是字典/判断formList是多个表单还是单一表单
    if ([formList isKindOfClass:[NSArray class]]) { // formList是数组时/formList是多个表单时
        NSArray *formListArr = formList;
        for (int i = 0 ; i < formListArr.count; i++) {
            // 判断每个表单中的控件是数组还是字典/判断每个表单中的控件是多个控件还是单一控件
            NSDictionary *dic = formListArr[i];
            id data = dic[@"formControl"];
            if ([data isKindOfClass:[NSArray class]]) { // 表单中控件为数组时/表单中控件为多个时
                NSArray *dataArr = [FormControlModel mj_objectArrayWithKeyValuesArray:dic[@"formControl"]];
                [self.dataArr addObject:dataArr];
            } else if ([data isKindOfClass:[NSDictionary class]]) { // 表单中控件为字典时/表单中控件为一个时
                FormControlModel *model = [FormControlModel mj_objectWithKeyValues:data];
                NSArray *modelArr = [NSArray arrayWithObject:model];
                [self.dataArr addObject:modelArr];
            }
        }
    } else if ([formList isKindOfClass:[NSDictionary class]]) { // formList是字典时/formList是单一表单时
        NSMutableDictionary *formListDic = formList;
        NSArray *dataArr = [FormControlModel mj_objectArrayWithKeyValuesArray:formListDic[@"formControl"]];
        self.dataArr = [NSMutableArray arrayWithArray:dataArr];
    }
}



#pragma mark - 清除所有特殊字符

-(id)clearAllChar:(NSString*)str{
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return str;
}

@end



























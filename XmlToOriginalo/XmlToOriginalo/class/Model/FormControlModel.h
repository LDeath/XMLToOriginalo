//
//  FormControlModel.h
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/10.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import <Foundation/Foundation.h>

// 控件嵌套控件Model
@interface FormControlFormModel : NSObject

@property (nonatomic, strong) NSMutableArray *formControl;

@end

// 控件嵌套数据Model
@interface FormControlCateModel : NSObject

@property (nonatomic, copy) NSString *formControlCateName;

@property (nonatomic, assign) BOOL isSelect;

@end

// 控件Model
@interface FormControlModel : NSObject
/**
 控件类型<!-- 1.Label 2.单选框 3.复选框 4.输入框 5.按钮 6.时间选择框 7.输入文本label 9.嵌套html 10.描述label -->
 */
@property (nonatomic, copy) NSString *formControlType;
/**
 控件ID
 */
@property (nonatomic, copy) NSString *formControlId;
/**
 控件名称
 */
@property (nonatomic, copy) NSString *formControlName;
/**
 控件Key
 */
@property (nonatomic, copy) NSString *formControlKey;
/**
 控件信息
 */
@property (nonatomic, copy) NSString *formControlInfo;
/**
 控件嵌套数据(数组/嵌套多个数据)
 */
@property (nonatomic, strong) NSMutableArray *formControlData;
/**
 控件嵌套数据(单个/嵌套一个数据)
 */
@property (nonatomic, copy) NSString *formControlCateName;
/**
 控件提交地址
 */
@property (nonatomic, copy) NSString *formControlSubmitUrl;
/**
 嵌套控件(数组/嵌套多个控件)
 */
@property (nonatomic, strong) FormControlFormModel *formControlForm;
/**
 嵌套控件(字典/嵌套一个控件)
 */
@property (nonatomic, strong) FormControlModel *formControl;

@end

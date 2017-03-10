//
//  FormControlModel.m
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/10.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "FormControlModel.h"
#import "MJExtension.h"

@implementation FormControlFormModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"formControl" : @"FormControlModel"
             };
}

@end

@implementation FormControlCateModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"formControlCateName" : @"formControlCateName.text"};
}

@end

@implementation FormControlModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"formControlType" : @"formControlType.text",
             @"formControlId" : @"formControlId.text",
             @"formControlName" : @"formControlName.text",
             @"formControlKey" : @"formControlKey.text",
             @"formControlInfo" : @"formControlInfo.text",
             @"formControlSubmitUrl" : @"formControlSubmitUrl.text",
             @"formControlData" : @"formControlData.formControlCate",
             @"formControlCateName" : @"formControlData.formControlCate.formControlCateName.text",
             @"formControl" : @"formControlForm.formControl"
             };
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"formControlData" : @"FormControlCateModel"};
}


@end

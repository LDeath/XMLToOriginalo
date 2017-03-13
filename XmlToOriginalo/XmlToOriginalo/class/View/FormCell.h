//
//  FormCell.h
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/10.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormControlModel.h"
@class FormCell;

typedef NS_ENUM(NSInteger, FormType) {
    TypeLabel = 1,      // label
    TypeSingleSelect,   // 单选框
    TypeMoreSelect,     // 复选框
    TypeInput,          // 输入框
    TypeButton,         // 按钮
    TypeDate,           // 时间选择
    TypeTextLabel,      // 输入文本label
    Type,               // 未知
    TypeNestHtml,       // 嵌套h5
    TypeTitleLabel      // 描述label(标题label)
};
extern NSString * NSStringFromTransactionState(FormType state);

@protocol FormCellDelegate <NSObject>

- (void)clickCommitBtnWithCell:(FormCell *)cell;

@end

@interface FormCell : UITableViewCell

@property (nonatomic, assign) id<FormCellDelegate> delegate;

@property (nonatomic, strong) FormControlModel *model;

+ (instancetype)FormCellTableView:(UITableView *)tableView withType:(NSString *)type;

@end

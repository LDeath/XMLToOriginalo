//
//  NestDataCell.h
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/13.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormControlModel.h"

@interface NestDataCell : UITableViewCell

/**
 是否单选  0单选  1多选
 */
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, strong) FormControlCateModel *model;

+ (instancetype)nestDataCellTableView:(UITableView *)tableView withIdentifier:(NSString *)indentifier;

@end

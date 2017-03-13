//
//  FormVC.m
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/10.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "FormVC.h"
#import "XMLEngine.h"
#import "FormControlModel.h"
#import "FormCell.h"
#import "NestDataVC.h"
#import "Masonry.h"

#define CQFY_CONFIG @"CQFYTest.xml"
#define Form_CONFIG @"formTest.xml"

typedef void (^DateBlock)(NSDate *date);

@interface FormVC ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, FormCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIView *dateView;

@property (nonatomic, copy) DateBlock dateBlock;

@end

@implementation FormVC

#pragma 懒加载
- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        if (self.controlArr == nil) {
            XMLEngine *xmlEngine = [XMLEngine shareXMLEngine];
            [xmlEngine analysisXMLFile:CQFY_CONFIG];
            _dataArr = [NSMutableArray arrayWithArray:xmlEngine.dataArr];
        } else {
            _dataArr = [NSMutableArray arrayWithArray:self.controlArr];
        }
    }
    return _dataArr;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.date = [NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.backgroundColor = [UIColor whiteColor];
    }
    return _datePicker;
}
- (UIView *)dateView {
    if (_dateView == nil) {
        _dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _dateView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [_dateView addSubview:self.datePicker];
        [self.view addSubview:_dateView];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [_dateView addSubview:view];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        [view addSubview:lineView];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureDate) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_dateView addSubview:sureBtn];

        UIButton *hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [hiddenBtn setTitle:@"取消" forState:UIControlStateNormal];
        [hiddenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [hiddenBtn addTarget:self action:@selector(hiddenDateView) forControlEvents:UIControlEventTouchUpInside];
        hiddenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_dateView addSubview:hiddenBtn];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(hiddenDateView) forControlEvents:UIControlEventTouchUpInside];
        [_dateView addSubview:btn];
        [self setDateViewLayoutWithView:view andLineView:lineView andSureBtn:sureBtn andHiddenBtn:hiddenBtn andBtn:btn];
    }
    return _dateView;
}
#pragma 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
}
#pragma 自定义方法
- (void)sureDate {
    self.dateBlock(self.datePicker.date);
    self.dateView.hidden = YES;
}
- (void)hiddenDateView {
    self.dateView.hidden = YES;
}
#pragma FormCellDelegate
- (void)clickCommitBtnWithCell:(FormCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否提交%@",indexPath] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
#pragma tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FormControlModel *model = self.dataArr[indexPath.section][indexPath.row];
    FormCell *cell = [FormCell FormCellTableView:tableView withType:model.formControlType];
    cell.model = model;
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FormControlModel *model = self.dataArr[indexPath.section][indexPath.row];
    switch ([model.formControlType intValue]) {
        case TypeLabel: {
            break;}
        case TypeSingleSelect: {
            [self jumpSelectVCWithIsSelect:false withModel:model];
            break;}
        case TypeMoreSelect: {
            [self jumpSelectVCWithIsSelect:true withModel:model];
            break;}
        case TypeInput: {
            break;}
        case TypeButton: {
            break;}
        case TypeDate: {
            self.dateView.hidden = NO;
            __weak typeof(self) weakSelf = self;
            __weak typeof(model) weakModel = model;
            self.dateBlock = ^(NSDate *date) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSString *dateStr = [formatter stringFromDate:date];
                weakModel.formControlInfo = dateStr;
                [weakSelf.tableView reloadData];
            };
            break;}
        case TypeTextLabel: {
            break;}
        case Type: {
            break;}
        case TypeNestHtml: {
            FormVC *viewC = [[FormVC alloc] init];
            if (model.formControl) {
                viewC.controlArr = [NSMutableArray arrayWithArray:[NSMutableArray arrayWithObject:[NSMutableArray arrayWithObject:model.formControl]]];
            } else {
                viewC.controlArr = [NSMutableArray arrayWithArray:[NSMutableArray arrayWithObject:model.formControlForm.formControl]];
            }
            [self.navigationController pushViewController:viewC animated:YES];
            break;}
        case TypeTitleLabel: {
            break;}
        default:
            break;
    }
}
#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}
#pragma 工具方法
/**
 跳转选择页面
 @param isSelect 是否为多选 0单选 1多选
 */
- (void)jumpSelectVCWithIsSelect:(BOOL)isSelect withModel:(FormControlModel *)model {
    NestDataVC *nestDataVC = [[NestDataVC alloc] init];
    nestDataVC.dataArr = model.formControlData;
    nestDataVC.nameTitle = model.formControlName;
    nestDataVC.isSingle = isSelect;
    __weak typeof(self) weakSelf = self;
    __weak typeof(model) weakModel = model;
    nestDataVC.myBlock = ^(NSString *name){
        weakModel.formControlInfo = name;
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:nestDataVC animated:YES];
}
/**
 布局时间选择控件视图

 @param view 按钮条view
 @param lineView 按钮条上的线
 @param sureBtn 确定按钮
 @param hiddenBtn 隐藏按钮
 @param btn 空白区域隐藏按钮
 */
- (void)setDateViewLayoutWithView:(UIView *)view andLineView:(UIView *)lineView andSureBtn:(UIButton *)sureBtn andHiddenBtn:(UIButton *)hiddenBtn andBtn:(UIButton *)btn {
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dateView);
        make.right.equalTo(_dateView);
        make.bottom.equalTo(_dateView);
        make.height.equalTo(@230);
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dateView);
        make.right.equalTo(_dateView);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.datePicker.mas_top);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(view);
        make.right.equalTo(view);
        make.bottom.equalTo(view);
    }];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.bottom.equalTo(view.mas_bottom);
        make.right.equalTo(view.mas_right);
    }];
    [hiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.bottom.equalTo(view.mas_bottom);
        make.left.equalTo(view.mas_left);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateView);
        make.right.equalTo(_dateView);
        make.left.equalTo(_dateView);
        make.bottom.equalTo(view.mas_top);
    }];
}
/**
 判断当前类型是否为标题
 */
- (BOOL)isType:(NSInteger)index {
    
    NSArray *arr = self.dataArr[index];
    FormControlModel *model = arr.firstObject;
    if ([model.formControlType isEqualToString:@"10"]) {
        return YES;
    } else {
        return NO;
    }
}
#pragma 系统方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *arr = self.dataArr[section];
//        if ([self isType:section]) {
//            return arr.count - 1;
//        } else {
//            return arr.count;
//        }
//    return arr.count;
//}
//- (UITableFormCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    FormControlModel *model = self.dataArr[indexPath.section][indexPath.row];
//        if ([self isType:indexPath.section]) {
//            model = self.dataArr[indexPath.section][indexPath.row + 1];
//        } else {
//            model = self.dataArr[indexPath.section][indexPath.row];
//        }
//    FormCell *cell = [FormCell FormCellTableView:tableView withType:model.formControlType];
//    cell.model = model;
//    return cell;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] init];
//    if ([self isType:section]) {
//        FormControlModel *model = self.dataArr[section][0];
//        view.backgroundColor = [UIColor grayColor];
//
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
//        label.text = model.formControlName;
//        label.font = [UIFont systemFontOfSize:16];
//        label.textColor = [UIColor blackColor];
//        [view addSubview:label];
//    } else {
//
//    }
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if ([self isType:section]) {
//        return 30;
//    } else {
//        return 0;
//    }
//}

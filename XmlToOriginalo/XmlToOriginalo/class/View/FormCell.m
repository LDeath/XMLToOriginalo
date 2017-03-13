//
//  FormCell.m
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/10.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "FormCell.h"
#import "Masonry.h"

@interface FormCell ()
/**
 cell的类型
 */
@property (nonatomic, assign) FormType formType;
/**
 左边标题label
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 右边内容label
 */
@property (nonatomic, strong) UILabel *contentLabel;
/**
 右边输入框textField
 */
@property (nonatomic, strong) UITextField *inputText;
/**
 右边箭头ImgV
 */
@property (nonatomic, strong) UIImageView *arrowsImgV;
/**
 提交按钮
 */
@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation FormCell

NSString * NSStringFromTransactionState(FormType state) {
    switch (state) {
        case TypeLabel:
            return @"TypeLabel";
        case TypeSingleSelect:
            return @"TypeSingleSelect";
        case TypeMoreSelect:
            return @"TypeMoreSelect";
        case TypeInput:
            return @"TypeInput";
        case TypeButton:
            return @"TypeButton";
        case TypeDate:
            return @"TypeDate";
        case TypeTextLabel:
            return @"TypeTextLabel";
        case Type:
            return @"Type";
        case TypeNestHtml:
            return @"TypeNestHtml";
        case TypeTitleLabel:
            return @"TypeTitleLabel";
        default:
            return nil;
    }
}
#pragma 初始化方法
+ (instancetype)FormCellTableView:(UITableView *)tableView withType:(NSString *)type {
    
    NSString  *identifier = NSStringFromTransactionState([type integerValue]);
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.formType = [type integerValue];
    }
    return cell;
}
#pragma 懒加载
/**
 左边标题Label
 */
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
/**
 右边内容label
 */
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}
/**
 右边箭头图标
 */
- (UIImageView *)arrowsImgV {
    if (_arrowsImgV == nil) {
        _arrowsImgV = [[UIImageView alloc] init];
        _arrowsImgV.image = [UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:_arrowsImgV];
    }
    return _arrowsImgV;
}
/**
 右边输入框
 */
- (UITextField *)inputText {
    if (_inputText == nil) {
        _inputText = [[UITextField alloc] init];
        _inputText.placeholder = @"请输入内容";
        _inputText.font = [UIFont systemFontOfSize:14];
        _inputText.textAlignment = NSTextAlignmentRight;
        _inputText.borderStyle = UITextBorderStyleRoundedRect;
        [self.contentView addSubview:_inputText];
    }
    return _inputText;
}
- (UIButton *)commitBtn {
    if (_commitBtn == nil) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn setBackgroundColor:[UIColor blueColor]];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _commitBtn.layer.cornerRadius = 5;
        [_commitBtn addTarget:self action:@selector(clickCommitBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commitBtn];
    }
    return _commitBtn;
}
- (void)clickCommitBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCommitBtnWithCell:)]) {
        [self.delegate clickCommitBtnWithCell:self];
    }
}
#pragma model赋值方法
- (void)setModel:(FormControlModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.titleLabel.text = model.formControlName;
    self.contentLabel.text = model.formControlInfo;
    [self setView];
}
#pragma 布局方法
- (void)setView {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 25));
        make.left.equalTo(self.contentView).with.offset(20);
    }];
    [self.arrowsImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(7, 13));
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
    }];
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.arrowsImgV).with.offset(-10);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(10);
        make.height.equalTo(@25);
    }];
    switch (self.formType) {
        case TypeLabel: {
            [self noArrowsImg];
            break;}
        case TypeSingleSelect: {
            break;}
        case TypeMoreSelect: {
            break;}
        case TypeInput: {
            self.inputText.text = self.model.formControlInfo;
            [self noArrowsImg];
            [self haveInputText];
            break;}
        case TypeButton: {
            [self.commitBtn setTitle:self.model.formControlName forState:UIControlStateNormal];
            [self noArrowsImg];
            [self haveCommitBtn];
            break;}
        case TypeDate: {
            [self noArrowsImg];
            break;}
        case TypeTextLabel: {
            self.inputText.text = self.model.formControlInfo;
            [self noArrowsImg];
            [self haveInputText];
            break;}
        case Type: {
            [self noArrowsImg];
            break;}
        case TypeNestHtml:
            break;
        case TypeTitleLabel: {
            self.contentView.backgroundColor = [UIColor grayColor];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            [self noArrowsImg];
            break;}
        default:
            break;
    }
}
/**
 没有箭头时
 */
- (void)noArrowsImg {
//    [self.arrowsImgV removeFromSuperview];
    self.arrowsImgV.hidden = YES;
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(10);
        make.height.equalTo(@25);
    }];
}
/**
 当是输入框时
 */
- (void)haveInputText {
//    [self.contentLabel removeFromSuperview];
    self.contentLabel.hidden = YES;
    [self.inputText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(10);
        make.height.equalTo(@25);
    }];
}
/**
 当是按钮时
 */
- (void)haveCommitBtn {
    self.titleLabel.hidden = YES;
    self.contentLabel.hidden = YES;
    self.contentLabel.hidden = YES;
    self.arrowsImgV.hidden = YES;
    [self.commitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(10, 20, 10, 20));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

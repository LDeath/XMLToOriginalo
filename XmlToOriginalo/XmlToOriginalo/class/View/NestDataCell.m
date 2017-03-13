//
//  NestDataCell.m
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/13.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "NestDataCell.h"
#import "Masonry.h"

#define selectImg self.isSingle?@"radio_checked":@"radio_selected"
#define unSelectImg self.isSingle?@"radio_unchecked":@"radio_unselected"
#define isSelect model.isSelect?selectImg:unSelectImg

@interface NestDataCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *selectImgV;

@end

@implementation NestDataCell
#pragma 懒加载
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

- (UIImageView *)selectImgV {
    if (_selectImgV == nil) {
        _selectImgV = [[UIImageView alloc] init];
        [self.contentView addSubview:_selectImgV];
    }
    return _selectImgV;
}


#pragma 初始化方法
+ (instancetype)nestDataCellTableView:(UITableView *)tableView withIdentifier:(NSString *)indentifier {
    NestDataCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[NestDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
#pragma model赋值方法
- (void)setModel:(FormControlCateModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.titleLabel.text = model.formControlCateName;
    self.selectImgV.image = [UIImage imageNamed:isSelect];
    [self setView];
}
#pragma 布局方法
- (void)setView {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 25));
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
    }];
    [self.selectImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
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

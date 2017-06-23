//
//  CategoryHomeShowAppCell.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryHomeShowAppCell.h"

@implementation CategoryHomeShowAppCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegateApp.layer.cornerRadius = 7.5;
}

- (IBAction)deleteApp {
    if ([_delegate respondsToSelector:@selector(setUpCategoryHomeShowAppCellWithDeleteApp:)]) {
        [_delegate setUpCategoryHomeShowAppCellWithDeleteApp:self];
    }
}

- (void)setModel:(CategoryModel *)model indexPaht:(NSIndexPath *)indexPath exist:(BOOL)exist{
    if (_model != model) {
//        self.titleLabel.text = model.title;
        if (indexPath.section == 0) {
            [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_reduce"] forState:UIControlStateNormal];
            self.delegateApp.userInteractionEnabled = YES;
        } else {
            if (exist) {
                [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_exist"] forState:UIControlStateNormal];
                self.delegateApp.userInteractionEnabled = NO;
            } else {
                [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_add"] forState:UIControlStateNormal];
                self.delegateApp.userInteractionEnabled = YES;
            }
        }
    }
    _model = model;
}

- (void)setDataAry:(NSMutableArray *)dataAry groupAry:(NSMutableArray *)groupAry indexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model;
    if (indexPath.section == 0) {
        model = dataAry[indexPath.row];
    } else {
        model = groupAry[indexPath.row];
    }
//    self.titleLabel.text = model.title;
    if (indexPath.section == 0) {
        self.delegateApp.userInteractionEnabled = YES;
        [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_reduce"] forState:UIControlStateNormal];
    } else {
        if ([dataAry containsObject:model]) {
            self.delegateApp.userInteractionEnabled = NO;
            [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_exist"] forState:UIControlStateNormal];
        } else {
            self.delegateApp.userInteractionEnabled = YES;
            [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_add"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 是否处于编辑状态

- (void)setInEditState:(BOOL)inEditState
{
    if (inEditState && _inEditState != inEditState) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.delegateApp.hidden = NO;
    } else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.delegateApp.hidden = YES;
    }
}

#pragma mark - init

//- (UIImageView *)imageView
//{
//    if (!_imageView) {
//        _imageView = [[UIImageView alloc] init];
//        _imageView.image = [UIImage imageNamed:@"wallet_payChange"];
//        [self addSubview:_imageView];
//    }
//    return _imageView;
//}

//- (UILabel *)titleLabel
//{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.font = [UIFont systemFontOfSize:14];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_titleLabel];
//    }
//    return _titleLabel;
//}

//- (UILabel *)messageLabel
//{
//    if (!_messageLabel) {
//        _messageLabel = [[UILabel alloc] init];
//        _messageLabel.font = [UIFont systemFontOfSize:12];
//        _messageLabel.textColor = [UIColor grayColor];
//        _messageLabel.textAlignment = NSTextAlignmentCenter;
//        _messageLabel.text = @"您还未添加任何应用\n长按下面的应用可以添加";
//        [self addSubview:_messageLabel];
//    }
//    return _messageLabel;
//}

//- (UIButton *)button
//{
//    if (!_button) {
//        _button = [UIButton buttonWithType:UIButtonTypeCustom];
//        _button.
//        [self addSubview:_button];
//    }
//    return _button;
//}

@end

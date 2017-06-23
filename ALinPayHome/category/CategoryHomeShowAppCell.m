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
        self.appTitle.text = model.title;
//        NSLog(@"------%@",model.title);
//        if (indexPath.section == 0) {
//            [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_reduce"] forState:UIControlStateNormal];
//            self.delegateApp.userInteractionEnabled = YES;
//        } else {
            if (exist) {
                [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_exist"] forState:UIControlStateNormal];
                self.delegateApp.userInteractionEnabled = NO;
            } else {
                [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_add"] forState:UIControlStateNormal];
                self.delegateApp.userInteractionEnabled = YES;
            }
//        }
    }
    _model = model;
}

- (void)setDataAry:(NSMutableArray *)dataAry groupAry:(NSMutableArray *)groupAry indexPath:(NSIndexPath *)indexPath{
//    CategoryModel *model;
//    if (indexPath.section == 0) {
//        model = dataAry[indexPath.row];
//    } else {
        CategoryModel *model = groupAry[indexPath.row];
//    }
    self.appTitle.text = [NSString stringWithFormat:@"%@",model.title];
//    if (indexPath.section == 0) {
//        self.delegateApp.userInteractionEnabled = YES;
//        [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_reduce"] forState:UIControlStateNormal];
//    } else {
        if ([dataAry containsObject:model]) {
            self.delegateApp.userInteractionEnabled = NO;
            [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_exist"] forState:UIControlStateNormal];
        } else {
            self.delegateApp.userInteractionEnabled = YES;
            [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_add"] forState:UIControlStateNormal];
        }
//    }
}



#pragma mark - 是否处于编辑状态

- (void)setInEditState:(BOOL)inEditState{
    if (inEditState && _inEditState != inEditState) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.delegateApp.hidden = NO;
    } else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.delegateApp.hidden = YES;
    }
}

@end

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

- (IBAction)deleteAppWithSender:(id)sender forEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(setUpCategoryHomeShowAppCellWithDeleteApp:event:)]) {
        [_delegate setUpCategoryHomeShowAppCellWithDeleteApp:self event:event];
    }
    if ([_delegate respondsToSelector:@selector(setUpCategoryShowAppCellWithDeleteApp:event:)]) {
        [_delegate setUpCategoryShowAppCellWithDeleteApp:self event:event];
    }
}

- (void)setDataAry:(NSMutableArray *)dataAry groupAry:(NSMutableArray *)groupAry indexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = dataAry[indexPath.row];
    self.appTitle.text = model.title;
    if ([groupAry containsObject:model]) {// 是否存在数组中
        NSLog(@"已存在地址是=====%p", &model);
        self.delegateApp.userInteractionEnabled = NO;
        [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_exist"] forState:UIControlStateNormal];
    } else {
        self.delegateApp.userInteractionEnabled = YES;
        [self.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_add"] forState:UIControlStateNormal];
    }
}

#pragma mark - 是否处于编辑状态
- (void)setInEditState:(BOOL)inEditState{
    if (inEditState && self.inEditState != inEditState) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.delegateApp.hidden = NO;
    } else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.delegateApp.hidden = YES;
    }
}

@end

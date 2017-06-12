//
//  HomeMainTableCell.m
//  YTOHome
//
//  Created by Qing Chang on 2017/6/9.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "HomeMainTableCell.h"

@implementation HomeMainTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)nibView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

@end

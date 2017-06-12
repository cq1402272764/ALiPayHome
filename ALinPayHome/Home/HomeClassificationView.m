//
//  HomeClassificationView.m
//  YTOHome
//
//  Created by Qing Chang on 2017/6/7.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "HomeClassificationView.h"

@implementation HomeClassificationView

+ (instancetype)nibView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

@end

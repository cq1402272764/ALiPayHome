//
//  NavView.m
//  YTOHome
//
//  Created by Qing Chang on 2017/6/9.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "NavView.h"

@implementation NavView

+ (instancetype)nibView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

@end

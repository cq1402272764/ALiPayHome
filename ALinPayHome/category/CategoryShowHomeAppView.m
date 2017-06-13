//
//  CategoryShowHomeAppView.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryShowHomeAppView.h"

@implementation CategoryShowHomeAppView

+ (instancetype)nibView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}


@end

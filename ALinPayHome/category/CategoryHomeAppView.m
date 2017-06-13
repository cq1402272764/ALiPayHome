//
//  CategoryHomeAppView.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryHomeAppView.h"

@implementation CategoryHomeAppView

+ (instancetype)nibView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (IBAction)editSelectBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(categoryHomeAppViewWithEdit:)]) {
        [_delegate categoryHomeAppViewWithEdit:self];
    }
}


@end

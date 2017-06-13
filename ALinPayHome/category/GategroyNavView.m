//
//  GategroyNavView.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "GategroyNavView.h"

@implementation GategroyNavView


+ (instancetype)nibView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (IBAction)popHome {
    if ([_delegate respondsToSelector:@selector(setUpGategroyNavViewPopHomeVC)]) {
        [_delegate setUpGategroyNavViewPopHomeVC];
    }
}

@end

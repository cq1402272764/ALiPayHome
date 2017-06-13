//
//  GategroyShowNavView.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "GategroyShowNavView.h"

@implementation GategroyShowNavView


- (IBAction)cancelBtn {
    if ([_delegate respondsToSelector:@selector(setUpGategroyShowNavViewWithCancel)]) {
        [_delegate setUpGategroyShowNavViewWithCancel];
    }
}
- (IBAction)completeBtn {
    if ([_delegate respondsToSelector:@selector(setUpGategroyShowNavViewWithComplete)]) {
        [_delegate setUpGategroyShowNavViewWithComplete];
    }
}

@end

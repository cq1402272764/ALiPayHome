//
//  CategoryCollectionViewLayout.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/22.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryCollectionViewLayout.h"

@interface CategoryCollectionViewLayout ()

@end

static NSString *layoutObserver = @"CategoryCollectionViewLayout";

@implementation CategoryCollectionViewLayout

#pragma mark - 处于编辑状态

- (void)setInEditState:(BOOL)inEditState{
    if (_inEditState != inEditState) {
        //通过代理方法改变处于编辑状态的cell
        if (_delegate && [_delegate respondsToSelector:@selector(didChangeEditState:)]) {
            [_delegate didChangeEditState:inEditState];
        }
    }
    _inEditState = inEditState;
}

@end

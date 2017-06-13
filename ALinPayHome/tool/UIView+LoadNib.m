//
//  UIView+LoadNib.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "UIView+LoadNib.h"

@implementation UIView (LoadNib)
//根据Xib文件创建View
+ (id)createWithXibName:(NSString *)xibName {
    if (!xibName) {
        id temp = [[[self class] alloc]init];
        return temp;
    }else{
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
        return [nibView objectAtIndex:0];
    }
}

//根据Xib文件创建View
+ (id)createWithXib {
    NSString *className = NSStringFromClass([self class]);
    return [self createWithXibName:className];
}

//根据同一个Xib文件获取不同View
+ (id)creatXibWithIndex:(NSInteger)index {
    NSString *className = NSStringFromClass([self class]);
    return [self createWithXibName:className index:index];
    
}

+ (id)createWithXibName:(NSString *)xibName index:(NSInteger)index {
    if (!xibName) {
        id temp = [[[self class]alloc]init];
        return temp;
    }else {
        NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:xibName owner:nil options:nil];
        return [nibView objectAtIndex:index];
    }
}

@end

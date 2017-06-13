//
//  UIView+LoadNib.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadNib)
//根据Xib文件创建View
+ (id)createWithXib;

//根据Xib文件创建View
+ (id)createWithXibName:(NSString *)xibName;

//根据同一个Xib文件获取不同View
+ (id)creatXibWithIndex:(NSInteger)index;

@end

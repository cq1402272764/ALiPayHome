//
//  UIView+LoadNib.h
//  AtourLiftAdmin
//
//  Created by vvusu on 3/21/16.
//  Copyright © 2016 atour. All rights reserved.
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

//
//  CategoryVC.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryVC;
@protocol CategoryDelegate <NSObject>
@optional
- (void)setUpMoreCategoryWithMoreArray:(CategoryVC *)more;
@end
@interface CategoryVC : UIViewController
@property (nonatomic, weak) id<CategoryDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *groupArray;
@end

//
//  CategoryHomeAppView.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryHomeAppView;
@protocol CategoryHomeAppViewDelegate <NSObject>
@optional
- (void)categoryHomeAppViewWithEdit:(CategoryHomeAppView *)edit;
@end

@interface CategoryHomeAppView : UIView
@property (weak, nonatomic) id<CategoryHomeAppViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIView *editApplication;
@property (weak, nonatomic) IBOutlet UILabel *homeAppTitle;
@end

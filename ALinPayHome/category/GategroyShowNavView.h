//
//  GategroyShowNavView.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GategroyShowNavViewDelegate <NSObject>
@optional
- (void)setUpGategroyShowNavViewWithCancel;
- (void)setUpGategroyShowNavViewWithComplete;
@end

@interface GategroyShowNavView : UIView
@property (weak, nonatomic) id<GategroyShowNavViewDelegate>delegate;
@end

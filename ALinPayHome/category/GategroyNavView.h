//
//  GategroyNavView.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GategroyNavViewDelegate <NSObject>
@optional
- (void)setUpGategroyNavViewPopHomeVC;
@end

@interface GategroyNavView : UIView
@property (weak, nonatomic) id<GategroyNavViewDelegate>delegate;
@end

//
//  MainTableView.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/8.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface MainTableView : UITableView
@property(nonatomic, assign) CGFloat contentOffsetY;
-(void)startRefreshing;
-(void)endRefreshing;
@end

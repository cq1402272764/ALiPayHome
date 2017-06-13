//
//  HomeVC.m
//  YTOHome
//
//  Created by Qing Chang on 2017/6/7.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "HomeVC.h"
#import "Macro.h"
#import "HomeClassificationView.h"
#import "HomeFunction.h"
#import "MainTableView.h"
#import "NavView.h"
#import "CompleteNavView.h"
#import "CategoryVC.h"


@interface HomeVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, weak) MainTableView *mainTableView;
@property (nonatomic, weak) HomeClassificationView *functionView;
@property (nonatomic, weak) HomeFunction *appView;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIView *navView;
@property (nonatomic, weak) UIView *completeNavView;

@end

const CGFloat classViewY = 64;
const CGFloat functionHeaderViewHeight = 100;
const CGFloat singleAppHeaderViewHeight = KFAppHeight;
const CGFloat headerViewH = functionHeaderViewHeight + singleAppHeaderViewHeight;

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KFMainBackColor;
    [self setUpSubView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setUpSubView {
    
    UIView *navBackView = [[UIView alloc] init];
    navBackView.frame = CGRectMake(0, 0, kFBaseWidth, classViewY);
    navBackView.backgroundColor = kFMainColor;
    [self.view addSubview:navBackView];
    
    // 滑动前的navView
    NavView *navView = [NavView nibView];
    navView.frame = CGRectMake(0, 0, kFBaseWidth, classViewY);
    navView.backgroundColor = kFMainColor;
    self.navView = navView;
    [self.view addSubview:navView];
    
    // 滑动后的navView
    CompleteNavView *completeNavView = [CompleteNavView nibView];
    completeNavView.frame = CGRectMake(0, 0, kFBaseWidth, classViewY);
    completeNavView.backgroundColor = kFMainColor;
    self.completeNavView = completeNavView;
    [self.view addSubview:completeNavView];
    completeNavView.alpha = 0;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, classViewY, kFBaseWidth, kFBaseHeight-classViewY)];
    self.mainScrollView.contentSize = CGSizeMake(0, kFBaseHeight * 5);
    self.mainScrollView.scrollIndicatorInsets = UIEdgeInsetsMake((headerViewH), 0, 0, 0);
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    // 顶部View
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, headerViewH)];
    self.headerView = headerView;
    headerView.backgroundColor = kFMainColor;
    [self.mainScrollView addSubview:headerView];
    
    HomeClassificationView *functionView = [HomeClassificationView nibView];
    functionView.frame = CGRectMake(0, 0, kFBaseWidth, functionHeaderViewHeight);
    [headerView addSubview:functionView];
    functionView.backgroundColor = [UIColor clearColor];
    self.functionView = functionView;
    
    HomeFunction *appView = [[HomeFunction alloc] initWithFrame:CGRectMake(0, functionHeaderViewHeight, kFBaseWidth, singleAppHeaderViewHeight)];
    appView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:appView];
    appView.moreCategory = ^{
        CategoryVC *category = [[CategoryVC alloc] init];
        [self.navigationController pushViewController:category animated:YES];
    };
    
    MainTableView *mainTableView = [[MainTableView alloc] initWithFrame:CGRectMake(0, headerViewH, kFBaseWidth, kFBaseHeight * 5 - headerViewH) style:UITableViewStylePlain];
    self.mainTableView = mainTableView;
    [self.mainScrollView addSubview:mainTableView];
}


#pragma mark scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat y = scrollView.contentOffset.y;
    if (y <= 0) {
        CGRect newFrame = self.headerView.frame;
        newFrame.origin.y = y;
        self.headerView.frame = newFrame;
        
        newFrame = self.mainTableView.frame;
        newFrame.origin.y = y + headerViewH;
        self.mainTableView.frame = newFrame;
        
        //设置tableview的偏移量
        self.mainTableView.contentOffsetY = y;
        
        newFrame = self.functionView.frame;
        newFrame.origin.y = 0;
        self.functionView.frame = newFrame;
    } else {
        CGRect newFrame = self.functionView.frame;
        newFrame.origin.y = y/2;
        self.functionView.frame = newFrame;
    }

    CGFloat alpha = (1 - y/functionHeaderViewHeight*2.5 ) > 0 ? (1 - y/functionHeaderViewHeight*2.5 ) : 0;
    
    self.functionView.alpha = alpha;
    if (alpha > 0.5) {
        CGFloat newAlpha =  alpha*2 - 1;
        self.navView.alpha = newAlpha;
        self.completeNavView.alpha = 0;
    } else {
        CGFloat newAlpha =  alpha*2;
        self.navView.alpha = 0;
        self.completeNavView.alpha = 1 - newAlpha;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 松手时判断是否刷新
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"========%f",y);
    if (y < -65) {
        [self.mainTableView startRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainTableView endRefreshing];
        });
    }
}

@end

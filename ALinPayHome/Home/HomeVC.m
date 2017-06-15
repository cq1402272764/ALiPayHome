//
//  HomeVC.m
//  ALinPayHome
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


@interface HomeVC ()<UIScrollViewDelegate>{
    CGFloat singleAppHeaderViewHeight;
    CGFloat headerViewH;
}

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, weak) MainTableView *mainTableView;
@property (nonatomic, weak) HomeClassificationView *functionView;
@property (nonatomic, weak) HomeFunction *appView;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIView *navView;
@property (nonatomic, weak) UIView *completeNavView;

@end

const CGFloat functionHeaderViewHeight = 100;
const CGFloat classViewY = 64;

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

- (void)setUpSubView {
    
    UIView *navBackView = [[UIView alloc] init];
    navBackView.frame = CGRectMake(0, 0, kFBaseWidth, classViewY);
    navBackView.backgroundColor = kFMainColor;
    [self.view addSubview:navBackView];
    
    HomeFunction *appView = [[HomeFunction alloc] init];
    self.appView = appView;
    appView.backgroundColor = [UIColor whiteColor];
    [self setUphomeFunctionArrayCount:appView.homeFunctionArray.count];
    headerViewH = functionHeaderViewHeight + singleAppHeaderViewHeight;
    appView.moreCategory = ^{
        CategoryVC *category = [[CategoryVC alloc] init];
        [self.navigationController pushViewController:category animated:YES];
    };
    
    // 滑动前的navView
    NavView *navView = [NavView createWithXib];
    navView.frame = CGRectMake(0, 0, kFBaseWidth, classViewY);
    navView.backgroundColor = kFMainColor;
    self.navView = navView;
    [self.view addSubview:navView];
    
    // 滑动后的navView
    CompleteNavView *completeNavView = [CompleteNavView createWithXib];
    completeNavView.frame = CGRectMake(0, 0, kFBaseWidth, classViewY);
    completeNavView.backgroundColor = kFMainColor;
    self.completeNavView = completeNavView;
    [self.view addSubview:completeNavView];
    completeNavView.alpha = 0;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, classViewY, kFBaseWidth, kFBaseHeight-classViewY)];
    self.mainScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(headerViewH, 0, 0, 0);
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    // 顶部View
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, headerViewH)];
    self.headerView = headerView;
    headerView.backgroundColor = kFMainColor;
    
    HomeClassificationView *functionView = [HomeClassificationView createWithXib];
    functionView.frame = CGRectMake(0, 0, kFBaseWidth, functionHeaderViewHeight);
    [headerView addSubview:functionView];
    functionView.backgroundColor = [UIColor clearColor];
    self.functionView = functionView;
    
    MainTableView *mainTableView = [[MainTableView alloc] init];
    CGFloat mainTableViewH = mainTableView.homeDataArray.count * 200 + headerViewH;
    
    mainTableView.frame = CGRectMake(0, headerViewH, kFBaseWidth, mainTableViewH);
    
    self.mainScrollView.contentSize = CGSizeMake(0, mainTableViewH);
    
    self.mainTableView = mainTableView;
    
    [self.mainScrollView addSubview:mainTableView];
    [self.mainScrollView addSubview:headerView];
    
    [headerView addSubview:appView];
}


#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
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
//        if (y == 103.0) {
//            self.mainTableView.scrollEnabled = YES;
//            self.mainScrollView.scrollEnabled = NO;
//        }else{
//            self.mainTableView.scrollEnabled = NO;
//            self.mainScrollView.scrollEnabled = YES;
//        }
    }

    CGFloat alpha = (1 - y/functionHeaderViewHeight * 2.5 ) > 0 ? (1 - y/functionHeaderViewHeight * 2.5 ) : 0;
    self.functionView.alpha = alpha;
    if (alpha > 0.5) {
        CGFloat newAlpha = alpha*2 - 1;
        self.navView.alpha = newAlpha;
        self.completeNavView.alpha = 0;
    } else {
        CGFloat newAlpha = alpha*2;
        self.navView.alpha = 0;
        self.completeNavView.alpha = 1 - newAlpha;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 松手时判断是否刷新
    CGFloat y = scrollView.contentOffset.y;
    if (y < -65) {
        [self.mainTableView startRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainTableView endRefreshing];
        });
    }
}

- (void)setUphomeFunctionArrayCount:(NSInteger)count{
    if (count > 8) {
        singleAppHeaderViewHeight = KFAppHeight;
    }else if (count > 4 & count <= 8){
        singleAppHeaderViewHeight = KFAppHeight * 2 / 3;
    }else{
        singleAppHeaderViewHeight = KFAppHeight/3;
    }
    self.appView.frame = CGRectMake(0, functionHeaderViewHeight, kFBaseWidth, singleAppHeaderViewHeight);
}


@end

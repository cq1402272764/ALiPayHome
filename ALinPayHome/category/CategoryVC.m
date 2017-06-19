//
//  CategoryVC.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryVC.h"
#import "Macro.h"
#import "CategoryHomeAppView.h"
#import "CategoryTableView.h"
#import "CategoryShowHomeAppView.h"
#import "GategroyNavView.h"
#import "GategroyShowNavView.h"

@interface CategoryVC ()<CategoryHomeAppViewDelegate,GategroyShowNavViewDelegate,GategroyNavViewDelegate>
{
    CGFloat showHomeAppViewH;
    CGFloat tableViewH;
}
@property (nonatomic, strong) UIScrollView *categoryScrollView;
@property (nonatomic, strong) CategoryShowHomeAppView *showHomeAppView;
@property (nonatomic, strong) CategoryHomeAppView *homeAppView;
@property (nonatomic, strong) CategoryTableView *tableView;
@property (nonatomic, strong) GategroyNavView *navView;
@property (nonatomic, strong) GategroyShowNavView *showNavView;
@end

const CGFloat navViewH = 64;
const CGFloat homeAppViewH = 44;
const CGFloat homeAppBackViewH = 290;
const CGFloat spacing = 8;

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self subView];
}

- (void)subView{
    self.navView = [GategroyNavView createWithXib];
    self.navView.frame = CGRectMake(0, 0, kFBaseWidth, navViewH);
    [self.view addSubview:self.navView];
    self.navView.delegate = self;
    
    self.showNavView = [GategroyShowNavView createWithXib];
    self.showNavView.frame = CGRectMake(0, 0, kFBaseWidth, navViewH);
    self.showNavView.alpha = 0;
    [self.view addSubview:self.showNavView];
    self.showNavView.delegate = self;
    
    self.categoryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navViewH, kFBaseWidth, kFBaseHeight-navViewH)];
    self.categoryScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.categoryScrollView];
    self.categoryScrollView.backgroundColor = [UIColor whiteColor];
    
    self.homeAppView = [CategoryHomeAppView createWithXib];
    self.homeAppView.frame= CGRectMake(0, 0, kFBaseWidth, homeAppViewH);
    [self.categoryScrollView addSubview:self.homeAppView];
    self.homeAppView.backgroundColor = [UIColor whiteColor];
    self.homeAppView.delegate = self;

    self.showHomeAppView = [CategoryShowHomeAppView createWithXib];
    [self setUphomeFunctionArrayCount:self.showHomeAppView.homeAppArray.count];
    [self.categoryScrollView addSubview:self.showHomeAppView ];
    self.showHomeAppView .alpha = 0;
    
    self.tableView = [[CategoryTableView alloc] init];
    tableViewH = self.tableView.homeDataArray.count * 200 + (homeAppViewH+spacing);
    self.tableView.frame = CGRectMake(0, homeAppViewH+spacing, kFBaseWidth, tableViewH);
    self.categoryScrollView.contentSize = CGSizeMake(0, tableViewH);
    [self.categoryScrollView addSubview:self.tableView];

}

#pragma mark CategoryHomeAppViewDelegate
// 编辑
- (void)categoryHomeAppViewWithEdit:(CategoryHomeAppView *)edit{
    [self showSubView:NO];
}

#pragma mark GategroyShowNavViewDelegate
// 取消
- (void)setUpGategroyShowNavViewWithCancel{
    [self showSubView:YES];
}

// 完成
- (void)setUpGategroyShowNavViewWithComplete{
    [self showSubView:YES];
}

#pragma mark GategroyNavViewDelegate
// 返回
- (void)setUpGategroyNavViewPopHomeVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showSubView:(BOOL)show{
    if (show) {
        [self setUpInteractivePopGestureRecognizerEnabled:YES scrollEnabled:NO];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [UIView animateWithDuration:0.3 animations:^{
            self.navView.alpha = 1;
            self.showNavView.alpha = 0;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                self.homeAppView.alpha = 1;
                self.showHomeAppView.alpha = 0;
                
                CGRect newFrame = self.homeAppView.editApplication.frame;
                newFrame.origin.y = 0;
                self.homeAppView.editApplication.frame = newFrame;
            }];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                CGRect newFrame = self.tableView.frame;
                newFrame.origin.y = homeAppViewH+spacing;
                newFrame.size.height = tableViewH;
                self.tableView.frame = newFrame;
            }];
        });
    }else{
        [self setUpInteractivePopGestureRecognizerEnabled:NO scrollEnabled:YES];
        [UIView animateWithDuration:0.3 animations:^{
            self.navView.alpha = 0;
            self.showNavView.alpha = 1;
            self.homeAppView.alpha = 0;
            self.showHomeAppView.alpha = 1;
            
            CGRect newFrame = self.homeAppView.editApplication.frame;
            newFrame.origin.y = homeAppViewH/2;
            self.homeAppView.editApplication.frame = newFrame;
            
            newFrame = self.tableView.frame;
            newFrame.origin.y = showHomeAppViewH+spacing;
            newFrame.size.height = kFBaseHeight -(homeAppViewH+spacing)-homeAppBackViewH;
            self.tableView.frame = newFrame;
        }];
    }
}

- (void)setUpInteractivePopGestureRecognizerEnabled:(BOOL)enabled scrollEnabled:(BOOL)scrollEnabled{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = enabled;
    }
    if (scrollEnabled) {
        self.categoryScrollView.scrollEnabled = NO;
        self.tableView.scrollEnabled = YES;
    }else{
        self.categoryScrollView.scrollEnabled = YES;
        self.tableView.scrollEnabled = NO;
    }
}

- (void)setUphomeFunctionArrayCount:(NSInteger)count{
    if ( count > 8) {
        showHomeAppViewH = homeAppBackViewH;
    }else if (count > 4 & count <= 8){
        showHomeAppViewH = homeAppBackViewH * 2 / 3;
    }else{
        showHomeAppViewH = homeAppBackViewH/3;
    }
    self.showHomeAppView.frame = CGRectMake(0, 0, kFBaseWidth, showHomeAppViewH);
}

@end

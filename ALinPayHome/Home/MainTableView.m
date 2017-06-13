//
//  MainTableView.m
//  YTOHome
//
//  Created by Qing Chang on 2017/6/8.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "MainTableView.h"
#import "HomeMainTableCell.h"

@interface MainTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

static NSString *cellID = @"MainTableViewCell";

@implementation MainTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:nil];
        self.backgroundColor = KFMainBackColor;
    }
    return self;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    _contentOffsetY = contentOffsetY;
    if (![self.mj_header isRefreshing]) {
        self.contentOffset = CGPointMake(0, contentOffsetY);
    }
}

- (void)startRefreshing {
    [self.mj_header beginRefreshing];
}
- (void)endRefreshing {
    [self.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeMainTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [HomeMainTableCell createWithXib];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kFBaseHeight * 5 - 310) / 20;
}

@end

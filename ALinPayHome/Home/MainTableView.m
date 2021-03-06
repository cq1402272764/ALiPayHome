//
//  MainTableView.m
//  ALinPayHome
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

- (NSMutableArray *)homeDataArray{
    if (_homeDataArray == nil) {
        _homeDataArray = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 20; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%d",i];
            [_homeDataArray addObject:imageName];
        }
    }
    return _homeDataArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:nil];
        self.backgroundColor = KFMainBackColor;
        self.scrollEnabled = NO;
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
    return self.homeDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeMainTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [HomeMainTableCell createWithXib];
    }
    cell.index.text = self.homeDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

@end

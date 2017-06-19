//
//  CategoryTableView.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryTableView.h"
#import "HomeMainTableCell.h"
#import "Macro.h"

@interface CategoryTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

static NSString *cellID = @"CategoryTableViewCell";

@implementation CategoryTableView

- (NSMutableArray *)homeDataArray{
    if (_homeDataArray == nil) {
        _homeDataArray = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 10; i++) {
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
        self.backgroundColor = KFMainBackColor;
        self.scrollEnabled = NO;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeMainTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [HomeMainTableCell createWithXib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

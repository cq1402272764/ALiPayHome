//
//  CategoryHomeShowAppCell.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@class CategoryHomeShowAppCell;
@protocol CategoryHomeShowAppCellDelegate <NSObject>
@optional
- (void)setUpCategoryHomeShowAppCellWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp event:(id)event;
- (void)setUpCategoryShowAppCellWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp event:(id)event;
@end

@interface CategoryHomeShowAppCell : UICollectionViewCell
@property (weak, nonatomic) id<CategoryHomeShowAppCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *appTitle;
@property (strong, nonatomic) NSIndexPath *indexPath;


@property (weak, nonatomic) IBOutlet UIButton *delegateApp;// 删除Btn

@property (nonatomic, strong) CategoryModel *model;

@property (nonatomic, assign) BOOL inEditState; //是否处于编辑状态

- (void)setDataAry:(NSMutableArray *)dataAry groupAry:(NSMutableArray *)groupAry indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) UILabel *messageLabel;

@end

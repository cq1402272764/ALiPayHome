//
//  CategoryHomeShowAppCell.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryHomeShowAppCell;
@protocol CategoryHomeShowAppCellDelegate <NSObject>
@optional
- (void)setUpCategoryHomeShowAppCellWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp;
@end

@interface CategoryHomeShowAppCell : UICollectionViewCell
@property (weak, nonatomic) id<CategoryHomeShowAppCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *appTitle;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (weak, nonatomic) IBOutlet UIButton *delegateApp;

@end

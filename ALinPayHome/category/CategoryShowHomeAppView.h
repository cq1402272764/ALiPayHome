//
//  CategoryShowHomeAppView.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CategoryShowHomeAppView;
@protocol CategoryShowHomeAppViewDelegate <NSObject>
@optional
- (void)setUpCategoryShowHomeAppViewWithDeleteApp:(CategoryShowHomeAppView *)deleteApp event:(id)event;
- (void)setUpCategoryShowHomeAppViewWithDragChangeItem:(CategoryShowHomeAppView *)Item index:(NSIndexPath *)index toIndexPath:(NSIndexPath *)toIndexPath;
@end
@interface CategoryShowHomeAppView : UIView
@property (weak, nonatomic) id<CategoryShowHomeAppViewDelegate>delegate;
@property (strong, nonatomic) NSMutableArray *homeAppArray;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *coverViews;
@end

//
//  CategoryCollectionViewLayout.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/22.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryCollectionViewLayoutDelegate <NSObject>

// 改变编辑状态
- (void)didChangeEditState:(BOOL)inEditState;

@end

@interface CategoryCollectionViewLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) BOOL inEditState; //检测是否处于编辑状态
@property (nonatomic, weak) id<CategoryCollectionViewLayoutDelegate> delegate;

@end

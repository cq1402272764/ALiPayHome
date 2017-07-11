//
//  HomeFunction.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/7.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeFunction : UIView

@property (nonatomic, strong) void (^moreCategory)();
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *homeFunctionArray;

@end

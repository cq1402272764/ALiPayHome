//
//  HomeFunction.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/7.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "HomeFunction.h"
#import "Macro.h"
#import "HomeFunctionCell.h"

@interface HomeFunction ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

static NSString *cellId = @"HomeFunction";

@implementation HomeFunction

- (NSMutableArray *)homeFunctionArray{
    if (_homeFunctionArray == nil) {
        _homeFunctionArray = [NSMutableArray array];
        for (int i = 1; i <= 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%d",i];
            [_homeFunctionArray addObject:imageName];
        }
    }
    return _homeFunctionArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = 0;
        //最小两行之间的间距
        layout.minimumLineSpacing = 0;
        
        layout.itemSize = CGSizeMake(kFBaseWidth/5, KFAppHeight/3);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, 194) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        
        [collectionView registerNib:[UINib nibWithNibName:@"HomeFunctionCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    }
    return self;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeFunctionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.row == (self.homeFunctionArray.count-1)) {
        cell.more.text = @"更多";
        cell.more.textColor = [UIColor redColor];
    }else{
        cell.more.text = [NSString stringWithFormat:@"余额宝%@",self.homeFunctionArray[indexPath.row]];
    }
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == (self.homeFunctionArray.count-1)) {
        if (self.moreCategory) {
            self.moreCategory();
        }
    }
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
@end

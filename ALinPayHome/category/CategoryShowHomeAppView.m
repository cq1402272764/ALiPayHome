//
//  CategoryShowHomeAppView.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryShowHomeAppView.h"
#import "Macro.h"
#import "CategoryHomeShowAppCell.h"

@interface CategoryShowHomeAppView ()<UICollectionViewDelegate,UICollectionViewDataSource,CategoryHomeShowAppCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *homeAppView;
@property (weak, nonatomic) UICollectionView *collectionView;

@end

static NSString *const cellId = @"ShowHomeAppView";

@implementation CategoryShowHomeAppView

- (NSMutableArray *)homeAppArray{
    if (_homeAppArray == nil) {
        _homeAppArray = [NSMutableArray array];
        for (int i = 1; i <= 11; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%d",i];
            [_homeAppArray addObject:imageName];
        }
    }
    return _homeAppArray;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 10;
    //最小两行之间的间距
    layout.minimumLineSpacing = 10;
    
    layout.itemSize = CGSizeMake(kFBaseWidth/5, KFAppHeight/3);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, 290-44) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.homeAppView addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:@"CategoryHomeShowAppCell" bundle:nil] forCellWithReuseIdentifier:cellId];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeAppArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryHomeShowAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell addGestureRecognizer:longPress];
    cell.appTitle.text = [NSString stringWithFormat:@"余额宝%@",self.homeAppArray[indexPath.row]];
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"-----%zd",indexPath.row);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 70);
}

//每一个分组的上左下右间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) break;
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:{
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            NSLog(@"=======%ld",indexPath.row);
            [self randamArry:self.homeAppArray indexPath:indexPath];
        }
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)setUpCategoryHomeShowAppCellWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp{
    NSLog(@"self.homeAppArray======%@",self.homeAppArray);
    id objc = [self.homeAppArray objectAtIndex:deleteApp.indexPath.row];
    //从资源数组中移除该数据
    [self.homeAppArray removeObject:objc];
    [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [self.homeAppArray objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.homeAppArray removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.homeAppArray insertObject:objc atIndex:destinationIndexPath.item];
}

- (void)randamArry:(NSArray *)arry indexPath:(NSIndexPath *)indexPath{
    NSComparator cmptr = ^(id obj1, id obj2){
//        if ([obj1 integerValue] > [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        if ([obj1 integerValue] < [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
        return (NSComparisonResult)NSOrderedSame;
    };
    arry = [arry sortedArrayUsingComparator:cmptr];
    
    for (NSString *str in self.homeAppArray) {
        NSLog(@"arry======%@",str);
    }
}
@end

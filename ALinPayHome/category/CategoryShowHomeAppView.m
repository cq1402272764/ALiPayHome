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
#import "CategoryCollectionViewLayout.h"
#import "CategoryModel.h"

@interface CategoryShowHomeAppView ()<UICollectionViewDelegate,UICollectionViewDataSource,CategoryHomeShowAppCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *homeAppView;
//@property (weak, nonatomic) UICollectionView *collectionView;

@end

static NSString *const cellId = @"ShowHomeAppView";

@implementation CategoryShowHomeAppView

//- (NSMutableArray *)homeAppArray{
//    if (_homeAppArray == nil) {
//        _homeAppArray = [NSMutableArray array];
//        for (int i = 1; i <= 11; i++) {
//            CategoryModel *model = [[CategoryModel alloc] init];
//            model.title = [NSString stringWithFormat:@"生活%@", @(i)];
//            [self.homeAppArray addObject:model];
//        }
//    }
//    return _homeAppArray;
//}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CategoryCollectionViewLayout *layout = [[CategoryCollectionViewLayout alloc]init];
    CGFloat width = (kFBaseWidth - 80) / 4;
//    layout.delegate = self;
    //设置每个图片的大小
    layout.itemSize = CGSizeMake(width, width);
    //设置滚动方向的间距
    layout.minimumLineSpacing = 10;
    //设置上方的反方向
    layout.minimumInteritemSpacing = 0;
    //设置collectionView整体的上下左右之间的间距
    layout.sectionInset = UIEdgeInsetsMake(15, 20, 20, 20);
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, 300-44) collectionViewLayout:layout];
//    self.collectionView = collectionView;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.homeAppView addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryHomeShowAppCell" bundle:nil] forCellWithReuseIdentifier:cellId];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeAppArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryHomeShowAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    cell.delegate = self;
    cell.indexPath = indexPath;
//    [cell addGestureRecognizer:longPress];
    
    CategoryModel *model = self.homeAppArray[indexPath.row];
    cell.appTitle.text = model.title;//[NSString stringWithFormat:@"%@",model.title];
//    NSLog(@"model.title--------%@",model.title);
    return cell;
}

#pragma mark UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"-----%zd",indexPath.row);
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(70, 70);
//}

//每一个分组的上左下右间距
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(10, 10, 0, 10);
//}

//- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
//    //判断手势状态
//    switch (longGesture.state) {
//        case UIGestureRecognizerStateBegan:{
//            //判断手势落点位置是否在路径上
//            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
//            if (indexPath == nil) break;
//            //在路径上则开始移动该路径上的cell
//            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
//            
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//            //移动过程当中随时更新cell位置
//            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
//            break;
//        case UIGestureRecognizerStateEnded:{
//            //移动结束后关闭cell移动
//            [self.collectionView endInteractiveMovement];
//            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
////            NSLog(@"=======%ld",indexPath.row);
//            [self randamArry:self.homeAppArray indexPath:indexPath];
//        }
//            break;
//        default:
//            [self.collectionView cancelInteractiveMovement];
//            break;
//    }
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}



/**
 *sourceIndexPath 原始数据 indexpath
 * destinationIndexPath 移动到目标数据的 indexPath
 */
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
//    
//    //取出源item数据
//    id objc = [self.homeAppArray objectAtIndex:sourceIndexPath.item];
//    NSLog(@"objc======%@",objc);
//    //从资源数组中移除该数据
//    [self.homeAppArray removeObject:objc];
//    //将数据插入到资源数组中的目标位置上
//    [self.homeAppArray insertObject:objc atIndex:destinationIndexPath.item];
//    
//    
//   
//    NSLog(@"item======%ld",(long)destinationIndexPath.item);
//}

//- (void)randamArry:(NSArray *)arry indexPath:(NSIndexPath *)indexPath{
//    NSComparator cmptr = ^(id obj1, id obj2){
////        if ([obj1 integerValue] > [obj2 integerValue]) {
////            return (NSComparisonResult)NSOrderedDescending;
////        }
////        if ([obj1 integerValue] < [obj2 integerValue]) {
////            return (NSComparisonResult)NSOrderedAscending;
////        }
//        return (NSComparisonResult)NSOrderedSame;
//    };
//    arry = [arry sortedArrayUsingComparator:cmptr];
//    
//    for (NSString *str in self.homeAppArray) {
//        NSLog(@"arry======%@",str);
//    }
//}

- (void)setUpCategoryHomeShowAppCellWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp event:(id)event{
//    id objc = [self.homeAppArray objectAtIndex:deleteApp.indexPath.row];
//    //从资源数组中移除该数据
//    [self.homeAppArray removeObject:objc];
//    [self.collectionView reloadData];
//    if ([_delegate respondsToSelector:@selector(setUpCategoryShowHomeAppViewWithDeleteApp:)]) {
//        [_delegate setUpCategoryShowHomeAppViewWithDeleteApp:deleteApp];
//    }
    NSLog(@"========%@",event);
    if ([_delegate respondsToSelector:@selector(setUpCategoryShowHomeAppViewWithDeleteApp: event:)]) {
        [_delegate setUpCategoryShowHomeAppViewWithDeleteApp:self event:event];
    }
}

////处于编辑状态 代理方法
//- (void)didChangeEditState:(BOOL)inEditState
//{
//    self.inEditState = inEditState;
//    //    self.rightBtn.selected = inEditState;
//    for (CategoryHomeShowAppCell *cell in self.collectionView.visibleCells) {
//        //        NSLog(@"======%@",cell.appTitle.text);
//        cell.inEditState = inEditState;
//    }
//}
//
////改变数据源中model的位置
//- (void)moveItemAtIndexPath:(NSIndexPath *)formPath toIndexPath:(NSIndexPath *)toPath{
//    CategoryModel *model = self.showHomeAppView.homeAppArray[formPath.row];
//    //先把移动的这个model移除
//    [self.showHomeAppView.homeAppArray removeObject:model];
//    //再把这个移动的model插入到相应的位置
//    [self.showHomeAppView.homeAppArray insertObject:model atIndex:toPath.row];
//}


@end

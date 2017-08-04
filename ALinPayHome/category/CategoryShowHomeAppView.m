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

@interface CategoryShowHomeAppView ()<UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    CategoryHomeShowAppCellDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *homeAppView;
@property (strong, nonatomic) CategoryCollectionViewLayout *layout;
@end

static NSString *const cellId = @"ShowHomeAppView";

@implementation CategoryShowHomeAppView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.coverViews.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.7].CGColor,
                       (id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3].CGColor, nil];
    [self.coverViews.layer addSublayer:gradient];

    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryHomeShowAppCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
}

- (CategoryCollectionViewLayout *)layout{
    if (_layout == nil) {
        self.layout = [[CategoryCollectionViewLayout alloc]init];
        CGFloat width = (kFBaseWidth - 40) / 4;
        //设置每个图片的大小
        self.layout.itemSize = CGSizeMake(width, width-15);
        //设置滚动方向的间距
        self.layout.minimumLineSpacing = 10;
        //设置上方的反方向
        self.layout.minimumInteritemSpacing = 0;
        //设置collectionView整体的上下左右之间的间距
        self.layout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
        //设置滚动方向
        self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kFBaseWidth, 300-44) collectionViewLayout:self.layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollEnabled = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.homeAppView addSubview:self.collectionView];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPressGesture.minimumPressDuration = 0.3f;
        longPressGesture.delegate = self;
        [_collectionView addGestureRecognizer:longPressGesture];
        
    }
    return _collectionView;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeAppArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryHomeShowAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    CategoryModel *model = self.homeAppArray[indexPath.row];
    cell.appTitle.text = model.title;
    [cell.delegateApp setBackgroundImage:[UIImage imageNamed:@"life_reduce"] forState:UIControlStateNormal];
    cell.inEditState = YES;
    return cell;
}

- (void)setUpCategoryHomeShowAppCellWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp event:(id)event{
    if ([_delegate respondsToSelector:@selector(setUpCategoryShowHomeAppViewWithDeleteApp: event:)]) {
        [_delegate setUpCategoryShowHomeAppViewWithDeleteApp:self event:event];
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    //根据长按手势的状态进行处理。
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) break;
            //开始移动
            [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            [_collectionView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
            //停止移动调用此方法
            [_collectionView endInteractiveMovement];
            break;
        default:
            //取消移动
            [_collectionView cancelInteractiveMovement];
            break;
    }
}


// 在开始移动时会调用此代理方法，
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexpath判断单元格是否可以移动，如果都可以移动，直接就返回YES ,不能移动的返回NO
    return YES;
}

// 在移动结束的时候调用此代理方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    
    if ([_delegate respondsToSelector:@selector(setUpCategoryShowHomeAppViewWithDragChangeItem: index: toIndexPath:)]) {
        [_delegate setUpCategoryShowHomeAppViewWithDragChangeItem:self index:sourceIndexPath toIndexPath:destinationIndexPath];
    }

}


@end

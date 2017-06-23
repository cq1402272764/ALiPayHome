//
//  CategoryVC.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryVC.h"
#import "Macro.h"
#import "CategoryHomeAppView.h"
#import "CategoryShowHomeAppView.h"
#import "GategroyNavView.h"
#import "GategroyShowNavView.h"
//#import "CategoryCollectionCell.h"
#import "CollectionReusableHeaderView.h"
#import "CollectionReusableFooterView.h"
#import "CategoryHomeShowAppCell.h"

#import "CategoryCollectionViewLayout.h"
#import "CategoryModel.h"

@interface CategoryVC ()<CategoryHomeAppViewDelegate,GategroyShowNavViewDelegate,GategroyNavViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CategoryCollectionViewLayoutDelegate,CategoryShowHomeAppViewDelegate>
{
    CGFloat showHomeAppViewH;
    CGFloat appCollectionViewH;
}
@property (nonatomic, strong) NSMutableArray *homeDataArray;

@property (nonatomic, strong) NSMutableArray *groupArray;

@property (nonatomic, strong) UIScrollView *categoryScrollView;
@property (nonatomic, strong) CategoryShowHomeAppView *showHomeAppView;
@property (nonatomic, strong) CategoryHomeAppView *homeAppView;
@property (nonatomic, strong) GategroyNavView *navView;
@property (nonatomic, strong) GategroyShowNavView *showNavView;
@property (nonatomic, strong) UICollectionView *appCollectionView;
@property (nonatomic, strong) CategoryCollectionViewLayout *layout;
@property (nonatomic, assign) BOOL inEditState; //是否处于编辑状态
@end

const CGFloat navViewH = 64;
const CGFloat homeAppViewH = 44;
const CGFloat homeAppBackViewH = 300;
const CGFloat spacing = 8;
const CGFloat collectionReusableViewH = 40;

static NSString *const cellId = @"CategoryHomeShowAppCell";
static NSString *const headerId = @"CollectionReusableHeaderView";
static NSString *const footerId = @"CollectionReusableFooterView";

@implementation CategoryVC


- (NSMutableArray *)homeDataArray{
    if (_homeDataArray == nil) {
        _homeDataArray = [NSMutableArray array];
        
    }
    return _homeDataArray;
}

- (NSMutableArray *)groupArray{
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpData];
    [self subView];
}

- (void)setUpData{
    
    for (int i = 1; i <= 11; i++) {
        CategoryModel *model = [[CategoryModel alloc] init];
        model.title = [NSString stringWithFormat:@"支付宝%@", @(i)];
        [self.homeDataArray addObject:model];
        [self.groupArray addObject:model];
    }
    for (int i = 0; i < 6; i++) {
        CategoryModel *model = [[CategoryModel alloc] init];
        model.title = [NSString stringWithFormat:@"生活%@", @(i)];
        [self.groupArray addObject:model];
    }
}

- (void)subView{
    self.navView = [GategroyNavView createWithXib];
    self.navView.frame = CGRectMake(0, 0, kFBaseWidth, navViewH);
    [self.view addSubview:self.navView];
    self.navView.delegate = self;
    
    self.showNavView = [GategroyShowNavView createWithXib];
    self.showNavView.frame = CGRectMake(0, 0, kFBaseWidth, navViewH);
    self.showNavView.alpha = 0;
    [self.view addSubview:self.showNavView];
    self.showNavView.delegate = self;
    
    self.categoryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navViewH, kFBaseWidth, kFBaseHeight-navViewH)];
    self.categoryScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.categoryScrollView];
    self.categoryScrollView.backgroundColor = [UIColor whiteColor];
    
    self.homeAppView = [CategoryHomeAppView createWithXib];
    self.homeAppView.frame= CGRectMake(0, 0, kFBaseWidth, homeAppViewH);
    [self.categoryScrollView addSubview:self.homeAppView];
    self.homeAppView.delegate = self;
    
    self.showHomeAppView = [CategoryShowHomeAppView createWithXib];
    self.showHomeAppView.homeAppArray = self.homeDataArray;
    [self setUphomeFunctionArrayCount:self.showHomeAppView.homeAppArray.count];
    [self.categoryScrollView addSubview:self.showHomeAppView ];
    self.showHomeAppView.alpha = 0;
    self.showHomeAppView.delegate = self;
    
    self.layout = [[CategoryCollectionViewLayout alloc]init];
    CGFloat width = (kFBaseWidth - 80) / 4;
    self.layout.delegate = self;
    //设置每个图片的大小
    self.layout.itemSize = CGSizeMake(width, width);
    //设置滚动方向的间距
    self.layout.minimumLineSpacing = 10;
    //设置上方的反方向
    self.layout.minimumInteritemSpacing = 0;
    //设置collectionView整体的上下左右之间的间距
    self.layout.sectionInset = UIEdgeInsetsMake(15, 20, 20, 20);
    //设置滚动方向
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    self.appCollectionView.backgroundColor = [UIColor whiteColor];
    // 行数 * 单个app的高度 * 组数
    CGFloat number;
    if ((self.homeDataArray.count % 4) > 0) {
        number = self.homeDataArray.count / 4 + 1;
    }else{
        number = self.homeDataArray.count / 4;
    }
    CGFloat appH = (number * (homeAppBackViewH / 3) + collectionReusableViewH)  * self.homeDataArray.count;
    
    appCollectionViewH = appH + (homeAppViewH+spacing);
    self.appCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, homeAppViewH+spacing, kFBaseWidth, appCollectionViewH) collectionViewLayout:self.layout];
    
    self.categoryScrollView.contentSize = CGSizeMake(0, appCollectionViewH);
    [self.categoryScrollView addSubview:self.appCollectionView];
    self.appCollectionView.backgroundColor = [UIColor whiteColor];
    self.appCollectionView.delegate = self;
    self.appCollectionView.dataSource = self;
    
    [self.appCollectionView  registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryHomeShowAppCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
    [self.appCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionReusableHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [self.appCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionReusableFooterView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
}


#pragma mark CategoryHomeAppViewDelegate
// 编辑
- (void)categoryHomeAppViewWithEdit:(CategoryHomeAppView *)edit{
    [self showSubView:NO];
    
//    if (!self.inEditState) { //点击了编辑
        self.inEditState = YES;
        self.appCollectionView.allowsSelection = NO;
//    }
    [self.layout setInEditState:self.inEditState];
    NSLog(@"点击了编辑按钮");

}

#pragma mark GategroyShowNavViewDelegate
// 取消
- (void)setUpGategroyShowNavViewWithCancel{
    [self showSubView:YES];
    self.inEditState = NO;
    self.appCollectionView.allowsSelection = YES;
    NSLog(@"点击了取消按钮");
}

// 完成
- (void)setUpGategroyShowNavViewWithComplete{
    [self showSubView:YES];
    //点击了完成
    self.inEditState = NO;
    self.appCollectionView.allowsSelection = YES;
    //此处可以调用网络请求，把排序完之后的传给服务端
    NSLog(@"点击了完成按钮");

}

#pragma mark GategroyNavViewDelegate
// 返回
- (void)setUpGategroyNavViewPopHomeVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showSubView:(BOOL)show{
    
//    [self.layout setInEditState:self.inEditState];
    
    if (show) {
        [self setUpInteractivePopGestureRecognizerEnabled:YES scrollEnabled:NO];
//        [self.appCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionTop];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.navView.alpha = 1;
            self.showNavView.alpha = 0;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                self.homeAppView.alpha = 1;
                self.showHomeAppView.alpha = 0;
                
                CGRect newFrame = self.homeAppView.editApplication.frame;
                newFrame.origin.y = 0;
                self.homeAppView.editApplication.frame = newFrame;
            }];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                CGRect newFrame = self.appCollectionView.frame;
                newFrame.origin.y = homeAppViewH+spacing+spacing;
                newFrame.size.height = appCollectionViewH;
                self.appCollectionView.frame = newFrame;
            }];
        });
    }else{
        [self setUpInteractivePopGestureRecognizerEnabled:NO scrollEnabled:YES];
        [UIView animateWithDuration:0.3 animations:^{
            self.navView.alpha = 0;
            self.showNavView.alpha = 1;
            self.homeAppView.alpha = 0;
            self.showHomeAppView.alpha = 1;
            
            CGRect newFrame = self.homeAppView.editApplication.frame;
            newFrame.origin.y = homeAppViewH/2;
            self.homeAppView.editApplication.frame = newFrame;
            
            newFrame = self.appCollectionView.frame;
            newFrame.origin.y = showHomeAppViewH+spacing;
            newFrame.size.height = kFBaseHeight -(navViewH+spacing)-homeAppBackViewH;
            self.appCollectionView.frame = newFrame;
        }];
    }
}

- (void)setUpInteractivePopGestureRecognizerEnabled:(BOOL)enabled scrollEnabled:(BOOL)scrollEnabled{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = enabled;
    }
    if (scrollEnabled) {
        self.categoryScrollView.scrollEnabled = NO;
        self.appCollectionView.scrollEnabled = YES;
    }else{
        self.categoryScrollView.scrollEnabled = YES;
        self.appCollectionView.scrollEnabled = NO;
    }
}

- (void)setUphomeFunctionArrayCount:(NSInteger)count{
    if ( count > 8) {
        showHomeAppViewH = homeAppBackViewH;
    }else if (count > 4 & count <= 8){
        showHomeAppViewH = homeAppBackViewH * 2 / 3;
    }else{
        showHomeAppViewH = homeAppBackViewH/3;
    }
    self.showHomeAppView.frame = CGRectMake(0, 0, kFBaseWidth, showHomeAppViewH);
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.homeDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryHomeShowAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSLog(@"homeDataArray------%@",self.homeDataArray);
    NSLog(@"groupArray------%@",self.groupArray);
    [cell setDataAry:self.homeDataArray groupAry:self.groupArray indexPath:indexPath];
    //是否处于编辑状态，如果处于编辑状态，出现边框和按钮，否则隐藏
    cell.inEditState = self.inEditState;
    [cell.delegateApp addTarget:self action:@selector(btnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


//处于编辑状态 代理方法
- (void)didChangeEditState:(BOOL)inEditState
{
    self.inEditState = inEditState;
//    self.rightBtn.selected = inEditState;
    for (CategoryHomeShowAppCell *cell in self.appCollectionView.visibleCells) {
//        NSLog(@"======%@",cell.appTitle.text);
        cell.inEditState = inEditState;
    }
}

//改变数据源中model的位置
- (void)moveItemAtIndexPath:(NSIndexPath *)formPath toIndexPath:(NSIndexPath *)toPath{
    CategoryModel *model = self.homeDataArray[formPath.row];
    //先把移动的这个model移除
    [self.homeDataArray removeObject:model];
    //再把这个移动的model插入到相应的位置
    [self.homeDataArray insertObject:model atIndex:toPath.row];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        return headerView;
    }else{
        CollectionReusableFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        return footerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kFBaseWidth, collectionReusableViewH);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kFBaseWidth, 0.5);
}

- (void)btnClick:(UIButton *)sender event:(id)event{
//    //获取点击button的位置
//    NSSet *touches = [event allTouches];
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPoint = [touch locationInView:self.appCollectionView];
//    NSLog(@"currentPoint-----%f-----%f",currentPoint.x,currentPoint.y);
//    NSIndexPath *indexPath = [self.appCollectionView indexPathForItemAtPoint:currentPoint];
//    if (indexPath.section == 0 && indexPath != nil) { //点击移除
//        [self.appCollectionView performBatchUpdates:^{
//            [self.appCollectionView deleteItemsAtIndexPaths:@[indexPath]];
//            [self.homeDataArray removeObjectAtIndex:indexPath.row]; //删除
//        } completion:^(BOOL finished) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.appCollectionView reloadData];
//            });
//        }];
//    } else if (indexPath != nil) { //点击添加
//        //在第一组最后增加一个
//        [self.homeDataArray addObject:self.groupArray[indexPath.row]];
//        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.homeDataArray.count - 1 inSection:0];
//        [self.appCollectionView performBatchUpdates:^{
//            [self.appCollectionView insertItemsAtIndexPaths:@[newIndexPath]];
//        } completion:^(BOOL finished) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.appCollectionView reloadData];
//            });
//        }];
//    }
}

- (void)setUpCategoryShowHomeAppViewWithDeleteApp:(CategoryShowHomeAppView *)deleteApp{
//    //获取点击button的位置
//    NSSet *touches = [event allTouches];
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPoint = [touch locationInView:self.appCollectionView];
//    NSLog(@"currentPoint-----%f-----%f",currentPoint.x,currentPoint.y);
//    NSIndexPath *indexPath = [self.appCollectionView indexPathForItemAtPoint:currentPoint];
//    if (indexPath.section == 0 && indexPath != nil) { //点击移除
//        [self.appCollectionView performBatchUpdates:^{
//            [self.appCollectionView deleteItemsAtIndexPaths:@[indexPath]];
//            [self.homeDataArray removeObjectAtIndex:indexPath.row]; //删除
//        } completion:^(BOOL finished) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.appCollectionView reloadData];
//            });
//        }];
//    } else if (indexPath != nil) { //点击添加
//        //在第一组最后增加一个
//        [self.homeDataArray addObject:self.groupArray[indexPath.row]];
//        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.homeDataArray.count - 1 inSection:0];
//        [self.appCollectionView performBatchUpdates:^{
//            [self.appCollectionView insertItemsAtIndexPaths:@[newIndexPath]];
//        } completion:^(BOOL finished) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.appCollectionView reloadData];
//            });
//        }];
//    }
}



@end

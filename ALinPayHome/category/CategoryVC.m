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
#import "CollectionReusableHeaderView.h"
#import "CollectionReusableFooterView.h"
#import "CategoryHomeShowAppCell.h"

#import "CategoryCollectionViewLayout.h"
#import "CategoryModel.h"

@interface CategoryVC ()<UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        CategoryHomeAppViewDelegate,
                        GategroyShowNavViewDelegate,
                        GategroyNavViewDelegate,
                        CategoryShowHomeAppViewDelegate,
                        CategoryHomeShowAppCellDelegate,
                        CategoryCollectionViewLayoutDelegate>
{
    CGFloat _showHomeAppViewH;
    CGFloat _appCollectionViewH;
}
@property (nonatomic, strong) NSMutableArray *homeDataArray;


@property (nonatomic, strong) UIScrollView *categoryScrollView;
@property (nonatomic, strong) CategoryShowHomeAppView *showHomeAppView;
@property (nonatomic, strong) CategoryHomeAppView *homeAppView;
@property (nonatomic, strong) GategroyNavView *navView;
@property (nonatomic, strong) GategroyShowNavView *showNavView;
@property (nonatomic, strong) UICollectionView *appCollectionView;
@property (nonatomic, strong) CategoryCollectionViewLayout *layout;
@property (nonatomic, assign) BOOL inEditState; //是否处于编辑状态
@property (nonatomic, strong) NSIndexPath *showHomeAppIndexPath;
@property (nonatomic, strong) NSIndexPath *showAppIndexPath;

@end

const CGFloat navViewH = 64;
const CGFloat homeAppViewH = 44;
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
    for (int i = 1; i <= 6; i++) {
        CategoryModel *model = [[CategoryModel alloc] init];
        model.title = [NSString stringWithFormat:@"支付宝%@", @(i)];
        [self.homeDataArray addObject:model];
        
    }
    for (int i = 0; i < 6; i++) {
        CategoryModel *model = [[CategoryModel alloc] init];
        model.title = [NSString stringWithFormat:@"生活%@", @(i)];
        [self.groupArray addObject:model];
        [self.homeDataArray addObject:model];
    }
}

- (UIScrollView *)categoryScrollView{
    if (_categoryScrollView == nil) {
        self.categoryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navViewH, kFBaseWidth, kFBaseHeight-navViewH)];
        self.categoryScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.view addSubview:self.categoryScrollView];
        self.categoryScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _categoryScrollView;
}

- (CategoryCollectionViewLayout *)layout{
    if (_layout == nil) {
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
    }
    return _layout;
}

- (UICollectionView *)appCollectionView{
    if (_appCollectionView == nil) {
        self.appCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, homeAppViewH+spacing, kFBaseWidth, _appCollectionViewH) collectionViewLayout:self.layout];
        [self.categoryScrollView addSubview:self.appCollectionView];
        self.appCollectionView.backgroundColor = [UIColor whiteColor];
        self.appCollectionView.delegate = self;
        self.appCollectionView.dataSource = self;
        CGFloat appCollectionH = self.appCollectionView.collectionViewLayout.collectionViewContentSize.height;
        _appCollectionViewH = appCollectionH + (homeAppViewH+spacing);
        self.appCollectionView.frame = CGRectMake(0, homeAppViewH+spacing, kFBaseWidth, _appCollectionViewH);
        self.categoryScrollView.contentSize = CGSizeMake(0, _appCollectionViewH);
    }
    return _appCollectionView;
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
    
    self.homeAppView = [CategoryHomeAppView createWithXib];
    self.homeAppView.frame= CGRectMake(0, 0, kFBaseWidth, homeAppViewH);
    [self.categoryScrollView addSubview:self.homeAppView];
    self.homeAppView.delegate = self;
    
    self.showHomeAppView = [CategoryShowHomeAppView createWithXib];
    self.showHomeAppView.homeAppArray = self.groupArray;
    [self.categoryScrollView addSubview:self.showHomeAppView ];
    self.showHomeAppView.alpha = 0;
    self.showHomeAppView.delegate = self;
    
    
    [self.appCollectionView  registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryHomeShowAppCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
    [self.appCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionReusableHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [self.appCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionReusableFooterView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
}

#pragma mark CategoryHomeAppViewDelegate
// 编辑
- (void)categoryHomeAppViewWithEdit:(CategoryHomeAppView *)edit{
    [self showSubView:NO];
    self.inEditState = YES;
    self.appCollectionView.allowsSelection = NO;
    [self.layout setInEditState:self.inEditState];
}

#pragma mark GategroyShowNavViewDelegate
// 取消
- (void)setUpGategroyShowNavViewWithCancel{
    [self showSubView:YES];
    self.inEditState = NO;
    [self.layout setInEditState:self.inEditState];
    self.appCollectionView.allowsSelection = YES;
}

// 完成
- (void)setUpGategroyShowNavViewWithComplete{
    [self showSubView:YES];
    self.inEditState = NO;
    [self.layout setInEditState:self.inEditState];
    self.appCollectionView.allowsSelection = YES;
    if ([_delegate respondsToSelector:@selector(setUpMoreCategoryWithMoreArray:)]) {
        [_delegate setUpMoreCategoryWithMoreArray:self];
    }
    //此处可以调用网络请求，把排序完之后的传给服务端
    NSLog(@"点击了完成按钮");
}

#pragma mark GategroyNavViewDelegate
// 返回
- (void)setUpGategroyNavViewPopHomeVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showSubView:(BOOL)show{
    if (show) {
        [self setUpInteractivePopGestureRecognizerEnabled:YES scrollEnabled:NO];
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
                newFrame.size.height = _appCollectionViewH;
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
            [self setUphomeFunctionWithFrame];
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

- (void)setUphomeFunctionWithFrame{
    
    _showHomeAppViewH = self.showHomeAppView.collectionView.collectionViewLayout.collectionViewContentSize.height;
    if ( self.groupArray.count < 4) _showHomeAppViewH = 90;
    
    CGRect newFrame = self.appCollectionView.frame;
    newFrame.origin.y = _showHomeAppViewH + 44;
    newFrame.size.height = kFBaseHeight - (navViewH+spacing) - newFrame.origin.y;
    self.appCollectionView.frame = newFrame;
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
    [cell setDataAry:self.homeDataArray groupAry:self.groupArray indexPath:indexPath];
    //是否处于编辑状态，如果处于编辑状态，出现边框和按钮，否则隐藏
    cell.inEditState = self.inEditState;
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.inEditState) { //如果不在编辑状态
        NSLog(@"点击了第%@个分区的第%@个cell", @(indexPath.section), @(indexPath.row));
    }
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
    return CGSizeMake(kFBaseWidth, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kFBaseWidth, 0.5);
}

//删除
- (void)setUpCategoryShowHomeAppViewWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp event:(id)event{
    // 获取点击button的位置
    if (self.showHomeAppView.homeAppArray.count <= 3){
        NSLog(@"首页最少添加3个应用");
    }else{
        NSSet *touches = [event allTouches];
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.showHomeAppView.collectionView];
        NSIndexPath *indexPath = [self.showHomeAppView.collectionView indexPathForItemAtPoint:currentPoint];
        if (indexPath == nil) return;
        [self.showHomeAppView.collectionView performBatchUpdates:^{
            [self.showHomeAppView.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            [self.showHomeAppView.homeAppArray removeObjectAtIndex:indexPath.row];
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.showHomeAppView.collectionView reloadData];
                [self.appCollectionView reloadData];
                [UIView animateWithDuration:0.3 animations:^{
                    [self setUphomeFunctionWithFrame];
                }];
            });
        }];
    }
}

// 添加
- (void)setUpCategoryShowAppCellWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp event:(id)event{
    if (self.showHomeAppView.homeAppArray.count >= 11){
        NSLog(@"首页最多添加11个应用");
    }else{
        NSSet *touches = [event allTouches];
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.appCollectionView];
        NSIndexPath *indexPath = [self.appCollectionView indexPathForItemAtPoint:currentPoint];
        [self.showHomeAppView.homeAppArray addObject:self.homeDataArray[indexPath.row]];
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.showHomeAppView.homeAppArray.count - 1 inSection:0];
        [self.showHomeAppView.collectionView performBatchUpdates:^{
            [self.showHomeAppView.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
        } completion:^(BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.showHomeAppView.collectionView reloadData];
                [self.appCollectionView reloadData];
                [UIView animateWithDuration:0.3 animations:^{
                    [self setUphomeFunctionWithFrame];
                }];
            });
        }];
    }
}



- (void)setUpCategoryShowHomeAppViewWithDragChangeItem:(CategoryShowHomeAppView *)Item index:(NSIndexPath *)index toIndexPath:(NSIndexPath *)toIndexPath{
    BOOL canChange = self.showHomeAppView.homeAppArray.count > index.item && self.showHomeAppView.homeAppArray.count > toIndexPath.item;
    if (canChange) {
        [self handleDatasourceExchangeWithSourceIndexPath:index destinationIndexPath:toIndexPath];
    }
    
}

- (void)handleDatasourceExchangeWithSourceIndexPath:(NSIndexPath *)sourceIndexPath destinationIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSMutableArray *tempArr = [self.showHomeAppView.homeAppArray mutableCopy];
    
    NSInteger activeRange = destinationIndexPath.item - sourceIndexPath.item;
    BOOL moveForward = activeRange > 0;
    NSInteger originIndex = 0;
    NSInteger targetIndex = 0;
    
    for (NSInteger i = 1; i <= labs(activeRange); i ++) {
        
        NSInteger moveDirection = moveForward?1:-1;
        originIndex = sourceIndexPath.item + i*moveDirection;
        targetIndex = originIndex  - 1*moveDirection;
        
        [tempArr exchangeObjectAtIndex:originIndex withObjectAtIndex:targetIndex];
    }
    self.showHomeAppView.homeAppArray = [tempArr mutableCopy];
    self.groupArray = [tempArr mutableCopy];
}

#define mark CategoryCollectionViewLayoutDelegate

- (void)didChangeEditState:(BOOL)inEditState{
    self.inEditState = inEditState;
    for (CategoryHomeShowAppCell *cell in self.appCollectionView.visibleCells) {
        cell.inEditState = inEditState;
    }
}

- (void)moveItemAtIndexPath:(NSIndexPath *)formPath toIndexPath:(NSIndexPath *)toPath{
    CategoryModel *model = self.homeDataArray[formPath.row];
    [self.homeDataArray removeObject:model];
    [self.homeDataArray insertObject:model atIndex:toPath.row];
}

@end

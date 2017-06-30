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
                                    CategoryHomeShowAppCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *homeAppView;

@end

static NSString *const cellId = @"ShowHomeAppView";

@implementation CategoryShowHomeAppView

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
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryHomeShowAppCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
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
    return cell;
}

- (void)setUpCategoryHomeShowAppCellWithDeleteApp:(CategoryHomeShowAppCell *)deleteApp event:(id)event{

    NSLog(@"========%@",event);
    if ([_delegate respondsToSelector:@selector(setUpCategoryShowHomeAppViewWithDeleteApp: event:)]) {
        [_delegate setUpCategoryShowHomeAppViewWithDeleteApp:self event:event];
    }
}
@end

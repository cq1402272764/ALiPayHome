//
//  HomeClassificationView.h
//  YTOHome
//
//  Created by Qing Chang on 2017/6/7.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleImageBtn.h"

@interface HomeClassificationView : UIView
@property (weak, nonatomic) IBOutlet TitleImageBtn *scanBtn;
@property (weak, nonatomic) IBOutlet TitleImageBtn *paymentBtn;
@property (weak, nonatomic) IBOutlet TitleImageBtn *collectMoneyBtn;
@property (weak, nonatomic) IBOutlet TitleImageBtn *cardPackageBtn;

+ (instancetype)nibView;
@end

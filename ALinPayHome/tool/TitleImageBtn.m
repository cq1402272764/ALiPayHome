//
//  TitleImageBtn.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/7.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "TitleImageBtn.h"

@implementation TitleImageBtn

+ (instancetype)titleImageButtons{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY = 20;
    CGFloat imageX = (contentRect.size.width-30)/2;
    CGFloat imageW = contentRect.size.width/3;
    CGFloat imageH = contentRect.size.height/3;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * 2 / 3 - 10;
    CGFloat titleX = (contentRect.size.width-30)/2;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height / 3;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end

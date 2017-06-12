//
//  ViewController.m
//  YTOHome
//
//  Created by Qing Chang on 2017/6/7.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "ViewController.h"
#import "HomeVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HomeVC *home = [[HomeVC alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}


@end

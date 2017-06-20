//
//  CategoryHomeShowAppCell.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryHomeShowAppCell.h"

@implementation CategoryHomeShowAppCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.signBtn.layer.cornerRadius = 7.5;
}

- (IBAction)deleteApp {
    if ([_delegate respondsToSelector:@selector(setUpCategoryHomeShowAppCellWithDeleteApp:)]) {
        [_delegate setUpCategoryHomeShowAppCellWithDeleteApp:self];
    }
}


@end

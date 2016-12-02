//
//  EaseBubbleView+CusToM.m
//  huanxinDemo
//
//  Created by jefactoria on 16/10/24.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "EaseBubbleView+CusToM.h"

@implementation EaseBubbleView (CusToM)
- (void)setupUserBubbleView{
    
    UIView *big = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    big.backgroundColor = [UIColor redColor];
    [self.backgroundImageView addSubview:big];
    
    
    
}

- (void)updateUserMargin:(UIEdgeInsets)margin{
    
    
    [self removeConstraints:self.marginConstraints];
    [self setupUserBubbleView];
    
}

@end

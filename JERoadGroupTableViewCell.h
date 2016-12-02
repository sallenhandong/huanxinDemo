//
//  JERoadGroupTableViewCell.h
//  huanxinDemo
//
//  Created by jefactoria on 16/10/20.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JERoadGroupTableViewCell;
@protocol JERoadGroupTableViewCellDelegate <NSObject>

@optional
- (void)tableViewCell:(JERoadGroupTableViewCell *)cell didClickBtn:(UIButton *)button;
@end

@interface JERoadGroupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tittle;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIButton *lookMore;
@property (weak, nonatomic) id <JERoadGroupTableViewCellDelegate>  delgate;

@end

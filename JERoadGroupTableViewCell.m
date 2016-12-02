//
//  JERoadGroupTableViewCell.m
//  huanxinDemo
//
//  Created by jefactoria on 16/10/20.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "JERoadGroupTableViewCell.h"

@implementation JERoadGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)lookMoreMessage:(id)sender {
    
    
    if ([self.delgate respondsToSelector:@selector(tableViewCell:didClickBtn:)]) {
        [self.delgate tableViewCell:self didClickBtn:self.lookMore];
    }
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

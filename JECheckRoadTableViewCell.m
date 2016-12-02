//
//  JECheckRoadTableViewCell.m
//  huanxinDemo
//
//  Created by jefactoria on 16/10/24.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "JECheckRoadTableViewCell.h"

@implementation JECheckRoadTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImage.clipsToBounds = YES;
    self.headImage.layer.cornerRadius = 20;
    
    
}
- (IBAction)agree:(id)sender {
    
    
    
    if ([self.delgate respondsToSelector:@selector(tableViewCell:agreeRoad:)]) {
        [self.delgate tableViewCell:self agreeRoad:sender];
    }
    
    
    
}
- (IBAction)look:(id)sender {
    
    if ([self.delgate respondsToSelector:@selector(tableViewCell:lookRoad:)]) {
        [self.delgate tableViewCell:self lookRoad:sender];
    }
    
    
}
- (IBAction)cancel:(id)sender {
    
    if ([self.delgate respondsToSelector:@selector(tableViewCell:cancelRoad:)]) {
        [self.delgate tableViewCell:self cancelRoad:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

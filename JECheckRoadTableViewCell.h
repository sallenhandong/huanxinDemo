//
//  JECheckRoadTableViewCell.h
//  huanxinDemo
//
//  Created by jefactoria on 16/10/24.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JECheckRoadTableViewCell;
@protocol JECheckRoadTableViewCellDelegate <NSObject>

@optional
- (void)tableViewCell:(JECheckRoadTableViewCell *)cell agreeRoad:(UIButton *)button;

- (void)tableViewCell:(JECheckRoadTableViewCell *)cell lookRoad:(UIButton *)button;

- (void)tableViewCell:(JECheckRoadTableViewCell *)cell cancelRoad:(UIButton *)button;
@end


@interface JECheckRoadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic,strong) NSString *Id;
@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;
@property (weak, nonatomic) id <JECheckRoadTableViewCellDelegate> delgate;
@end

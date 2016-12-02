//
//  GroupChatViewController.m
//  huanxinDemo
//
//  Created by jefactoria on 16/9/26.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "GroupChatViewController.h"
#import "ChatViewController.h"
#import "GroupListCell.h"
@interface GroupChatViewController (){

  NSArray *arrGroup;
}

@end

@implementation GroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的群";
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(btnCreateGroup:)];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    //获取所有的群
    [[EMClient sharedClient].groupManager getJoinedGroupsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        
        arrGroup = [NSArray arrayWithArray:aList];
        [self.tableView reloadData];
        
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellIdentifier = @"CELL";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    static NSString *reuseIdetify = @"GroupListCell";
    GroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdetify owner:self options:nil] lastObject];
    }

    EMGroup *group = arrGroup[indexPath.row];
    cell.nicknameLabel.text = group.subject;
    cell.detail.text = group.description;
    
    return cell;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;

}
#pragma mark - Private Menthods

//新建一个群
- (void)btnCreateGroup:(id)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

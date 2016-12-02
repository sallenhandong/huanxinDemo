//
//  FriendViewController.m
//  huanxinDemo
//
//  Created by jefactoria on 16/9/26.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "FriendViewController.h"
#import "EMClient.h"
#import "GroupListCell.h"
#import "YunChatListCell.h"
#import "ApplyViewController.h"

@interface FriendViewController ()<UITableViewDelegate,UITableViewDataSource,EMContactManagerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic,strong) NSMutableArray      *groupArry;             //所有群
@property (nonatomic,strong) NSMutableArray      *friendsArry;           //所有好友
@property (nonatomic,strong) NSMutableArray      *blackListArry;         //黑名单
@property (nonatomic,strong) NSMutableDictionary *stateDict;             //分组状态
@property (nonatomic,strong) NSMutableArray      *addFriendsApply;       //好友请求通知
@property (nonatomic,strong)FriendViewController *mainVc;
@end

@implementation FriendViewController


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"联系人";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.tabBarController.navigationItem.rightBarButtonItem = rightBtn;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arry = [[NSUserDefaults standardUserDefaults] objectForKey:@"AddFriendsApply"];
    if(arry.count > 0){
        [self.addFriendsApply addObjectsFromArray:arry];
    }
    
    [self.stateDict setObject:@"0" forKey:@"1"];
    [self.stateDict setObject:@"0" forKey:@"2"];
    [self.stateDict setObject:@"0" forKey:@"3"];
    
    [self reloadDataNews];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDE, HIGH-114) style:UITableViewStylePlain];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
}
//获取群和好友列表
- (void)reloadDataNews{
    [self.friendsArry removeAllObjects];
    [self.groupArry removeAllObjects];
    [self.blackListArry removeAllObjects];
    
    //好友列表
    EMError *error = nil;
    NSArray *buddyListB = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
        NSLog(@"获取成功 --%@ ",buddyListB);
    }
    [_friendsArry addObjectsFromArray:buddyListB];
    
    //黑名单列表
    NSArray *blockedList = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error];
    if (!error) {
        NSLog(@"获取成功 --```````%ld ",blockedList.count);
    }
    //群组列表
    NSArray *roomsList = [[EMClient sharedClient].groupManager getJoinedGroups];
    [_groupArry addObjectsFromArray:roomsList];
    
    //移除好友列表中加入了黑名单的人
    for (int i=0; i<blockedList.count; i++) {
        for (int y=0; y<_friendsArry.count; y++) {
            NSString *buddy1 = blockedList[i];
            NSString *buddy2 = _friendsArry[y];
        
            if([buddy1 isEqualToString:buddy2]){
                //将黑名单的人的资料添加到黑名单数组
                [_blackListArry addObject:buddy2];
                //移除好友数组中加入了黑名单的人
                [_friendsArry removeObjectAtIndex:y];
                break;
            }
        }
    }
}

#pragma -mark  设置表视图中分区的数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDE, 40)];
    view.backgroundColor = [UIColor whiteColor];
    view.tag = section;
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
    [view addSubview:headImageView];
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, WIDE-50, 40)];
    labTitle.font = [UIFont systemFontOfSize:15];
    [view addSubview:labTitle];
    
    UILabel *llabF = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.7, WIDE, 0.3)];
    llabF.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    [view addSubview:llabF];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionView:)];
    [view addGestureRecognizer:tap];
    
    if(section == 1){
        labTitle.text = @"我的好友";
    }else if(section == 2){
        labTitle.text = @"我的群组";
    }else if(section == 3){
        labTitle.text = @"黑名单";
    }
    
    NSString *key = [NSString stringWithFormat:@"%tu",section];
    NSString *state = [self.stateDict objectForKey:key];
    if([state isEqualToString:@"0"]){
        headImageView.image = [UIImage imageNamed:@"iconfont-yousanjiao"];
    }else{
        headImageView.image = [UIImage imageNamed:@"iconfont-sanjiao"];
    }
    
    return view;
}

#pragma -mark 设置分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0.00001;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return 20;
    }
    return 0.000001;
}

#pragma -mark 设置每个分区的单元格数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }
    
    NSString *key = [NSString stringWithFormat:@"%tu",section];
    NSString *state = [self.stateDict objectForKey:key];
    if([state isEqual:@"0"]){
        return 0;
    }else{
        if(section == 1){
            return _friendsArry.count;
        }else if(section == 2){
            return _groupArry.count;
        }else if(section == 3){
            return _blackListArry.count;
        }else{
            return 0;
        }
    }
}

#pragma -mark 设置分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma -mark  cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        
        static NSString *reuseIdetify = @"GroupListCell";
        GroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (cell ==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdetify owner:self options:nil] lastObject];
        }
        cell.nicknameLabel.text = @"申请与通知";
        cell.headImageView.image = [UIImage imageNamed:@"newFriends"];
        cell.detail.hidden = YES;
        if(self.addFriendsApply.count > 0){
            cell.detail.hidden = NO;
        }
        cell.detail.text = [NSString stringWithFormat:@"%tu",self.addFriendsApply.count];
        return cell;
        
    }else if(indexPath.section == 2){
        
        static NSString *reuseIdetify = @"GroupListCell";
        GroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (cell ==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdetify owner:self options:nil] lastObject];
        }
        cell.detail.hidden = YES;
        EMGroup *group = _groupArry[indexPath.row];
        cell.nicknameLabel.text = group.groupId;
        return cell;
        
    }else{
        
        static NSString *reuseIdetify = @"YunChatListCell";
        YunChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (cell ==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdetify owner:self options:nil] lastObject];
        }
        if(indexPath.section == 1){
            NSString *buddy = _friendsArry[indexPath.row];
            cell.nicknameLabel.text = buddy;
            cell.signatureLabel.text = @"夕阳无限好,只是近黄昏";
        }else if(indexPath.section == 3){
          
            NSString *buddy = _blackListArry[indexPath.row];
            cell.nicknameLabel.text = buddy;
            cell.signatureLabel.text = @"维多利亚的多尔波斯克鲁里拉山.";
        }
        return cell;
        
    }
}

#pragma -mark  选中cell后，cell颜色变化
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    //设置cell选中的效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    NSString *chatter;
//    BOOL flag;
    if(indexPath.section == 0){
       ApplyViewController *applyandnotice = [[ApplyViewController alloc] init];
        [self.navigationController pushViewController:applyandnotice animated:YES];
}
    
//    }else if(indexPath.section == 1){
//        NSString *buddy = _friendsArry[indexPath.row];
//        chatter = buddy;
//        flag = NO;
//        
//        NSLog(@"``````");
//        
//    }else if(indexPath.section == 2){
//        EMGroup *group = _groupArry[indexPath.row];
//        chatter = group.groupId;
//        flag = YES;
//    }else{
//        return;
//    }
//
//     *chat = [[ChatController alloc] initWithChatter:chatter isGroup:flag];
//    [self.navigationController pushViewController:chat animated:YES];
}

//当在Cell上滑动时会调用此函数
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 || indexPath.section == 2)
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;
}

//对选中的Cell根据editingStyle进行操作
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSString *str;
        if(indexPath.section == 1)
            str = @"是否删除该好友?";
        else
            str = @"是否退出该群?";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = indexPath.section*100000 + indexPath.row;
        [alertView show];
    }
}

#pragma -mark UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex == 1){
//        NSInteger section = alertView.tag / 100000;
//        NSInteger row = alertView.tag % 100000;
//        if(section == 1){
//            EMBuddy *buddy = _friendsArry[row];
//            EMError *error = nil;
//            // 删除好友
//            BOOL isSuccess = [[EaseMob sharedInstance].chatManager removeBuddy:buddy.username removeFromRemote:YES error:&error];
//            if (isSuccess && !error) {
//                NSLog(@"删除成功");
//                [self didRemoveFirend:buddy.username];
//            }
//        }else if (section == 2){
//            EMGroup *group = _groupArry[row];
//            EMError *error = nil;
//            [[EaseMob sharedInstance].chatManager leaveGroup:group.groupId error:&error];
//            if (!error) {
//                NSLog(@"退出群组成功");
//                [self didRemoveFirend:group.groupId];
//            }
//        }
//    }
//}

- (void)sectionView:(UITapGestureRecognizer *)tap{
    NSString *key = [NSString stringWithFormat:@"%tu",tap.view.tag];
    NSString *state = [self.stateDict objectForKey:key];
    if([state isEqualToString:@"0"]){
        [self.stateDict setObject:@"1" forKey:key];
    }else{
        [self.stateDict setObject:@"0" forKey:key];
    }
    [_tableView reloadData];
}


//群组列表变化后的回调
- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error{
    [self reloadDataNews];
    [_tableView reloadData];
}

//添加了好友时的回调
- (void)didAcceptedByBuddy:(NSString *)username{
    [self reloadDataNews];
    [_tableView reloadData];
}

//接受好友请求成功的回调
- (void)didAcceptBuddySucceed:(NSString *)username{
    NSArray *arry = [[NSUserDefaults standardUserDefaults] objectForKey:@"AddFriendsApply"];
    if(arry.count > 0){
        [self.addFriendsApply removeAllObjects];
        [self.addFriendsApply addObjectsFromArray:arry];
    }
    [self reloadDataNews];
    [_tableView reloadData];
}

//登录的用户被好友从列表中删除了
-(void)didRemovedByBuddy:(NSString *)username{
    [self reloadDataNews];
    [_tableView reloadData];
}

//将好友加到黑名单完成后的回调
- (void)didBlockBuddy:(NSString *)username error:(EMError *)pError{
    [self reloadDataNews];
    [_tableView reloadData];
}

//将好友移出黑名单完成后的回调
- (void)didUnblockBuddy:(NSString *)username error:(EMError *)pError{
    [self reloadDataNews];
    [_tableView reloadData];
}

//删除好友后
- (void)didRemoveFirend:(NSString *)username{
    [[EMClient sharedClient].chatManager deleteConversation:@"" isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError) {
        
        
        
    }];
    [self reloadDataNews];
    [_tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didRemoveFirendGroup" object:nil];
}

////接收到好友请求通知
//- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message{
//    NSDictionary *dict;
//    if(message){
//        dict = @{@"username":username,@"message":message};
//    }else{
//        dict = @{@"username":username};
//    }
//    [self.addFriendsApply addObject:dict];
//    [[NSUserDefaults standardUserDefaults] setObject:_addFriendsApply forKey:@"AddFriendsApply"];
//    [_tableView reloadData];
//}



- (NSMutableArray *)friendsArry{
    if(!_friendsArry){
        _friendsArry = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _friendsArry;
}

- (NSMutableArray *)blackListArry{
    if(!_blackListArry){
        _blackListArry = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _blackListArry;
}

- (NSMutableArray *)groupArry{
    if(!_groupArry){
        _groupArry = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _groupArry;
}

- (NSMutableDictionary *)stateDict{
    if(!_stateDict){
        _stateDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _stateDict;
}

- (NSMutableArray *)addFriendsApply{
    if(!_addFriendsApply){
        _addFriendsApply = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _addFriendsApply;
}





- (void)addFriend{
    //    AddFirendController *addFriend = [[AddFirendController alloc] init];
    //    [self.navigationController pushViewController:addFriend animated:YES];
}

-(void)dealloc{
    //移除好友回调
    [[EMClient sharedClient].contactManager removeDelegate:self];

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

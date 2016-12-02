//
//  createGroupViewController.m
//  huanxinDemo
//
//  Created by jefactoria on 16/9/27.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "createGroupViewController.h"
#import "EMGroupOptions.h"
@interface createGroupViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *arrFriends;
    NSMutableArray *arrSelected;

}
@property (strong, nonatomic) UITextField *textFieldName;
@property (strong, nonatomic) UITextView *textViewDes;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) UITableView *groupTabview;
@end

@implementation createGroupViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"创建群";
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupTabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDE, HIGH-130) style:UITableViewStylePlain];
    self.groupTabview.delegate = self;
    self.groupTabview.dataSource = self;
    [self.view addSubview:self.groupTabview];
    
    
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.center = self.groupTabview.center;
    _activityView.color = [UIColor blackColor];
    
    [self.view addSubview:_activityView];


    arrFriends = [[NSMutableArray alloc]init];
    arrSelected = [[NSMutableArray alloc]init];
    //好友列表
    EMError *error = nil;
    NSArray *buddyListB = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
        NSLog(@"获取成功 --%@ ",buddyListB);
        [arrFriends addObjectsFromArray:buddyListB];
    }
    
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(WIDE/2-50, self.groupTabview.center.y+10, 100, 20);
    [doneBtn setTitle:@"点击创建" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(createGroup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    
    
    
}
#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        
        return 40;
        
    }
    return 170.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDE, 170)];
        headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        self.textFieldName = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, WIDE-40, 50)];
        self.textFieldName.layer.borderWidth = 1.0;
        self.textFieldName.layer.borderColor = [UIColor grayColor].CGColor;
        self.textFieldName.backgroundColor = [UIColor whiteColor];
        self.textFieldName.placeholder = @"群聊名称";
        [headerView addSubview:self.textFieldName];
        
        
        self.textViewDes = [[UITextView alloc]initWithFrame:CGRectMake(20, 70, WIDE-40, 80)];
        self.textViewDes.layer.borderWidth = 1.0;
        self.textViewDes.layer.borderColor = [UIColor grayColor].CGColor;
        [headerView addSubview:self.textViewDes];
        
        return headerView;
    }
    
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, WIDE, 20)];
    
        UILabel *tittle = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WIDE, 20)];
        tittle.text = @"请选择群成员";
        tittle.textColor = [UIColor redColor];
        [headerView addSubview:tittle];
        
        
        
        
        
        return headerView;
    }
    else{
    
        return nil;
    
    }
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        return 0;
        
    }
    else{
        
        return arrFriends.count;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *eMBuddy = [arrFriends objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"这个人很帅%@",eMBuddy] ;
    cell.imageView.image = [UIImage imageNamed:@"head1"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return 40;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath]; //得到当前选中的cell
    
    if (cell.accessoryType  == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [arrSelected removeObject:[arrFriends objectAtIndex:indexPath.row]];
    }else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [arrSelected addObject:[arrFriends objectAtIndex:indexPath.row]];
    }
    
    NSLog(@"%ld",arrSelected.count);
}

-(void)createGroup{

    NSMutableArray *arrName = [[NSMutableArray alloc] init];
    for (NSString *eMBuddy in arrSelected ) {
        [arrName addObject:eMBuddy];
    }
   
    EMError *error = nil;
    EMGroupOptions *setting = [[EMGroupOptions alloc] init];
    setting.maxUsersCount = 500;
    setting.style = EMGroupStylePublicOpenJoin;// 创建不同类型的群组，这里需要才传入不同的类型
    EMGroup *group = [[EMClient sharedClient].groupManager createGroupWithSubject:self.textFieldName.text description:self.textViewDes.text invitees:arrName message:@"邀请您加入群组" setting:setting error:&error];
    if(!error){
        UIAlertController *alterController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"创建成功"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alterController animated:YES completion:nil];
        
        UIAlertAction *alterAction = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                [self.navigationController popViewControllerAnimated:YES];
                                                            }];
        [alterController addAction:alterAction];
        
       NSLog(@"创建成功 -- %@",group);
    }

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

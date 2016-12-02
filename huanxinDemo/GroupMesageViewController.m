//
//  GroupMesageViewController.m
//  huanxinDemo
//
//  Created by jefactoria on 16/9/26.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "GroupMesageViewController.h"
#import "ChatViewController.h"
#import "GroupChatViewController.h"
#import "createGroupViewController.h"
#import "GroupMessageViewController.h"
@interface GroupMesageViewController ()

@end

@implementation GroupMesageViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"群聊";
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(WIDE/2-100, 200, 200, 40);
    [sendBtn setTitle:@"开始群聊" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sendBtn.layer.borderWidth = 1.0;
    sendBtn.layer.borderColor = [UIColor redColor].CGColor;
    [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    
    UIButton *listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    listBtn.frame = CGRectMake(WIDE/2-100, 300, 200, 40);
    [listBtn setTitle:@"群聊列表" forState:UIControlStateNormal];
    [listBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    listBtn.layer.borderWidth = 1.0;
    listBtn.layer.borderColor = [UIColor redColor].CGColor;
    [listBtn addTarget:self action:@selector(groupList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listBtn];
    
    
    
    UIButton *createGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createGroupBtn.frame = CGRectMake(WIDE/2-100, 100, 200, 40);
    [createGroupBtn setTitle:@"创建群" forState:UIControlStateNormal];
    [createGroupBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    createGroupBtn.layer.borderWidth = 1.0;
    createGroupBtn.layer.borderColor = [UIColor redColor].CGColor;
    [createGroupBtn addTarget:self action:@selector(createMessageGroup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createGroupBtn];
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(WIDE/2-100, 400, 200, 40);
    [messageBtn setTitle:@"群消息" forState:UIControlStateNormal];
    [messageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    messageBtn.layer.borderWidth = 1.0;
    messageBtn.layer.borderColor = [UIColor redColor].CGColor;
    [messageBtn addTarget:self action:@selector(groupMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageBtn];
    
}
-(void)sendMessage{
    
    NSString *groupID = @"1476954352238";
    
    
    ChatViewController *vc=[[ChatViewController alloc]initWithConversationChatter:groupID conversationType:EMConversationTypeGroupChat];
    
    [self .navigationController pushViewController:vc animated:YES];
    
    
    
}

-(void)groupList{

    GroupChatViewController *vc = [[GroupChatViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];


}
-(void)createMessageGroup{

    createGroupViewController *vc = [[createGroupViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];




}
-(void)groupMessage{


    GroupMessageViewController *vc = [[GroupMessageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

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

//
//  GroupMessageViewController.m
//  huanxinDemo
//
//  Created by jefactoria on 16/10/20.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "GroupMessageViewController.h"
#import "JERoadGroupTableViewCell.h"
@interface GroupMessageViewController ()<UITableViewDataSource,UITableViewDelegate,JERoadGroupTableViewCellDelegate>
@property (nonatomic, strong)UITableView *groupTableView;
@property (nonatomic, strong)NSMutableArray *messageArr;
@property(nonatomic,strong)NSString *message;
@property (nonatomic, strong)NSMutableArray *messageFromArr;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation GroupMessageViewController


-(void)viewWillAppear:(BOOL)animated{



    [self getAllMessage];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self getGroupMessage];
    [self clipExtraCellLine];
    
    
}
-(void)getGroupMessage{
    
    
    self.messageArr = [[NSMutableArray alloc]init];
    self.messageFromArr = [[NSMutableArray alloc]init];
    self.groupTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 260, 200) style:UITableViewStylePlain];
    self.groupTableView.delegate = self;
    self.groupTableView.dataSource = self;
    [self.view addSubview:self.groupTableView];
    
    
 
    
    
}

-(void)getAllMessage{
    
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(getGroupMessageWithUser) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    
}
-(void)getGroupMessageWithUser{

    [self.messageFromArr removeAllObjects];
    [self.messageArr removeAllObjects];
    
    
    
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:@"1476954352238" type:EMConversationTypeGroupChat createIfNotExist:YES];
    
    
    [conversation loadMessagesStartFromId:nil count:5 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        
        
        [self didReceiveMessages:aMessages];
        
    }];


}

// 收到消息的回调，带有附件类型的消息可以用 SDK 提供的下载附件方法下载（后面会讲到）
- (void)didReceiveMessages:(NSArray *)aMessages
{
    
    
    
    
    for (EMMessage *message in aMessages) {
        EMMessageBody *msgBody = message.body;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
              // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;
             
                
                [self.messageFromArr addObject:message.from];
                [self.messageArr addObject:txt];
          
                [self.groupTableView reloadData];
                if (self.messageArr.count == 5) {
                    
                    [self.timer invalidate];
                    self.timer = nil;
                    
                }
                
                
            }
                break;
            case EMMessageBodyTypeImage:
            {
                // 得到一个图片消息body
                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"大图的secret -- %@"    ,body.secretKey);
                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
                
                
                // 缩略图sdk会自动下载
                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                NSLog(@"纬度-- %f",body.latitude);
                NSLog(@"经度-- %f",body.longitude);
                NSLog(@"地址-- %@",body.address);
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                // 音频sdk会自动下载
                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                NSLog(@"音频的secret -- %@"        ,body.secretKey);
                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
                NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                
                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"视频的secret -- %@"        ,body.secretKey);
                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
                NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                
                // 缩略图sdk会自动下载
                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeFile:
            {
                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"文件的secret -- %@"        ,body.secretKey);
                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"文件文件的下载状态 -- %lu"   ,body.downloadStatus);
            }
                break;
                
            default:
                break;
        }
    }
}
#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"JERoadGroupTableViewCell"];
    if (cell == nil) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"JERoadGroupTableViewCell" owner:self options:nil] lastObject];
    }
    
//    JERoadGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
    
    ((JERoadGroupTableViewCell *)cell).tittle.text  = self.messageFromArr[indexPath.row];
    ((JERoadGroupTableViewCell *)cell).message.text  = self.messageArr[indexPath.row];
    
    ((JERoadGroupTableViewCell *)cell).lookMore.hidden = YES;
    if (indexPath.row == 4 && self.messageArr.count == 5) {
        
       ((JERoadGroupTableViewCell *)cell).lookMore.hidden = NO;
        
        
    }
    ((JERoadGroupTableViewCell *)cell).selectionStyle = UITableViewCellSelectionStyleNone;
    ((JERoadGroupTableViewCell *)cell).delgate = self;
    return cell;
}

-(void)tableViewCell:(JERoadGroupTableViewCell *)cell didClickBtn:(UIButton *)button{


    NSLog(@"点击查看更多");


}

#pragma mark - 去处多余的分割线
- (void)clipExtraCellLine {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    self.groupTableView.tableFooterView = footerView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
    
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

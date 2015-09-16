//
//  MsgViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "MsgViewController.h"
#import "MsgInfoViewController.h"
#import "URLApi.h"

@interface MsgViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *isReadArray;
    NSMutableArray *msgTitleArray;
    NSMutableArray *msgArray;
    NSMutableArray *dateArray;
    NSMutableArray *msgIDArray;
    
    UITableView *table;
}
@end

@implementation MsgViewController

- (void)viewDidLoad {
    
    isReadArray = [[NSMutableArray alloc]init];
    msgTitleArray = [[NSMutableArray alloc]init];
    msgArray = [[NSMutableArray alloc]init];
    dateArray = [[NSMutableArray alloc]init];
    msgIDArray = [[NSMutableArray alloc]init];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
   table = [[UITableView alloc]initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height-66)];
    table.delegate = self;
    table.dataSource = self;
    [self setExtraCellLineHidden:table];
    table.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:table];
    [self GetUnReadmsg];
    [self initNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 导航条按钮功能实现

-(void)initNav
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    [navigationItem setTitle:@"消息"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBarTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    [self.view addSubview:navigationBar];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navigationItem.leftBarButtonItem = leftButton;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return msgArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7.5, 60, 60)];
        if ([[isReadArray objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
            imageView.image = [UIImage imageNamed:@""];
            imageView.backgroundColor = [UIColor redColor];
        }
        else
        {
            imageView.image = [UIImage imageNamed:@""];
            imageView.backgroundColor = [UIColor greenColor];
        }
        [cell.contentView addSubview:imageView];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, 150, 20)];
        titleLab.font = [UIFont systemFontOfSize:14.0f];
        titleLab.text = [msgTitleArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:titleLab];
        
        UILabel *dateLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-150, 10, 150, 20)];
        dateLab.font = [UIFont systemFontOfSize:10.0f];
        dateLab.textAlignment = NSTextAlignmentRight;
        dateLab.text = [dateArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:dateLab];
        
        UILabel *msgLab = [[UILabel alloc]initWithFrame:CGRectMake(85, 40, self.view.frame.size.width-100, 20)];
        msgLab.font = [UIFont systemFontOfSize:14.0f];
        msgLab.text = [msgArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:msgLab];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([[isReadArray objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
        [self SetNewsRead:[msgIDArray objectAtIndex:indexPath.row]];
        [isReadArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
    
    MsgInfoViewController *VC = [[MsgInfoViewController alloc]init];
    VC.msgTitle = [msgTitleArray objectAtIndex:indexPath.row];
    VC.msg = [msgArray objectAtIndex:indexPath.row];
    VC.date = [dateArray objectAtIndex:indexPath.row];
    [self presentViewController:VC animated:YES completion:nil];
    
}
-(void)GetUnReadmsg
{
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"isReadFlag\":0,\"categoryCode\":\"TK_Msg\",\"module\":\"TouKe\",\"pageIndex\":1,\"pageSize\":10}&Command=common/GetCommonLog",[self encodeToPercentEscapeString:authCode]];
    NSLog(@"http://passport.admin.3weijia.com/MNMNH.axd?%@",param);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         //将得到的NSData数据转换成NSString
         if (connectionError) {
             NSLog(@"网络不给力");
         }
         else
         {
             NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
             //将数据变成标准的json数据
             NSLog(@"%@",[self newJsonStr:str]);
             NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSDictionary *JSON = [dic objectForKey:@"JSON"];
             NSArray *ReturnList = [JSON objectForKey:@"ReturnList"];
             for (id returnlist in ReturnList) {
                 [isReadArray addObject:@"0"];
                 [msgTitleArray addObject:[returnlist objectForKey:@"Title"]];
                 [msgArray addObject:[returnlist objectForKey:@"Content"]];
                 [dateArray addObject:[returnlist objectForKey:@"PostTime"]];
                 [msgIDArray addObject:[returnlist objectForKey:@"ArticleId"]];
             }
        }
         [self GetReadmsg];
     }];
    
}
-(void)GetReadmsg
{
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"isReadFlag\":1,\"categoryCode\":\"TK_Msg\",\"module\":\"TouKe\",\"pageIndex\":1,\"pageSize\":10}&Command=common/GetCommonLog",[self encodeToPercentEscapeString:authCode]];
    NSLog(@"http://passport.admin.3weijia.com/MNMNH.axd?%@",param);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         //将得到的NSData数据转换成NSString
         if (connectionError) {
             NSLog(@"网络不给力");
         }
         else
         {
             NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             //将数据变成标准的json数据
             NSLog(@"%@",[self newJsonStr:str]);
             NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSDictionary *JSON = [dic objectForKey:@"JSON"];
             NSArray *ReturnList = [JSON objectForKey:@"ReturnList"];
             for (id returnlist in ReturnList) {
                 [isReadArray addObject:@"1"];
                 [msgTitleArray addObject:[returnlist objectForKey:@"Title"]];
                 [msgArray addObject:[returnlist objectForKey:@"Content"]];
                 [dateArray addObject:[returnlist objectForKey:@"PostTime"]];
                 [msgIDArray addObject:[returnlist objectForKey:@"ArticleId"]];
             }
         }
         [table reloadData];
     }];
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

- (NSString*)newJsonStr:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\"JSON\":\"" withString:@"\"JSON\":"];
    string = [string stringByReplacingOccurrencesOfString:@"}\"," withString:@"},"];
    string = [string stringByReplacingOccurrencesOfString:@"]\"," withString:@"],"];
    string = [string stringByReplacingOccurrencesOfString:@"\"JSON\":\"\\\"\\\"\"" withString:@"\"JSON\":\"\""];
    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\"JSON\":\"\"" withString:@"\"JSON\":\""];
    string = [string stringByReplacingOccurrencesOfString:@"\"\",\"ErrorMessage\"" withString:@"\",\"ErrorMessage\""];
    return string;
}

-(void)SetNewsRead:(NSString*)msgID
{
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"ArticleId\":\"%@\",\"module\":\"TouKe\"}&Command=common/SetNewsRead",[self encodeToPercentEscapeString:authCode],msgID];
    NSLog(@"http://passport.admin.3weijia.com/MNMNH.axd?%@",param);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         //将得到的NSData数据转换成NSString
         if (connectionError) {
             NSLog(@"网络不给力");
         }
         else
         {
             NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
             //将数据变成标准的json数据
             NSLog(@"%@",[self newJsonStr:str]);
             NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSDictionary *JSON = [dic objectForKey:@"JSON"];
           
         }
         [table reloadData];
     }];
    
}

@end

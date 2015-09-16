//
//  AlterNickNameViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "AlterNickNameViewController.h"
#import "URLApi.h"

@interface AlterNickNameViewController ()
{
    UITextField *field;
}
@end

@implementation AlterNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    field = [[UITextField alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 40)];
    field.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:field];
    
    [self initNav];
}

#pragma mark 导航条功能以及实现

-(void)initNav
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    [navigationItem setTitle:@"修改昵称"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBarTintColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    [self.view addSubview:navigationBar];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    navigationItem.rightBarButtonItem = rightButton;
    rightButton.tintColor = [UIColor blackColor];
}

-(void)back
{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save
{
    if ((field.text.length <= 1)||(field.text.length >= 17)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"昵称的长度必须为2-16个字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [field resignFirstResponder];
        return;
    }
    
    [self alertNickName];
}

#pragma mark 修改昵称网络请求

-(void)alertNickName
{
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"NickName\":\"%@\"}&Command=tuoke/TK_ModifyEmployeeInfo",[self encodeToPercentEscapeString:authCode],field.text];
    NSLog(@"http://passport.admin.3weijia.com/MNMNH.axd?command=tuoke?%@",param);
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
             NSData *newData = [str dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSString *JSON = [dic objectForKey:@"JSON"];
             if ([JSON isEqualToString:@"true"]) {
                 if (self.block) {
                     self.block(field.text);
                 }
                 [self dismissViewControllerAnimated:YES completion:nil];
            }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改密码失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }
         }
     }];
}

#pragma mark 数据修正

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

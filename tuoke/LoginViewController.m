//
//  LoginViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "URLApi.h"
#import "UMSocial.h"

@interface LoginViewController ()<UMSocialUIDelegate>
{
    UITextField *phoneField;
    UITextField *pwdField;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initView];
    [self initNav];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 导航条

-(void)initNav
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    [navigationItem setTitle:@"登录"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBarTintColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    [self.view addSubview:navigationBar];
}

#pragma mark 初始化界面

-(void)initView
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaultes arrayForKey:@"login"];
    NSString *name;
    NSString *pwd;
    if (array.count <= 0) {
        name = @"";
        pwd = @"";
    }
    else
    {
        
        name = [array objectAtIndex:0];
        pwd = [array objectAtIndex:1];
    }
    UIView *loginView =[[UIView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 81)];
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    
    phoneField = [[UITextField alloc]initWithFrame:CGRectMake(30, 5, self.view.frame.size.width-60, 30)];
    phoneField.text = name;
    phoneField.placeholder = @"账号";
    phoneField.borderStyle = UITextBorderStyleRoundedRect;
    phoneField.textAlignment = NSTextAlignmentLeft;
    phoneField.font = [UIFont systemFontOfSize:14.0f];
    [loginView addSubview:phoneField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 40.5, self.view.frame.size.width-15, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [loginView addSubview:lineView];
    
    
    pwdField = [[UITextField alloc]initWithFrame:CGRectMake(30, 45, self.view.frame.size.width-60, 30)];
    pwdField.borderStyle = UITextBorderStyleRoundedRect;
    pwdField.secureTextEntry = YES;
    pwdField.text = pwd;
    pwdField.placeholder = @"密码";
    pwdField.textAlignment = NSTextAlignmentLeft;
    pwdField.font = [UIFont systemFontOfSize:14.0f];
    [loginView addSubview:pwdField];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0];
    button.frame = CGRectMake(25, 185, self.view.frame.size.width-50, 50);
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:button.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = button.bounds;
    maskLayer1.path = maskPath1.CGPath;
    button.layer.mask = maskLayer1;
}

#pragma mark 用户登录
//qeknio 123123
-(void)login
{
    if ((phoneField.text.length <= 0)||(pwdField.text.length <= 0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或者密码为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=10.0;
    request.HTTPMethod=@"POST";
    
    NSString *authCode = @"OnxA/jxTBSM91jGmGyREdSjObIc4Z8d2hA/95UiyOSLBUSTAYHKq75hcxsHuN5VsKCJQqB6QpbSH77xgY9lWTBs0nNajsDLpfBAVdB0bqO+RrbEhCgms7bsfclnY+XFn";
   
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"account\":\"%@\",\"passWord\":\"%@\"}&Command=tuoke/TK_Login",[self encodeToPercentEscapeString:authCode],phoneField.text,pwdField.text];
    NSLog(@"http://passport.admin.3weijia.com/MNMNH.axd?command=tuoke?%@",param);
    
    
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         //将得到的NSData数据转换成NSString
         if (connectionError) {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alert show];
         }
         else
         {
             NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             //将数据变成标准的json数据
             NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSNumber *loginResult = [[dic objectForKey:@"JSON"]objectForKey:@"loginResult"];
             if (loginResult.intValue == 1) {
                 
                NSString *AuthCode = [[[dic objectForKey:@"JSON"]objectForKey:@"UserInfo"]objectForKey:@"AuthCode"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:AuthCode forKey:@"AuthCode"];
                 
                 NSArray *arr = [[NSArray alloc]initWithObjects:phoneField.text,pwdField.text, nil];
                 NSUserDefaults *userDefaul = [NSUserDefaults standardUserDefaults];
                 [userDefaul setObject:arr forKey:@"login"];
                 
                 ViewController *vc = [[ViewController alloc]init];
                 [self presentViewController:vc animated:YES completion:nil];
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或者密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }
         }
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
@end

//
//  StoreInfoViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "StoreInfoViewController.h"
#import "URLApi.h"

@interface StoreInfoViewController ()

@end

@implementation StoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //[self drawView];
    [self initNav];
    [self GetDeptDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    [navigationItem setTitle:@"门店详情"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBarTintColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    [self.view addSubview:navigationBar];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navigationItem.leftBarButtonItem = leftButton;

}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)drawView
{
    UIView *StoreView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 150)];
    StoreView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:StoreView];
    
    UILabel *storeBasicLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 20)];
    storeBasicLab.text = @"门店基本信息";
    [StoreView addSubview:storeBasicLab];
    storeBasicLab.textAlignment = NSTextAlignmentLeft;
    storeBasicLab.font = [UIFont systemFontOfSize:14.0f];
    
    UIView *storeLineView = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, self.view.frame.size.width-30, 1)];
    storeLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [StoreView addSubview:storeLineView];
    
    UIImageView *storeLogoImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 60, 60, 60)];
    storeLogoImage.image = [UIImage imageNamed:@"storelogo.png"];
    [StoreView addSubview:storeLogoImage];
    
    UILabel *storeNameLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 55, 200, 20)];
    storeNameLab.text = storeName;
    storeNameLab.textAlignment = NSTextAlignmentLeft;
    storeNameLab.font = [UIFont systemFontOfSize:16.0f];
    [StoreView addSubview:storeNameLab];
    
    UILabel *addressLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 80, 200, 15)];
    addressLab.text = address;
    addressLab.font = [UIFont systemFontOfSize:12.0f];
    addressLab.textAlignment = NSTextAlignmentLeft;
    [StoreView addSubview:addressLab];
    
    UILabel *bookInDateLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 100, 200, 15)];
    bookInDateLab.text = bookinDate;
    bookInDateLab.textAlignment = NSTextAlignmentLeft;
    bookInDateLab.font = [UIFont systemFontOfSize:12.0f];
    [StoreView addSubview:bookInDateLab];
    
    UILabel *setUpDateLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 120, 200, 15)];
    setUpDateLab.text = setUpDate;
    setUpDateLab.font = [UIFont systemFontOfSize:12.0f];
    setUpDateLab.textAlignment = NSTextAlignmentLeft;
    [StoreView addSubview:setUpDateLab];

    UILabel *storeStateLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-115, 120, 100, 20)];
    if (type == 0) {
        storeStateLab.text = @"已登记";
    }
    else if (type == 1)
    {
        storeStateLab.text = @"已开店";
    }
    else
    {
        storeStateLab.text = @"已充值";
    }
    storeStateLab.textAlignment = NSTextAlignmentRight;
    storeStateLab.textColor = [UIColor redColor];
    storeStateLab.font = [UIFont systemFontOfSize:12.0f];
    [StoreView addSubview:storeStateLab];
    
    UIView *storeManView = [[UIView alloc]initWithFrame:CGRectMake(0, 245, self.view.frame.size.width, 170)];
    storeManView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:storeManView];
    
    UILabel *storeManLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 20)];
    storeManLab.text = @"店主资料";
    [storeManView addSubview:storeManLab];
    storeManLab.textAlignment = NSTextAlignmentLeft;
    storeManLab.font = [UIFont systemFontOfSize:14.0f];
    
    UIView *storeManLineView = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, self.view.frame.size.width-30, 1)];
    storeManLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [storeManView addSubview:storeManLineView];
    
    UILabel *storeManNameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 55, 150, 30)];
    storeManNameLab.text = name;
    storeManNameLab.font = [UIFont systemFontOfSize:16.0f];
    storeManNameLab.textAlignment = NSTextAlignmentLeft;
    [storeManView addSubview:storeManNameLab];
    
    UILabel *storeManNPhoneLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 90, 150, 20)];
    storeManNPhoneLab.text = phone;
    storeManNPhoneLab.font = [UIFont systemFontOfSize:12.0f];
    [storeManView addSubview:storeManNPhoneLab];
    storeManNPhoneLab.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *storeManLineView2 = [[UIView alloc]initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 1)];
    storeManLineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [storeManView addSubview:storeManLineView2];
    
    UILabel *loginDateLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 140, 200, 20)];
    loginDateLab.text = [NSString stringWithFormat:@"上次登录时间:%@",lastLoginDate];
    loginDateLab.textColor = [UIColor redColor];
    loginDateLab.textAlignment = NSTextAlignmentLeft;
    loginDateLab.font = [UIFont systemFontOfSize:12.0f];
    [storeManView addSubview:loginDateLab];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0];
    button.frame = CGRectMake(self.view.frame.size.width-115, 115, 100, 30);
    [button setTitle:@"再次发送账号" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendAccout) forControlEvents:UIControlEventTouchUpInside];
    [storeManView addSubview:button];
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:button.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = button.bounds;
    maskLayer2.path = maskPath2.CGPath;
    button.layer.mask = maskLayer2;
}

#pragma mark 获取用户的基本信息

-(void)GetDeptDetail
{
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"deptid\":\"%@\"}&Command=tuoke/TK_GetDeptDetail",[self encodeToPercentEscapeString:authCode],self.deptid];
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
             NSNumber *Status = [JSON objectForKey:@"Status"];
             type = Status.intValue;
             storeName = [JSON objectForKey:@"DeptName"];
             address = [JSON objectForKey:@"Address"];
             bookinDate = [JSON objectForKey:@"CreateDate"];
             setUpDate = [JSON objectForKey:@"FirstLoginDate"];
             NSArray *array = [JSON objectForKey:@"EmployeeList"];
             if (array.count > 0) {
                 name = [[[JSON objectForKey:@"EmployeeList"]objectAtIndex:0]objectForKey:@"name"];
                 phone = [[[JSON objectForKey:@"EmployeeList"]objectAtIndex:0]objectForKey:@"mobile"];
                 lastLoginDate = [[[JSON objectForKey:@"EmployeeList"]objectAtIndex:0]objectForKey:@"lastLoginDate"];
             }
             
             
        }
         [self drawView];
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

-(void)sendAccout
{
    
}
@end

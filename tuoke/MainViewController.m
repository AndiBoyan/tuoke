//
//  MainViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "MainViewController.h"
#import "UserInfoViewController.h"
#import "BookInStoreViewController.h"
#import "LinkViewController.h"
#import "MsgViewController.h"
#import "GetTKerQjtListViewController.h"

#import "URLApi.h"

@interface MainViewController ()
{
    UIBarButtonItem *rightButton;
    UIImage *urlLoadImage;
    BOOL isFlashView;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    isFlashView = NO;
    rightButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"message.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(msg)];
    self.navigationItem.rightBarButtonItem = rightButton;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initData];
    [self drawView];
    [self GetEmployeeInfo];
}

-(void)msg
{
    MsgViewController *VC = [[MsgViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}
#pragma mark 初始化数据

-(void)initData
{
    userStateArray = @[@"已登记",@"已开店",@"已充值"];
    tuokeFuncArray = @[@"开始拓客",@"全景图",@"店铺演示"];
    tuokeFuncImageArray = @[@"start.png",@"link.png",@"move.png"];
}

#pragma mark 绘制界面

-(void)drawView
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 500)];
    scroll.backgroundColor = [UIColor clearColor];
    scroll.contentSize = CGSizeMake(0, 50);
    [self.view addSubview:scroll];
    
    UIImageView *infoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210)];
    infoIV.image = [UIImage imageNamed:@"background.png"];
    [scroll addSubview:infoIV];

    face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.frame = CGRectMake((self.view.frame.size.width-80)/2, 25, 80, 80);
    [face setImage:[[UIImage imageNamed:@"Face.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [face addTarget:self action:@selector(userInfoList) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:face];
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:face.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(40, 40)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = face.bounds;
    maskLayer1.path = maskPath1.CGPath;
    face.layer.mask = maskLayer1;
    
    
    userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 115, self.view.frame.size.width, 20)];
    userNameLab.textAlignment = NSTextAlignmentCenter;
    userNameLab.textColor = [UIColor whiteColor];
    userNameLab.font = [UIFont systemFontOfSize:14.0f];
    [scroll addSubview:userNameLab];
    
    UIView *stateView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 60)];
    stateView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f];
    [scroll addSubview:stateView];
    float w = self.view.frame.size.width/3;
    for (int i = 0; i < 3; i++) {
        UILabel *numOfLab = [[UILabel alloc]initWithFrame:CGRectMake(i*w, 10, w, 20)];
        numOfLab.textColor =[UIColor redColor];
        numOfLab.text =[userCountAry objectAtIndex:i];
        numOfLab.textAlignment = NSTextAlignmentCenter;
        numOfLab.font = [UIFont systemFontOfSize:13.0f];
        [stateView addSubview:numOfLab];
        if (i == 0) {
            stateLab1 = numOfLab;
        }
        else if (i == 1)
        {
            stateLab2 = numOfLab;
        }
        else
            stateLab3 = numOfLab;
        
        UILabel *stateOfLab = [[UILabel alloc]initWithFrame:CGRectMake(i*w, 30, w, 20)];
        stateOfLab.textColor =[UIColor whiteColor];
        stateOfLab.text = [userStateArray objectAtIndex:i];
        stateOfLab.textAlignment = NSTextAlignmentCenter;
        stateOfLab.font = [UIFont systemFontOfSize:13.0f];
        [stateView addSubview:stateOfLab];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((i+1)*w, 10, 1, 40)];
        view.backgroundColor =[UIColor whiteColor];
        [stateView addSubview:view];
    }
    
    UIView *expandView = [[UIView alloc]initWithFrame:CGRectMake(0, 230, self.view.frame.size.width, 160)];
    expandView.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:expandView];
    
    for (int i = 0; i < 3; i++) {
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((w*i)+(w-60)/2, 30, 59, 59);
        button.tag = 1000+i;
        [button setImage:[[UIImage imageNamed:[tuokeFuncImageArray objectAtIndex:i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
        [expandView addSubview:button];


        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*w, 100, w, 20)];
        label.text = [tuokeFuncArray objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0f];
        [expandView addSubview:label];
    }
}

#pragma mark 响应函数

-(void)userInfoList
{
    isFlashView = YES;
    UserInfoViewController *VC = [[UserInfoViewController alloc]init];
    VC.name = name;
    VC.faceImg = faceImage;
    VC.phone = phone;
    VC.nickName = nick;
    [self presentViewController:VC animated:YES completion:nil];
}

-(void)expand:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == 1000) {
        BookInStoreViewController *VC = [[BookInStoreViewController alloc]init];
        [self presentViewController:VC animated:YES completion:nil];
    }
    else if (btn.tag == 1001)
    {
        GetTKerQjtListViewController *vc = [[GetTKerQjtListViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        NSURL* url = [[ NSURL alloc ] initWithString :[URLApi storeUrl]];
       [[UIApplication sharedApplication ] openURL: url ];
    }
}

#pragma mark 获取用户的基本信息

-(void)GetEmployeeInfo
{
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\"}&Command=tuoke/TK_GetEmployeeInfo",[self encodeToPercentEscapeString:authCode]];
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
             userNameLab.text = [[dic objectForKey:@"JSON"]objectForKey:@"Name"];
             
             name = userNameLab.text;
             phone = [[dic objectForKey:@"JSON"]objectForKey:@"Mobile"];
             nick = [[dic objectForKey:@"JSON"]objectForKey:@"NickName"];
             userCountAry = [[NSMutableArray alloc]init];
             NSNumber *countDJSql =[[dic objectForKey:@"JSON"]objectForKey:@"countDJSql"];
             NSNumber *countKDSql = [[dic objectForKey:@"JSON"]objectForKey:@"countKDSql"];
             NSNumber *countCZSql = [[dic objectForKey:@"JSON"]objectForKey:@"countCZSql"];

             stateLab1.text = [NSString stringWithFormat:@"%d",countDJSql.intValue];
             stateLab2.text = [NSString stringWithFormat:@"%d",countKDSql.intValue];
             stateLab3.text = [NSString stringWithFormat:@"%d",countCZSql.intValue];
             
             NSString *UserHeadIcoPath = [[dic objectForKey:@"JSON"]objectForKey:@"UserHeadIcoPath"];
             NSString *imageURL = [NSString stringWithFormat:@"%@%@",[URLApi imageURL],UserHeadIcoPath];
             NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
             urlLoadImage = [UIImage imageWithData:imageData];
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
             NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"userface.png"]];   // 保存文件的名称
             ;
             UIImage *img = [UIImage imageWithContentsOfFile:filePath];
             if (img) {
                 [face setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                 faceImage = img;
             }
             else
             {
                 if (urlLoadImage) {
                [face setImage:[urlLoadImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                     faceImage = urlLoadImage;
                 }
                 else
                 {
                     [face setImage:[[UIImage imageNamed:@"Face.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                     faceImage = [UIImage imageNamed:@"Face.png"];

                 }
            }
         }
     }];
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

        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
        //将数据变成标准的json数据
        NSLog(@"%@",[self newJsonStr:str]);
        NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *JSON = [dic objectForKey:@"JSON"];
        NSArray *ReturnList = [JSON objectForKey:@"ReturnList"];
         if (ReturnList.count > 0) {
             rightButton.image = [[UIImage imageNamed:@"message1.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         }
         else
         {
             rightButton.image = [[UIImage imageNamed:@"message.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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

#pragma mark 头像是否更换

-(void)viewDidAppear:(BOOL)animated
{
    if (isFlashView) {
        //头像更换
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"userface.png"]];   // 保存文件的名称
        ;
        UIImage *img = [UIImage imageWithContentsOfFile:filePath];
        if (img) {
            [face setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            faceImage = img;
        }
        else
        {
            if (urlLoadImage) {
                [face setImage:[urlLoadImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                faceImage = urlLoadImage;
            }
            else
            {
                [face setImage:[[UIImage imageNamed:@"Face.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                faceImage = [UIImage imageNamed:@"Face.png"];
            }
        }
        [self GetUnReadmsg];
        isFlashView = NO;
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

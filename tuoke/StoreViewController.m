//
//  StoreViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreInfoViewController.h"
#import "BookInStoreViewController.h"
#import "URLApi.h"

@interface StoreViewController ()<UITextFieldDelegate>
{
    UITextField *searchField;
    UISegmentedControl *segment;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    UIBarButtonItem *backButton;
    UIBarButtonItem *donebutton;
    
    UIButton *haveDZButton;
    UIButton *notHaveDZButton;
    
    UIView *haveDZButtonView;
    UIView *notHaveDZButtonView;
    
    NSMutableArray *ShopImageAry;//店面照片
    NSMutableArray *DeptNameAry;//店面名称
    NSMutableArray *addressAry;//地址
    NSMutableArray *openDateAry;
    NSMutableArray *CreateDateAry;//登记日期
    NSMutableArray *DeptIdAry;//店面ID
    NSMutableArray *CategoryNameAry;
    
    UILabel *nullDataLab;
    NSString *storeType;
    NSString *isHaveDZString;
    int page;
}
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    storeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 105, self.view.frame.size.width, self.view.frame.size.height-155)];
    storeTableView.delegate = self;
    storeTableView.dataSource = self;
    storeTableView.backgroundColor = [UIColor clearColor];
    storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:storeTableView];
    
    segment = [[UISegmentedControl alloc]initWithItems:@[@"已登记",@"已开店",@"已充值"]];
    segment.frame = CGRectMake(0, 0, 200, 30);
    segment.backgroundColor = [UIColor clearColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"search.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.leftBarButtonItem = leftButton;
    rightButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"addcustomer.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = rightButton;
    backButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"cancle.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    donebutton  = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"search.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
    
    UIView *HaveDzView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 40)];
    HaveDzView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:HaveDzView];
    
    haveDZButton = [UIButton buttonWithType:UIButtonTypeCustom];
    haveDZButton.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
    haveDZButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [haveDZButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//此时选中
    haveDZButton.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 40);
    [haveDZButton setTitle:@"有店主" forState:UIControlStateNormal];
    haveDZButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [haveDZButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [haveDZButton setTintColor:[UIColor blackColor]];
    [haveDZButton addTarget:self action:@selector(haveDZ) forControlEvents:UIControlEventTouchUpInside];
    [HaveDzView addSubview:haveDZButton];
    
    haveDZButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 38, self.view.frame.size.width/2, 2)];
    haveDZButtonView.backgroundColor = [UIColor redColor];
    [HaveDzView addSubview:haveDZButtonView];
    
    notHaveDZButton = [UIButton buttonWithType:UIButtonTypeCustom];
    notHaveDZButton.showsTouchWhenHighlighted = YES;  //指定按钮被按下时发光
    notHaveDZButton.backgroundColor = [UIColor whiteColor];
    notHaveDZButton.frame = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 40);
    [notHaveDZButton setTitle:@"无店主" forState:UIControlStateNormal];
    notHaveDZButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [notHaveDZButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [notHaveDZButton addTarget:self action:@selector(notHaveDZ) forControlEvents:UIControlEventTouchUpInside];
    [HaveDzView addSubview:notHaveDZButton];
    
    notHaveDZButtonView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 38, self.view.frame.size.width/2, 2)];
    notHaveDZButtonView.backgroundColor = [UIColor redColor];
    notHaveDZButtonView.hidden = YES;
    [HaveDzView addSubview:notHaveDZButtonView];
    
    ShopImageAry = [[NSMutableArray alloc]init];
    DeptNameAry = [[NSMutableArray alloc]init];
    addressAry = [[NSMutableArray alloc]init];
    CreateDateAry = [[NSMutableArray alloc]init];
    DeptIdAry = [[NSMutableArray alloc]init];
    CategoryNameAry = [[NSMutableArray alloc]init];
    openDateAry = [[NSMutableArray alloc]init];
    
    storeType = @"-1,0,1";
    isHaveDZString = @"";
    page = 1;
    [self initYiRefreshHeader];
    [self initYiRefreshFooter];
}

-(void)haveDZ
{
    haveDZButtonView.hidden = NO;
    notHaveDZButtonView.hidden = YES;
    isHaveDZString = @"true";
    haveDZButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
    notHaveDZButton.backgroundColor = [UIColor whiteColor];
     page = 1;
    ShopImageAry = [[NSMutableArray alloc]init];
    DeptNameAry = [[NSMutableArray alloc]init];
    addressAry = [[NSMutableArray alloc]init];
    CreateDateAry = [[NSMutableArray alloc]init];
    DeptIdAry = [[NSMutableArray alloc]init];
    CategoryNameAry = [[NSMutableArray alloc]init];
    openDateAry = [[NSMutableArray alloc]init];
    [self getTKerDeptList:@"" shopState:storeType isHaveDz:@"true" page:page];
}
-(void)notHaveDZ
{
    isHaveDZString = @"false";
    haveDZButtonView.hidden = YES;
    notHaveDZButtonView.hidden = NO;
    haveDZButton.backgroundColor = [UIColor whiteColor];
    notHaveDZButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
     page = 1;
    ShopImageAry = [[NSMutableArray alloc]init];
    DeptNameAry = [[NSMutableArray alloc]init];
    addressAry = [[NSMutableArray alloc]init];
    CreateDateAry = [[NSMutableArray alloc]init];
    DeptIdAry = [[NSMutableArray alloc]init];
    CategoryNameAry = [[NSMutableArray alloc]init];
    openDateAry = [[NSMutableArray alloc]init];
    [self getTKerDeptList:@"" shopState:storeType isHaveDz:@"false" page:page];
}
//下拉刷新
-(void)initYiRefreshHeader
{
    // YiRefreshHeader  头部刷新按钮的使用
    refreshHeader=[[YiRefreshHeader alloc] init];
    refreshHeader.scrollView = storeTableView;
    [refreshHeader header];
    
    refreshHeader.beginRefreshingBlock=^(){
        // 后台执行：
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self getTKerDeptList:@"" shopState:storeType isHaveDz:isHaveDZString page:page];
        
        
            dispatch_async(dispatch_get_main_queue(), ^{
                // 主线程刷新视图
                //[self analyseRequestData];
                [storeTableView reloadData];
                [refreshHeader endRefreshing];
            });
        });
    };
    // 是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];
}

//上拉刷新
-(void)initYiRefreshFooter
{
    // YiRefreshFooter  底部刷新按钮的使用
    refreshFooter=[[YiRefreshFooter alloc] init];
    refreshFooter.scrollView=storeTableView;
    [refreshFooter footer];
    
    refreshFooter.beginRefreshingBlock=^(){
        // 后台执行：
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self getTKerDeptList:@"" shopState:storeType isHaveDz:isHaveDZString page:page];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 主线程刷新视图
                [storeTableView reloadData];
                [refreshFooter endRefreshing];
            });
        });
    };
}

-(void)search
{
    self.navigationItem.titleView = nil;
    self.navigationItem.title = nil;
    searchField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    searchField.borderStyle = UITextBorderStyleRoundedRect;
    searchField.font = [UIFont systemFontOfSize:14.0f];
    searchField.placeholder = @"关键字";
    searchField.delegate = self;
    searchField.returnKeyType = UIReturnKeyDone;
    
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.titleView = searchField;
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem = donebutton;
    
}

-(void)cancelAction
{
    self.navigationItem.titleView = segment;
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    ShopImageAry = [[NSMutableArray alloc]init];
    DeptNameAry = [[NSMutableArray alloc]init];
    addressAry = [[NSMutableArray alloc]init];
    CreateDateAry = [[NSMutableArray alloc]init];
    DeptIdAry = [[NSMutableArray alloc]init];
    CategoryNameAry = [[NSMutableArray alloc]init];
    openDateAry = [[NSMutableArray alloc]init];
    [self getTKerDeptList:@"" shopState:storeType isHaveDz:@"" page:1];
}

-(void)add
{
    BookInStoreViewController *VC = [[BookInStoreViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}
-(void)doneAction
{
    ShopImageAry = [[NSMutableArray alloc]init];
    DeptNameAry = [[NSMutableArray alloc]init];
    addressAry = [[NSMutableArray alloc]init];
    CreateDateAry = [[NSMutableArray alloc]init];
    DeptIdAry = [[NSMutableArray alloc]init];
    CategoryNameAry = [[NSMutableArray alloc]init];
    openDateAry = [[NSMutableArray alloc]init];
    [searchField resignFirstResponder];
    [self getTKerDeptList:searchField.text shopState:storeType isHaveDz:@"" page:1];
}
-(void)segmentChange:(UISegmentedControl*)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        haveDZButtonView.hidden = NO;
        notHaveDZButtonView.hidden = YES;
        isHaveDZString = @"";
        haveDZButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
        notHaveDZButton.backgroundColor = [UIColor whiteColor];
        storeType = @"-1,0,1";
        page = 1;
        ShopImageAry = [[NSMutableArray alloc]init];
        DeptNameAry = [[NSMutableArray alloc]init];
        addressAry = [[NSMutableArray alloc]init];
        CreateDateAry = [[NSMutableArray alloc]init];
        DeptIdAry = [[NSMutableArray alloc]init];
        CategoryNameAry = [[NSMutableArray alloc]init];
        openDateAry = [[NSMutableArray alloc]init];
        [storeTableView reloadData];
        [self getTKerDeptList:@"" shopState:@"-1,0,1" isHaveDz:@"" page:1];
    }
    else if (index == 1)
    {
        isHaveDZString = @"";
        haveDZButtonView.hidden = NO;
        notHaveDZButtonView.hidden = YES;
        haveDZButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
        notHaveDZButton.backgroundColor = [UIColor whiteColor];
        storeType = @"2";
        page = 1;
        ShopImageAry = [[NSMutableArray alloc]init];
        DeptNameAry = [[NSMutableArray alloc]init];
        addressAry = [[NSMutableArray alloc]init];
        CreateDateAry = [[NSMutableArray alloc]init];
        DeptIdAry = [[NSMutableArray alloc]init];
        CategoryNameAry = [[NSMutableArray alloc]init];
        openDateAry = [[NSMutableArray alloc]init];

        [self getTKerDeptList:@"" shopState:@"2" isHaveDz:@"" page:1];
    }
    else
    {
        isHaveDZString = @"";
        haveDZButtonView.hidden = NO;
        notHaveDZButtonView.hidden = YES;
        haveDZButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
        notHaveDZButton.backgroundColor = [UIColor whiteColor];
        storeType = @"3";
        page = 1;
        ShopImageAry = [[NSMutableArray alloc]init];
        DeptNameAry = [[NSMutableArray alloc]init];
        addressAry = [[NSMutableArray alloc]init];
        CreateDateAry = [[NSMutableArray alloc]init];
        DeptIdAry = [[NSMutableArray alloc]init];
        CategoryNameAry = [[NSMutableArray alloc]init];
        openDateAry = [[NSMutableArray alloc]init];

        [self getTKerDeptList:@"" shopState:@"3" isHaveDz:@"" page:1];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DeptNameAry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 150)];
        view.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:view.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = view.bounds;
        maskLayer1.path = maskPath1.CGPath;
        view.layer.mask = maskLayer1;
        [cell.contentView addSubview:view];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 60, 60)];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[ShopImageAry objectAtIndex:indexPath.row]]];
        if ([UIImage imageWithData:imageData]) {
           
            imageView.image = [UIImage imageWithData:imageData];
        }
        else
            imageView.image = [UIImage imageNamed:@"Face.png"];
        [view addSubview:imageView];
        
        UILabel *storeName = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 200, 20)];
        storeName.text = [DeptNameAry objectAtIndex:indexPath.row];
        storeName.textAlignment = NSTextAlignmentLeft;
        storeName.font = [UIFont systemFontOfSize:16.0f];
        [view addSubview:storeName];
        
        UILabel *addressLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 200, 15)];
        addressLab.text = [addressAry objectAtIndex:indexPath.row];
        addressLab.font = [UIFont systemFontOfSize:12.0f];
        addressLab.textAlignment = NSTextAlignmentLeft;
        [view addSubview:addressLab];
        
        UILabel *openDateLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, 200, 15)];
        openDateLab.text = [openDateAry objectAtIndex:indexPath.row];
        openDateLab.textAlignment = NSTextAlignmentLeft;
        openDateLab.font = [UIFont systemFontOfSize:12.0f];
        [view addSubview:openDateLab];
        
        UILabel *createDateLab = [[UILabel alloc]initWithFrame:CGRectMake(90, 80, 200, 15)];
        createDateLab.text = [CreateDateAry objectAtIndex:indexPath.row];
        createDateLab.font = [UIFont systemFontOfSize:12.0f];
        createDateLab.textAlignment = NSTextAlignmentLeft;
        [view addSubview:createDateLab];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width-20, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view addSubview:line];
        
        UILabel *storeStateLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 100, 20)];
        if ([storeType isEqualToString:@"3"]) {
            storeStateLab.text = @"已充值";
        }
        else if ([storeType isEqualToString:@"2"])
        {
            storeStateLab.text = @"已开店";
        }
        else
        {
            storeStateLab.text = @"已登记";
        }
        
        storeStateLab.textColor = [UIColor redColor];
        storeStateLab.textAlignment = NSTextAlignmentLeft;
        storeStateLab.font = [UIFont systemFontOfSize:12.0f];
        [view addSubview:storeStateLab];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    StoreInfoViewController *VC = [[StoreInfoViewController alloc]init];
    VC.deptid = [DeptIdAry objectAtIndex:indexPath.row];
    [self presentViewController:VC animated:YES completion:nil];
}
-(void)sendAccout
{
    NSLog(@"1");
}

-(void)getTKerDeptList:(NSString *)word shopState:(NSString*)state isHaveDz:(NSString*)isHaveDZ page:(int)pg
{
    [nullDataLab removeFromSuperview];
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"keyWord\":\"%@\",\"shopStatus\":\"%@\",\"isHasDZ\":\"%@\",\"orderBy\":\"\",\"pageIndex\":\"%d\",\"pageSize\":\"5\"}&Command=tuoke/GetTKerDeptList",[self encodeToPercentEscapeString:authCode],word,state,isHaveDZ,pg];
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
             NSLog(@"%@",[self newJsonStr:str]);
             NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSDictionary *JSON = [dic objectForKey:@"JSON"];
             NSArray *ReturnList = [JSON objectForKey:@"ReturnList"];
             for (id list in ReturnList) {
                 for (int i=0 ;i < DeptIdAry.count;i++)
                 {
                     if ([[DeptIdAry objectAtIndex:i]isEqualToString:[list objectForKey:@"DeptId"]])
                         return;
                 }

                 [DeptIdAry addObject:[list objectForKey:@"DeptId"]];
                 [ShopImageAry addObject:[NSString stringWithFormat:@"%@%@",[URLApi imageURL],[list objectForKey:@"ShopImage"]]];
                 [DeptNameAry addObject:[list objectForKey:@"DeptName"]];
                 [addressAry addObject:[list objectForKey:@"Address"]];
                 [openDateAry addObject:[list objectForKey:@"OpenDate"]];
                 [CreateDateAry addObject:[list objectForKey:@"CreateDate"]];
                 [CategoryNameAry addObject:[[[list objectForKey:@"ShopCates"]objectAtIndex:0]objectForKey:@"CategoryName"]];
                 
            }
             if (DeptIdAry.count <= 0) {
                 nullDataLab = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height/2)-15, self.view.frame.size.width, 30)];
                 nullDataLab.text = @"没有店铺信息";
                 nullDataLab.textAlignment = NSTextAlignmentCenter;
                 [self.view addSubview:nullDataLab];
             }
             page++;
             [storeTableView reloadData];
         }
        }
     ];
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

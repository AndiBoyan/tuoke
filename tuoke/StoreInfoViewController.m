//
//  StoreInfoViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "StoreInfoViewController.h"

@interface StoreInfoViewController ()

@end

@implementation StoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self drawView];
    [self initNav];
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
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 150)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 20)];
    lab1.text = @"门店基本信息";
    [view1 addSubview:lab1];
    lab1.textAlignment = NSTextAlignmentLeft;
    lab1.font = [UIFont systemFontOfSize:14.0f];
    
    UIView *line1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, self.view.frame.size.width-30, 1)];
    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view1 addSubview:line1];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 60, 60, 60)];
    image.image = [UIImage imageNamed:@"storelogo.png"];
    [view1 addSubview:image];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 55, 200, 20)];
    lab2.text = @"22222222";
    lab2.textAlignment = NSTextAlignmentLeft;
    lab2.font = [UIFont systemFontOfSize:16.0f];
    [view1 addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(90, 80, 200, 15)];
    lab3.text = @"1212121212121";
    lab3.font = [UIFont systemFontOfSize:12.0f];
    lab3.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(90, 100, 200, 15)];
    lab4.text = @"22222222";
    lab4.textAlignment = NSTextAlignmentLeft;
    lab4.font = [UIFont systemFontOfSize:12.0f];
    [view1 addSubview:lab4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(90, 120, 200, 15)];
    lab5.text = @"1212121212121";
    lab5.font = [UIFont systemFontOfSize:12.0f];
    lab5.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:lab5];

    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-115, 120, 100, 20)];
    lab6.text = @"已开店";
    lab6.textAlignment = NSTextAlignmentRight;
    lab6.textColor = [UIColor redColor];
    lab6.font = [UIFont systemFontOfSize:12.0f];
    [view1 addSubview:lab6];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 245, self.view.frame.size.width, 170)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 20)];
    lab7.text = @"店主资料";
    [view2 addSubview:lab7];
    lab7.textAlignment = NSTextAlignmentLeft;
    lab7.font = [UIFont systemFontOfSize:14.0f];
    
    UIView *line2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, self.view.frame.size.width-30, 1)];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view2 addSubview:line2];
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(15, 55, 150, 30)];
    lab8.text = @"12121";
    lab8.font = [UIFont systemFontOfSize:16.0f];
    lab8.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:lab8];
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(15, 90, 150, 20)];
    lab9.text = @"12212121221212";
    lab9.font = [UIFont systemFontOfSize:12.0f];
    [view2 addSubview:lab9];
    lab9.textAlignment = NSTextAlignmentLeft;
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(15, 120, self.view.frame.size.width-30, 1)];
    line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view2 addSubview:line3];
    
    UILabel *lab10 = [[UILabel alloc]initWithFrame:CGRectMake(15, 140, 100, 20)];
    lab10.text = @"100000000";
    lab10.textColor = [UIColor redColor];
    lab10.textAlignment = NSTextAlignmentLeft;
    lab10.font = [UIFont systemFontOfSize:12.0f];
    [view2 addSubview:lab10];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0];
    button.frame = CGRectMake(self.view.frame.size.width-130, 130, 115, 30);
    [button setTitle:@"再次发送账号" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendAccout) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:button];
    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:button.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = button.bounds;
    maskLayer2.path = maskPath2.CGPath;
    button.layer.mask = maskLayer2;
}

-(void)sendAccout
{
    
}
@end

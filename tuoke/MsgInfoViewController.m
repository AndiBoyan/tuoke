//
//  MsgInfoViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "MsgInfoViewController.h"

@interface MsgInfoViewController ()

@end

@implementation MsgInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, 200, 20)];
    titleLab.text = self.msgTitle;
    titleLab.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:titleLab];
    
    UILabel *dateLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 105, 200, 20)];
    dateLab.text = self.date;
    dateLab.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:dateLab];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 140, self.view.frame.size.width-30, 240)];
    [self.view addSubview:textView];
    textView.text = self.msg;
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:14.0f];
    textView.editable = NO;
    
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

@end

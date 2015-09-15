//
//  StoreNameViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/14.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "StoreNameViewController.h"

@interface StoreNameViewController ()
{
    UITextField *field;
}
@end

@implementation StoreNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    field = [[UITextField alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 40)];
    field.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:field];
    
    [self initNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav
{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    [navigationItem setTitle:@"门店全名"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBarTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    [self.view addSubview:navigationBar];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(bookIn)];
    navigationItem.rightBarButtonItem = rightButton;
    rightButton.tintColor = [UIColor blackColor];
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)bookIn
{
    
    if ((field.text.length <= 0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"店铺名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [field resignFirstResponder];
        return;
    }
    if (self.block) {
        self.block(field.text);
    }
   [self dismissViewControllerAnimated:YES completion:nil];
}


@end

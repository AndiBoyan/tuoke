//
//  ProfitViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "ProfitViewController.h"

@interface ProfitViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
}
@end

@implementation ProfitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, 325)];
    table.delegate = self;
    table.dataSource = self;
    [self setExtraCellLineHidden:table];
    table.scrollEnabled = NO;
    [self.view addSubview:table];
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
    [navigationItem setTitle:@"实际收益"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBarTintColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    [self.view addSubview:navigationBar];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navigationItem.leftBarButtonItem = leftButton;
}
//tableView 优化
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }
    else
        return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 20)];
            lab1.text = @"实际总收益(元)";
            lab1.font = [UIFont systemFontOfSize:12.0f];
            [cell.contentView addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 30)];
            lab2.text = @"18000.00";
            lab2.font = [UIFont boldSystemFontOfSize:20.0f];
            lab2.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:lab2];
        }
        
        else
        {
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 20)];
            lab1.text = @"111111111";
            lab1.font = [UIFont systemFontOfSize:12.0f];
            lab1.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, 150, 20)];
            lab2.text = @"111111111";
            lab2.font = [UIFont systemFontOfSize:12.0f];
            lab2.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:lab2];

            UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 10, 60, 20)];
            lab3.text = @"8000.00";
            lab3.font = [UIFont systemFontOfSize:12.0f];
            lab3.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:lab3];

            UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 35, 60, 20)];
            lab4.text = @"600.00";
            lab4.font = [UIFont systemFontOfSize:12.0f];
            lab4.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:lab4];

        }
    }
    return cell;
}
@end

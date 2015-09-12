//
//  LinkViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "LinkViewController.h"

@interface LinkViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
}
@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    table.backgroundColor = [UIColor clearColor];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:table];
    [self initNav];
}

-(void)initNav
{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    [navigationItem setTitle:@"分享免费设计"];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor =[UIColor clearColor];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        view.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        img.backgroundColor = [UIColor redColor];
        [view addSubview:img];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, self.view.frame.size.width-80, 30)];
        lab1.text = @"1111111";
        lab1.font = [UIFont systemFontOfSize:14.0f];
        lab1.textAlignment = NSTextAlignmentLeft;
        [view addSubview:lab1];
        
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, self.view.frame.size.width-80, 30)];
        lab2.text = @"1111111111111111111111111111111111111111111111111111111111111111111111";
        lab2.font = [UIFont systemFontOfSize:10.0f];
        lab2.textAlignment = NSTextAlignmentLeft;
        [view addSubview:lab2];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view addSubview:line];
        
        for (int i = 0; i < 4; i++) {
            int row = i/2;
            int col = i%2;
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15+col*80, 90+row*20, 80, 20)];
            lab.text = @"已分享10次";
            lab.font = [UIFont systemFontOfSize:12.0f];
            [view addSubview:lab];
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:1.0];
        button.frame = CGRectMake(self.view.frame.size.width-50, 110, 40, 20);
        [button setTitle:@"分享" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:button.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = button.bounds;
        maskLayer1.path = maskPath1.CGPath;
        button.layer.mask = maskLayer1;
    }
    return cell;
}
-(void)share
{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end

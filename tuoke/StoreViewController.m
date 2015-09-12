//
//  StoreViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreInfoViewController.h"

@interface StoreViewController ()<UITextFieldDelegate>
{
    UITextField *searchField;
    UISegmentedControl *segment;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    UIBarButtonItem *backButton;
    UIBarButtonItem *donebutton;
}
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    storeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40)];
    storeTableView.delegate = self;
    storeTableView.dataSource = self;
    storeTableView.backgroundColor = [UIColor clearColor];
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
}
-(void)add
{
    
}
-(void)doneAction
{
    
}
-(void)segmentChange:(UISegmentedControl*)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        
    }
    else if (index == 1)
    {
        
    }
    else
    {
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
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
        imageView.image = [UIImage imageNamed:@"storelogo.png"];
        [view addSubview:imageView];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 200, 20)];
        lab.text = @"22222222";
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:16.0f];
        [view addSubview:lab];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 200, 15)];
        lab1.text = @"1212121212121";
        lab1.font = [UIFont systemFontOfSize:12.0f];
        lab1.textAlignment = NSTextAlignmentLeft;
        [view addSubview:lab1];
        
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, 200, 15)];
        lab2.text = @"22222222";
        lab2.textAlignment = NSTextAlignmentLeft;
        lab2.font = [UIFont systemFontOfSize:12.0f];
        [view addSubview:lab2];
        
        UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(90, 80, 200, 15)];
        lab3.text = @"1212121212121";
        lab3.font = [UIFont systemFontOfSize:12.0f];
        lab3.textAlignment = NSTextAlignmentLeft;
        [view addSubview:lab3];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width-20, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view addSubview:line];
        
        UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 100, 20)];
        lab4.text = @"已开店";
        lab4.textColor = [UIColor redColor];
        lab4.textAlignment = NSTextAlignmentLeft;
        lab4.font = [UIFont systemFontOfSize:12.0f];
        [view addSubview:lab4];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0];
        button.frame = CGRectMake(self.view.frame.size.width-150, 110, 115, 30);
        [button setTitle:@"再次发送账号" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendAccout) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:button.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2)];
        CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
        maskLayer2.frame = button.bounds;
        maskLayer2.path = maskPath2.CGPath;
        button.layer.mask = maskLayer2;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    StoreInfoViewController *VC = [[StoreInfoViewController alloc]init];
    
    [self presentViewController:VC animated:YES completion:nil];
}
-(void)sendAccout
{
    
}
@end

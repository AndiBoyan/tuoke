//
//  WealthViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "WealthViewController.h"
#import "ProfitViewController.h"
#import "RuleViewController.h"

@interface WealthViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
}
@end

@implementation WealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, -35, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"奖励规则" style:UIBarButtonItemStylePlain target:self action:@selector(rule)];
    rightButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButton;
    

}
-(void)rule
{
    RuleViewController *vc = [[RuleViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    else
        return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0)&&(indexPath.row == 0))
    {
        return 100;
    }
    else if ((indexPath.section == 1)&&(indexPath.row == 0)) {
        return 40;
    }
    else
        return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        if (indexPath.section == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 20)];
                lab1.text = @"本月预期收益(元)";
                lab1.font = [UIFont systemFontOfSize:12.0f];
                lab1.textAlignment = NSTextAlignmentLeft;
                [cell.contentView addSubview:lab1];
                
                UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 20)];
                lab2.font = [UIFont boldSystemFontOfSize:20.0f];
                lab2.textAlignment = NSTextAlignmentCenter;
                lab2.text = @"10000.00";
                [cell.contentView addSubview:lab2];
            }
            else
            {
                UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, self.view.frame.size.width, 20)];
                lab1.text = @"22222222222222222";
                lab1.textAlignment = NSTextAlignmentLeft;
                lab1.font = [UIFont systemFontOfSize:12.0f];
                [cell.contentView addSubview:lab1];
                
                UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 30, 80, 20)];
                lab2.textColor = [UIColor yellowColor];
                lab2.text = @"1000.00";
                lab2.font = [UIFont systemFontOfSize:17.0f];
                [cell.contentView addSubview:lab2];
            }
        }
        else if (indexPath.section == 1)
        {
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
            lab1.text = @"实际总收益";
            lab1.textAlignment = NSTextAlignmentLeft;
            lab1.font = [UIFont systemFontOfSize:14.0f];
            [cell.contentView addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-110, 10, 80, 20)];
            lab2.text = @"18,000.00";
            lab2.font = [UIFont systemFontOfSize:13.0f];
            lab2.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:lab2];
            
            UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20, 14, 8, 12)];
            img1.image = [UIImage imageNamed:@"into.png"];
            [cell.contentView addSubview:img1];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        ProfitViewController *vc = [[ProfitViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

@end

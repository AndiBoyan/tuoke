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
    NSArray *stateArray;
    NSArray *dataArray;
}
@end

@implementation WealthViewController

- (void)viewDidLoad {
    stateArray = @[@"已登记",@"已开店",@"充值499",@"充值699",@"充值999"];
    dataArray = @[@[@"1024",@"120",@"1",@"4",@"0"],
                  @[@"999",@"100",@"1",@"4",@"10"]
                  ];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, -35, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *dateLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 20)];
        dateLab.text = @"2015年9月";
        dateLab.font = [UIFont systemFontOfSize:12.0f];
        [cell.contentView addSubview:dateLab];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 1)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell.contentView addSubview:line];
        
        float w = self.view.frame.size.width/(stateArray.count);
        
        for (int i = 0; i < stateArray.count; i++) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(w*i, 50, w, 20)];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:12.0f];
            lab.text = [stateArray objectAtIndex:i];
            [cell.contentView addSubview:lab];
            
            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(w*i, 75, w, 20)];
            lab1.textAlignment = NSTextAlignmentCenter;
            lab1.font = [UIFont systemFontOfSize:12.0f];
            lab1.text = [[dataArray objectAtIndex:indexPath.row]objectAtIndex:i];
            [cell.contentView addSubview:lab1];
        }

    }
     return cell;
}

@end

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
@interface MainViewController ()
{
    NSArray *array1;
    NSArray *array2;
    NSArray *array3;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    array1 = @[@"已登记",@"已开店",@"已充值"];
    array2 = @[@"开始拓客",@"注册链接",@"店铺演示"];
    array3 = @[@"start.png",@"link.png",@"move.png"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawView
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 500)];
    scroll.backgroundColor = [UIColor clearColor];
    scroll.contentSize = CGSizeMake(0, 50);
    [self.view addSubview:scroll];
    
    UIImageView *infoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210)];
    infoIV.image = [UIImage imageNamed:@"background.png"];
    [scroll addSubview:infoIV];
    
    UIImageView *logoIV = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, 25, 80, 80)];
    logoIV.image = [UIImage imageNamed:@"Face.png"];
    [scroll addSubview:logoIV];
    
    logoIV.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userInfoList:)];
    [logoIV addGestureRecognizer:singleTap];
    
    UILabel *logoLab = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, 85, 80, 80)];
    logoLab.text = @"张大仙";
    logoLab.textAlignment = NSTextAlignmentCenter;
    logoLab.textColor = [UIColor whiteColor];
    logoLab.font = [UIFont systemFontOfSize:14.0f];
    [scroll addSubview:logoLab];
    
    UIView *stateView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 60)];
    stateView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f];
    [scroll addSubview:stateView];
    float w = self.view.frame.size.width/3;
    for (int i = 0; i < 3; i++) {
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(i*w, 10, w, 20)];
        lab1.textColor =[UIColor redColor];
        lab1.text = @"125";
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.font = [UIFont systemFontOfSize:13.0f];
        [stateView addSubview:lab1];
        
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(i*w, 30, w, 20)];
        lab2.textColor =[UIColor whiteColor];
        lab2.text = [array1 objectAtIndex:i];
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.font = [UIFont systemFontOfSize:13.0f];
        [stateView addSubview:lab2];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((i+1)*w, 10, 1, 40)];
        view.backgroundColor =[UIColor whiteColor];
        [stateView addSubview:view];
    }
    
    UIView *expandView = [[UIView alloc]initWithFrame:CGRectMake(0, 230, self.view.frame.size.width, 160)];
    expandView.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:expandView];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake((w*i)+(w-60)/2, 30, 59, 59)];
        IV.image = [UIImage imageNamed:[array3 objectAtIndex:i]];
        IV.tag = 1000+i;
        [expandView addSubview:IV];
        
        IV.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(expand:)];
        [IV addGestureRecognizer:singleTap];

        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(i*w, 100, w, 20)];
        lab.text = [array2 objectAtIndex:i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:14.0f];
        [expandView addSubview:lab];
    }
}

-(void)userInfoList:(UITapGestureRecognizer *)recognizer
{
    UserInfoViewController *VC = [[UserInfoViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
}
-(void)expand:(UITapGestureRecognizer *)recognizer
{
    UIImageView *img=(UIImageView*)recognizer.view;
    if (img.tag == 1000) {
        BookInStoreViewController *VC = [[BookInStoreViewController alloc]init];
        [self presentViewController:VC animated:YES completion:nil];
    }
    else if (img.tag == 1001)
    {
        LinkViewController *vc = [[LinkViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
@end

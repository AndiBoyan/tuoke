//
//  StoreAddressViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/14.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "StoreAddressViewController.h"

@interface StoreAddressViewController ()<UITextViewDelegate>
{
    UITextView *addTextView;
    UILabel *placeLab;
    UILabel *numLab;
}

@end

@implementation StoreAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
    addTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 200)];
    addTextView.delegate = self;
    addTextView.font =[UIFont systemFontOfSize:15.0f];
    [self.view addSubview:addTextView];
    
    placeLab = [[UILabel alloc]init];
    placeLab.frame =CGRectMake(15, 85, 250, 20);
    placeLab.text = @"详细地址";
    placeLab.font = [UIFont systemFontOfSize:15.0f];
    placeLab.enabled = NO;//lable必须设置为不可用
    placeLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:placeLab];
    
    numLab = [[UILabel alloc]init];
    numLab.frame =CGRectMake(self.view.frame.size.width-265, 255, 250, 20);
    numLab.textAlignment = NSTextAlignmentRight;
    numLab.text = @"还可输入140个字";
    numLab.font = [UIFont systemFontOfSize:15.0f];
    numLab.enabled = NO;//lable必须设置为不可用
    numLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numLab];
    

    
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:addTextView.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = addTextView.bounds;
    maskLayer2.path = maskPath2.CGPath;
    addTextView.layer.mask = maskLayer2;
    
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
    [navigationItem setTitle:@"详细地址"];
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
    if ((addTextView.text.length <= 0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"详细地址不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [addTextView resignFirstResponder];
        return;
    }
    if (self.block) {
        self.block(addTextView.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//textView提示文字

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        placeLab.text = @"详细地址";
    }else{
        placeLab.text = @"";
    }
    
    NSInteger number = [textView.text length];
    if (number > 140) {
        textView.text = [textView.text substringToIndex:140];
        number = 140;
    }
    numLab.text = [NSString stringWithFormat:@"还可输入%ld个字",140-number];
}

@end

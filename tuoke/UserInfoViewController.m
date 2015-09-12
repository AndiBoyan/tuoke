//
//  UserInfoViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "UserInfoViewController.h"
#import "LoginViewController.h"
#import "AlterNickNameViewController.h"

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *table;
    NSArray *array1;
    NSArray *array2;
    NSArray *array3;
    UIImage *faceImg;
    NSString *nickName;
}
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-45) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    array1 = @[@"姓名",@"手机号"];
    array2 = @[@"头像",@"昵称"];
    array3 = @[@"张大仙",@"1212121212121"];
    nickName = @"大仙";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0];
    button.frame = CGRectMake(25, self.view.frame.size.height-70, self.view.frame.size.width-50, 50);
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:button.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = button.bounds;
    maskLayer1.path = maskPath1.CGPath;
    button.layer.mask = maskLayer1;

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
    [navigationItem setTitle:@"个人资料"];
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
-(void)loginOut
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"退出登录" message:@"确定退出当前账号？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.section == 1)&&(indexPath.row == 0)) {
        return 80;
    }
    else
        return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        if (indexPath.section == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(85, 5, 200, 30)];
            lab.text = [array3 objectAtIndex:indexPath.row];
            [cell.contentView addSubview:lab];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:14.0f];
        }
        else
        {
            cell.textLabel.text = [array2 objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20, 34, 8, 12)];
                img1.image = [UIImage imageNamed:@"into.png"];
                [cell.contentView addSubview:img1];
                
                UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-85, 10, 60, 60)];
                img2.image = [UIImage imageNamed:@"Face.png"];
                [cell.contentView addSubview:img2];
            }
            else
            {
                UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20, 14, 8, 12)];
                img1.image = [UIImage imageNamed:@"into.png"];
                [cell.contentView addSubview:img1];
                
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-200, 10, 165, 20)];
                lab.text = nickName;
                [cell.contentView addSubview:lab];
                lab.textAlignment = NSTextAlignmentRight;
                lab.font = [UIFont systemFontOfSize:14.0f];
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册",@"取消", nil];
            [sheet showInView:self.view];
        }
        else if (indexPath.row == 1)
        {
            AlterNickNameViewController *VC = [[AlterNickNameViewController alloc]init];
            [self presentViewController:VC animated:YES completion:nil];
        }
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }else if (buttonIndex==1){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info  objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    faceImg = image;
}
@end

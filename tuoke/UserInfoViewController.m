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


@interface UserInfoViewController ()


@property UILabel *nickLab;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self initData];
    [self drawView];
    [self initNav];
}

#pragma mark 初始化数据

-(void)initData
{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height-45) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    userInfoArray1 = @[@"姓名",@"手机号"];
    userInfoArray2 = @[@"头像",@"昵称"];
}

#pragma mark 界面绘制

-(void)drawView
{
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
}

#pragma mark 导航条按钮功能实现

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

#pragma mark 退出登录

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

#pragma mark TableDelegate

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
            cell.textLabel.text = [userInfoArray1 objectAtIndex:indexPath.row];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(85, 5, 200, 30)];
            if (indexPath.row == 0) {
                lab.text = self.name;
            }
            else
                lab.text = self.phone;
            [cell.contentView addSubview:lab];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.font = [UIFont systemFontOfSize:14.0f];
        }
        else
        {
            cell.textLabel.text = [userInfoArray2 objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20, 34, 8, 12)];
                img1.image = [UIImage imageNamed:@"into.png"];
                [cell.contentView addSubview:img1];
                
                faveImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-85, 10, 60, 60)];
                faceImg = [self readFaceImage];
                if (faceImg == nil) {
                    faveImgView.image = [UIImage imageNamed:@"Face.png"];
                }
                else{
                     faveImgView.image = faceImg;
                }
                [cell.contentView addSubview:faveImgView];
                
                UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:faveImgView.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];
                CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
                maskLayer1.frame = faveImgView.bounds;
                maskLayer1.path = maskPath1.CGPath;
                faveImgView.layer.mask = maskLayer1;
            }
            else
            {
                UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20, 14, 8, 12)];
                img1.image = [UIImage imageNamed:@"into.png"];
                [cell.contentView addSubview:img1];
                
                self.nickLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-200, 10, 165, 20)];
                self.nickLab.text = self.nickName;
                [cell.contentView addSubview:self.nickLab];
                self.nickLab.textAlignment = NSTextAlignmentRight;
                self.nickLab.font = [UIFont systemFontOfSize:14.0f];
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
           
            UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
            [sheet showInView:self.view];
        }
        else if (indexPath.row == 1)
        {
            
            AlterNickNameViewController *VC = [[AlterNickNameViewController alloc]init];
            [self presentViewController:VC animated:YES completion:nil];
            VC.block = ^(NSString *str){
                self.nickLab.text = str;
            };
        }
    }
}

#pragma mark 选择图库中的图片

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }else if (buttonIndex==1){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    faceImg = img;
    faveImgView.image = img;
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"userface.png"]];   // 保存文件的名称
    [UIImagePNGRepresentation(img)writeToFile: filePath    atomically:YES];
}

//读取本地图片

-(UIImage*)readFaceImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"userface.png"]];   // 保存文件的名称
    ;
    
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    return img;
}

#pragma maek 图片转base64编码

//图片转base64编码
- (BOOL) imageHasAlpha: (UIImage *) img
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(img.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
- (NSString *) image2DataURL: (UIImage *) img
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    imageData = UIImageJPEGRepresentation(img, 0.1f);
    mimeType = @"image/jpeg";
    
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

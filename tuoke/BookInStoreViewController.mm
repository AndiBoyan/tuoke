//
//  BookInStoreViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "BookInStoreViewController.h"
#import "ViewController.h"
#import "StoreNameViewController.h"
#import "StoreAddressViewController.h"
#import "StoreManNameViewController.h"
#import "StoreManPhoneViewController.h"
#import "VisitNameViewController.h"
#import "VisitPhoneViewController.h"
#import "URLApi.h"

@interface BookInStoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *table;
    NSArray *array1;
    NSArray *array2;
    NSArray *array3;
    NSArray *array4;
    NSMutableArray *CategoryNameAry;
    NSMutableArray *CategoryIDAry;
}
@end

@implementation BookInStoreViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    array1 = @[@"门店全名",@"门店类型",@"门头照片"];
    array2 = @[@"所在城市",@"详细地址"];
    array3 = @[@"姓名",@"手机号",@"店主名片正面",@"店主名片反面"];
    array4 = @[@"姓名",@"手机号",@"身份备注"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table];
    [self initNav];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}


#pragma mark 导航栏实现

-(void)initNav
{
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    [navigationItem setTitle:@"登记门店"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBarTintColor:[UIColor groupTableViewBackgroundColor]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    [self.view addSubview:navigationBar];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(bookIn)];
    navigationItem.rightBarButtonItem = rightButton;
    rightButton.tintColor = [UIColor blackColor];

}

-(void)back
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"放弃登记门店" message:@"确定不提交门店信息，直接返回？直接返回系统将不保存您所填写的信息。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1000;
    [alert show];
    
}
/*
 {
 \"authCode\":\"\",
 \"JsonInfo\":
 {
 \"CityName\":\"广州市\",
 \"Address\":\"12121212\",
 \"DeptName\":\"哈哈哈\",
 \"DeptCategoryId\":0,
 \"DeptImgPath\":\"\",
 \"DeptImgFid\":\"\",
 \"UserInfo_DZ\":
 {
 \"UserName\":\"111\",
 \"Mobile\":\"121212\",
 \"UserCategoryId\":\"1212\",
 \"CardFrontImgPath\":\"\",
 \"CardFrontImgFid\":\"\",
 \"CardBackImgPath\":\"\",
 \"CardBackImgFid\":\"\"
 },
 \"UserInfo_FTR\":
 {
 \"UserName\":\"111\",
 \"Mobile\":\"121212\",
 \"UserCategoryId\":\"1212\"
 }
 }
 }
 {"Status":200,"JSON":"\"访谈人手机号已经被注册\"","ErrorMessage":null,"InfoMessage":null}
 
{"Status":200,"JSON":"{\"DeptId\":\"00022412\",\"Domain\":\"ekt7pmu.mnmnh.com\",\"ListUS\":[{\"UserName\":\"18426352147\",\"password\":\"gz9h2i\",\"UserId\":\"1000044766\"},{\"UserName\":\"13255558889\",\"password\":\"61fip8\",\"UserId\":\"1000044767\"}]}","ErrorMessage":null,"InfoMessage":null}
 */
-(void)bookIn
{
    if ((address == nil)||(storeName == nil)||(storeType == nil)||(storeImage == nil)||(storeManName == nil)||(storeManPhone == nil)||(storeImageCard1 == nil)||(storeImageCard2 == nil)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您提交的内容不完善，请完善后再上传" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    // 1.设置请求路径//10.1.127.27 passport.admin.3weijia.com
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为10秒
    request.HTTPMethod=@"POST";//设置请求方法
    if (city == nil) {
        city = @"广州市";
    }
    NSString *authCode = [URLApi readAuthCodeString];
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"JsonInfo\":{\"CityName\":\"%@\",\"Address\":\"%@\",\"DeptName\":\"%@\",\"DeptCategoryId\":%ld,\"DeptImgPath\":\"%@\",\"DeptImgFid\":\"%@\",\"UserInfo_DZ\":{\"UserName\":\"%@\",\"Mobile\":\"%@\",\"UserCategoryId\":1,\"CardFrontImgPath\":\"%@\",\"CardFrontImgFid\":\"%@\",\"CardBackImgPath\":\"%@\",\"CardBackImgFid\":\"%@\"},\"UserInfo_FTR\":{\"UserName\":\"%@\",\"Mobile\":\"%@\",\"UserCategoryId\":%ld}}}&Command=tuoke/TK_DepartmentCreate",[self encodeToPercentEscapeString:authCode],city,address,storeName,storeManType,storeImagePath,storeImageFileId,storeManName,storeManPhone,storeImageCard1Path,storeImageCard1FileId,storeImageCard2Path,storeImageCard2FileId,visitName,visitPhone,visitManType];
    if ((visitName == nil)||(visitPhone == nil)||(visitManType == 0) ) {
         param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"JsonInfo\":{\"CityName\":\"%@\",\"Address\":\"%@\",\"DeptName\":\"%@\",\"DeptCategoryId\":%ld,\"DeptImgPath\":\"%@\",\"DeptImgFid\":\"%@\",\"UserInfo_DZ\":{\"UserName\":\"%@\",\"Mobile\":\"%@\",\"UserCategoryId\":1,\"CardFrontImgPath\":\"%@\",\"CardFrontImgFid\":\"%@\",\"CardBackImgPath\":\"%@\",\"CardBackImgFid\":\"%@\"}}}&Command=tuoke/TK_DepartmentCreate",[self encodeToPercentEscapeString:authCode],city,address,storeName,storeManType,storeImageFileId,storeImagePath,storeManName,storeManPhone,storeImageCard1FileId,storeImageCard1Path,storeImageCard2FileId,storeImageCard2Path];
    }
    NSLog(@"http://passport.admin.3weijia.com/MNMNH.axd?%@",param);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         //将得到的NSData数据转换成NSString
         if (connectionError) {
             NSLog(@"网络不给力");
         }
         else
         {
             NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"%@",str);
             NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSNumber *Status = [dic objectForKey:@"Status"];
             if (Status.intValue == 200) {
                 ViewController *vc = [[ViewController alloc]init];
                 vc.selectedIndex = 1;
                 [self presentViewController:vc animated:YES completion:nil];
             }
             else
             {
                  NSString *InfoMessage = [dic objectForKey:@"InfoMessage"];
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:InfoMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
                 return ;
             }
         }
     }];
}

#pragma mark TableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [view setBackgroundColor:[UIColor redColor]];//改变标题的颜色，也可用图片
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 30)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.backgroundColor = [UIColor clearColor];
    
    if (section == 0) {
        label.text =  @"门店信息(必填)";
    }
    else if (section == 1)
    {
        label.text =  @"店铺地址(必填)";
    }
    else if (section == 2)
    {
        label.text =  @"店主信息(必填)";
    }
    else
    {
        label.text =  @"访谈人(选填)";
        [view setBackgroundColor:[UIColor brownColor]];
    }
    
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.section == 2)&&((indexPath.row == 2)||(indexPath.row == 3))) {
        return 60;
    }
    else if ((indexPath.section == 0)&&(indexPath.row == 2))
    {
        return 60;
    }
    else
        return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return array1.count;
    }
    else if (section == 1)
    {
        return array2.count;
    }
    else if (section == 2)
    {
        return array3.count;
    }
    else
        return array4.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"店主信息(必填)";
    }
    else if (section == 1)
    {
        return @"门店信息(必填)";
    }
    else if (section == 2)
    {
        return @"店铺地址(必填)";
    }
    else
        return @"访谈人(选填)";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cel"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        if (indexPath.section == 0) {
            cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                [self addImageView:cell.contentView fromHead:14];
                storeNameLab = [self addLabelView:YES string:storeName string1:@"输入门店全称"];
                [cell.contentView addSubview:storeNameLab];
            }
            else if (indexPath.row == 1)
            {
                [self addImageView:cell.contentView fromHead:14];
                storeTypeLab = [self addLabelView:NO string:storeType string1:@"请选择"];
                [cell.contentView addSubview:storeTypeLab];
            }
            else if (indexPath.row == 2)
            {
               [self addImageView:cell.contentView fromHead:24];
               storeImageView = [self addFaceImage:storeImage];
                [cell.contentView addSubview:storeImageView];
            }
        }
        else if (indexPath.section == 1)
        {
            cell.textLabel.text = [array2 objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                [self addImageView:cell.contentView fromHead:14];
                //[self addLabelView:cell.contentView lab:cityLab line:NO string:city string1:@"无法定位至当前位置"];
                cityLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-230, 10, 205, 20)];
                cityLab.textAlignment = NSTextAlignmentRight;
                cityLab.font = [UIFont systemFontOfSize:14.0f];
                if (city == nil) {
                    cityLab.text = @"无法定位至当前位置";
                }
                else
                    cityLab.text = city;
                [cell.contentView addSubview:cityLab];
            }
            else if (indexPath.row == 1)
            {
                 [self addImageView:cell.contentView fromHead:14];
                 addressLab = [self addLabelView:YES string:address string1: @"输入详细地址"];
                [cell.contentView addSubview:addressLab];
            }
        }
        else if (indexPath.section == 2)
        {
            cell.textLabel.text = [array3 objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                [self addImageView:cell.contentView fromHead:14];
                storeManNameLab = [self addLabelView:NO string:storeManName string1:@"输入店主姓名"];
                [cell.contentView addSubview:storeManNameLab];
            }
            else if (indexPath.row == 1)
            {
                [self addImageView:cell.contentView fromHead:14];
                storeManPhoneLab = [self addLabelView:NO string:storeManPhone string1:@"输入店主手机号"];
                [cell.contentView addSubview:storeManPhoneLab];
            }
            else if (indexPath.row == 2)
            {
                [self addImageView:cell.contentView fromHead:24];
                cardImage1 = [self addFaceImage:storeImageCard1];
                [cell.contentView addSubview:cardImage1];
                
            }
            else if (indexPath.row == 3)
            {
                [self addImageView:cell.contentView fromHead:24];
                cardImage2 = [self addFaceImage:storeImageCard2];
                [cell.contentView addSubview:cardImage2];
            }
        }
        else if (indexPath.section ==3)
        {
            cell.textLabel.text = [array4 objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                [self addImageView:cell.contentView fromHead:14];
                visitNameLab = [self addLabelView:NO string:visitName string1: @"输入被访谈人姓名"];
                [cell.contentView addSubview:visitNameLab];
            }
            else if (indexPath.row == 1)
            {
                [self addImageView:cell.contentView fromHead:14];
                visitPhoneLab = [self addLabelView:NO string:visitPhone string1: @"输入被访谈人手机号"];
                [cell.contentView addSubview:visitPhoneLab];
            }
            else if (indexPath.row == 2)
            {
                [self addImageView:cell.contentView fromHead:14];
                visitDegreeLab = [self addLabelView:NO string:visitDegree string1: @"请选择"];
                [cell.contentView addSubview:visitDegreeLab];
            }
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            //门店全名
            StoreNameViewController *VC = [[StoreNameViewController alloc]init];
            VC.block = ^(NSString *str){
                storeNameLab.text = str;
                storeName = str;
            };
            [self presentViewController:VC animated:YES completion:nil];
        }
        else if (indexPath.row == 1)
        {
            //门店类型
            [self getModule:@"ShopCate" tag:1000];
        }
        else if (indexPath.row == 2)
        {
            imageType = 1;
            UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
            sheet.tag = 1002;
            [sheet showInView:self.view];
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row == 1)
        {
            StoreAddressViewController *VC = [[StoreAddressViewController alloc]init];
            VC.block = ^(NSString *str){
                addressLab.text = str;
                address = str;
            };
            [self presentViewController:VC animated:YES completion:nil];
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            StoreManNameViewController *VC = [[StoreManNameViewController alloc]init];
            VC.block = ^(NSString *str){
                storeManNameLab.text = str;
                storeManName = str;
            };
            [self presentViewController:VC animated:YES completion:nil];
        }
        else if (indexPath.row == 1)
        {
            StoreManPhoneViewController *VC = [[StoreManPhoneViewController alloc]init];
            VC.block = ^(NSString *str){
                storeManPhoneLab.text = str;
                storeManPhone = str;
            };
            [self presentViewController:VC animated:YES completion:nil];
        }
        else if (indexPath.row == 2)
        {
            imageType = 2;
            UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
            sheet.tag = 1002;
            [sheet showInView:self.view];
        }
        else if (indexPath.row == 3)
        {
            imageType = 3;
            UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
            sheet.tag = 1002;
            [sheet showInView:self.view];
        }
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            VisitNameViewController *VC = [[VisitNameViewController alloc]init];
            VC.block = ^(NSString *str){
                visitNameLab.text = str;
                visitName = str;
            };
            [self presentViewController:VC animated:YES completion:nil];
        }
        else if (indexPath.row == 1)
        {
            VisitPhoneViewController *VC = [[VisitPhoneViewController alloc]init];
            VC.block = ^(NSString *str){
                visitPhoneLab.text = str;
                visitPhone = str;
            };
            [self presentViewController:VC animated:YES completion:nil];
        }
        else if (indexPath.row == 2)
        {
            /*UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择拜访人身份" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"店主",@"店长",@"设计师",@"销售经理",@"导购", nil];
            sheet.tag = 1001;
            [sheet showInView:self.view];*/
            [self getModule:@"UserIdentity" tag:1001];
        }
    }
}

#pragma mark Cell 绘制

-(void)addImageView:(UIView *)view fromHead:(float)head
{
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20, head, 8, 12)];
    img1.image = [UIImage imageNamed:@"into.png"];
    [view addSubview:img1];
}

-(UIImageView*)addFaceImage:(UIImage*)name
{
    UIImageView *image;
    image = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 5, 50, 50)];
    if (name == nil)
    {
        image.image = [UIImage imageNamed:@"Face.png"];
    }
    else{
        image.image = name;
    }
    return image;
}
-(UILabel*)addLabelView:(BOOL)line string:(NSString*)string string1:(NSString*)string1
{
    UILabel *lab;
    lab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-230, 10, 205, 20)];
    lab.textAlignment = NSTextAlignmentRight;
    lab.font = [UIFont systemFontOfSize:14.0f];
    if (line) {
        lab.lineBreakMode = NSLineBreakByWordWrapping;
        lab.numberOfLines = 0;
        lab.font = [UIFont systemFontOfSize:12.0f];
    }
    if (string == nil) {
        lab.text = string1;
    }
    else
        lab.text = string;
    return lab;

}

#pragma mark AlertDelagate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 0) {
            
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark actionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1000)
    {
        storeTypeLab.text = [CategoryNameAry objectAtIndex:buttonIndex-1];
        storeType = [CategoryNameAry objectAtIndex:buttonIndex-1];
        id manType = [CategoryIDAry objectAtIndex:buttonIndex-1];
        storeManType = [manType integerValue];
    }
    else if (actionSheet.tag == 1001)
    {
        visitDegreeLab.text = [CategoryNameAry objectAtIndex:buttonIndex-1];
        visitDegree = [CategoryNameAry objectAtIndex:buttonIndex-1];
        id manType = [CategoryIDAry objectAtIndex:buttonIndex-1];
        visitManType = [manType integerValue];
    }
    else if (actionSheet.tag == 1002)
    {
        
        if (buttonIndex == 0) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }
        else if (buttonIndex == 1)
        {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }
    }
    else if (actionSheet.tag == 1003)
    {
        
    }
}

#pragma mark 图片上传

//门店图片:ShopInfo;店长名片正面:SMCardFront;名片背面:SMCardBack;用户头像:UserSetting
-(void)updateImage:(NSString*)type image:(UIImage*)img name:(NSString*)name
{
    // 1.设置请求路径//10.1.127.27 passport.admin.3weijia.com
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为10秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"FileGroup\":\"%@\",\"SubjectId\":\"\",\"FileString\":\"%@\",\"FileName\":\"%@.png\"}&Command=tkcommon/PostFileByString",[self encodeToPercentEscapeString:authCode],type,[self encodeToPercentEscapeString:[self image2DataURL:img]],name];
    NSLog(@"http://passport.admin.3weijia.com/MNMNH.axd?%@",param);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         //将得到的NSData数据转换成NSString
         if (connectionError) {
             NSLog(@"网络不给力");
         }
         else
         {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"%@",[self newJsonStr:str]);
            NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSString *FileId = [[dic objectForKey:@"JSON"]objectForKey:@"FileId"];
             NSString *FileFullPath = [[dic objectForKey:@"JSON"]objectForKey:@"FileFullPath"];
             NSLog(@"FileId = %@,FileFullPath = %@",FileId,FileFullPath);
             if ([type isEqualToString:@"ShopInfo"]) {
                 storeImageFileId = type;
                 storeImagePath = FileFullPath;
             }
             else if ([type isEqualToString:@"SMCardFront"])
             {
                 storeImageCard1FileId = type;
                 storeImageCard1Path = FileFullPath;
             }
             else
             {
                 storeImageCard2FileId = type;
                 storeImageCard2Path = FileFullPath;
             }
        }
     }];
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

- (NSString*)newJsonStr:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\"JSON\":\"" withString:@"\"JSON\":"];
    string = [string stringByReplacingOccurrencesOfString:@"}\"," withString:@"},"];
    string = [string stringByReplacingOccurrencesOfString:@"]\"," withString:@"],"];
    string = [string stringByReplacingOccurrencesOfString:@"\"JSON\":\"\\\"\\\"\"" withString:@"\"JSON\":\"\""];
    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\"JSON\":\"\"" withString:@"\"JSON\":\""];
    string = [string stringByReplacingOccurrencesOfString:@"\"\",\"ErrorMessage\"" withString:@"\",\"ErrorMessage\""];
    return string;
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
    
    /*if ([self imageHasAlpha: img]) {
        imageData = UIImagePNGRepresentation(img);
        mimeType = @"image/png";
    } else {*/
        imageData = UIImageJPEGRepresentation(img, 0.1f);
        mimeType = @"image/jpeg";
    //}
    
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions:0]];
}

#pragma mark 选择店面图片
//门店图片:ShopInfo;店长名片正面:SMCardFront;名片背面:SMCardBack;用户头像:UserSetting
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (imageType == 1) {
        storeImageView.image = img;
        storeImage = img;
        [self updateImage:@"ShopInfo" image:img name:@"ShopInfo"];
    }
    else if (imageType == 2)
    {
        cardImage1.image = img;
        storeImageCard1 = img;
        [self updateImage:@"SMCardFront" image:img name:@"SMCardFront"];
    }
    else if (imageType == 3)
    {
        cardImage2.image = img;
        storeImageCard2 = img;
        [self updateImage:@"SMCardBack" image:img name:@"SMCardBack"];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 地图开发

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_locService stopUserLocationService];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    CLLocationCoordinate2D pt = userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        city = result.addressDetail.city;
        cityLab.text = city;
    }
}

-(void)getModule:(NSString*)categoryCode tag:(int)tag
{
    CategoryNameAry = [[NSMutableArray alloc]init];
    CategoryIDAry = [[NSMutableArray alloc]init];
    
    // 1.设置请求路径//10.1.127.27 passport.admin.3weijia.com
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为10秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"module\":\"TuoKe\",\"categoryCode\":\"%@\",\"showAll\":\"false\"}&Command=category/GetSubCategoryListByCode",[self encodeToPercentEscapeString:authCode],categoryCode];
    NSLog(@"http://passport.admin.3weijia.com/MNMNH.axd?%@",param);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         //将得到的NSData数据转换成NSString
         if (connectionError) {
             NSLog(@"网络不给力");
         }
         else
         {
             NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"%@",[self newJsonStr:str]);
             NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSArray *ReturnList = [[dic objectForKey:@"JSON"]objectForKey:@"ReturnList"];
             for (id json in ReturnList) {
                 
                 [CategoryNameAry addObject:[json objectForKey:@"CategoryName"]];
                 [CategoryIDAry addObject:[json objectForKey:@"CategoryId"]];
                 
             }
             UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择门店类别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
             for (int i = 0; i < CategoryNameAry.count; i++) {
                 [sheet addButtonWithTitle:[CategoryNameAry objectAtIndex:i]];
             }
             sheet.tag = tag;
             [sheet showInView:self.view];
         }
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

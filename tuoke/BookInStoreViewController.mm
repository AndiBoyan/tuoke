//
//  BookInStoreViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "BookInStoreViewController.h"
#import "ViewController.h"

@interface BookInStoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSArray *array1;
    NSArray *array2;
    NSArray *array3;
    NSArray *array4;
}
@end

@implementation BookInStoreViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    array1 = @[@"门店全名",@"门店类型",@"门头照片"];
    array2 = @[@"所在城市",@"详细地址"];
    array3 = @[@"姓名",@"手机号",@"店主名片正面",@"店主名片反面"];
    array4 = @[@"姓名",@"手机号",@"身份备注"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self initNav];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
                [self addLabelView:cell.contentView lab:storeNameLab line:YES string:storeName string1:@"输入门店全称"];
            }
            else if (indexPath.row == 1)
            {
                [self addImageView:cell.contentView fromHead:14];
                [self addLabelView:cell.contentView lab:storeTypeLab line:NO string:storeType string1:@"请选择"];
            }
            else if (indexPath.row == 2)
            {
               [self addImageView:cell.contentView fromHead:24];
               [self addFaceImage:storeImageView view:cell.contentView imageName:storeImageName];
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
                 [self addLabelView:cell.contentView lab:addressLab line:YES string:address string1: @"输入详细地址"];
            }
        }
        else if (indexPath.section == 2)
        {
            cell.textLabel.text = [array3 objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                [self addImageView:cell.contentView fromHead:14];
                [self addLabelView:cell.contentView lab:storeManNameLab line:NO string:storeManName string1:@"输入店主姓名"];
            }
            else if (indexPath.row == 1)
            {
                [self addImageView:cell.contentView fromHead:14];
                [self addLabelView:cell.contentView lab:storeManPhoneLab line:NO string:storeManPhone string1:@"输入店主手机号"];
            }
            else if (indexPath.row == 2)
            {
                [self addImageView:cell.contentView fromHead:24];
                [self addFaceImage:cardImage1 view:cell.contentView imageName:storeImageCard1];
                
            }
            else if (indexPath.row == 3)
            {
                [self addImageView:cell.contentView fromHead:24];
                [self addFaceImage:cardImage2 view:cell.contentView imageName:storeImageCard2];
            }
        }
        else if (indexPath.section ==3)
        {
            cell.textLabel.text = [array4 objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                [self addImageView:cell.contentView fromHead:14];
                [self addLabelView:cell.contentView lab:visitNameLab line:NO string:visitName string1: @"输入被访谈人姓名"];
            }
            else if (indexPath.row == 1)
            {
                [self addImageView:cell.contentView fromHead:14];
                [self addLabelView:cell.contentView lab:visitPhoneLab line:NO string:visitPhone string1: @"输入被访谈人手机号"];
            }
            else if (indexPath.row == 2)
            {
                [self addImageView:cell.contentView fromHead:14];
                [self addLabelView:cell.contentView lab:visitDegreeLab line:NO string:visitDegree string1: @"请选择"];
            }
        }
    }
    return cell;
}

-(void)addImageView:(UIView *)view fromHead:(float)head
{
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20, head, 8, 12)];
    img1.image = [UIImage imageNamed:@"into.png"];
    [view addSubview:img1];
}

-(void)addFaceImage:(UIImageView*)image view:(UIView*)view imageName:(NSString*)name
{
    image = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 5, 50, 50)];
    if (name == nil)
    {
        image.image = [UIImage imageNamed:@""];
    }
    else{
        image.image = [UIImage imageNamed:name];
    }
    [view addSubview:image];
}
-(void)addLabelView:(UIView *)view lab:(UILabel*)lab line:(BOOL)line string:(NSString*)string string1:(NSString*)string1
{
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
    [view addSubview:lab];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"门店全名" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.tag = 999;
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            UITextField * txt = [[UITextField alloc] init];
            txt.backgroundColor = [UIColor whiteColor];
            // txt.keyboardType = UIKeyboardTypePhonePad;
            txt.frame = CGRectMake(alert.center.x+65,alert.center.y+48, 150,23);
            [alert addSubview:txt];
            [alert show];
        }
       else if (indexPath.row == 1)
       {
           
       }
        else if (indexPath.row == 2)
        {
            
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row == 1)
        {
            
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row == 1)
        {
            
        }
        else if (indexPath.row == 2)
        {
            
        }
        else if (indexPath.row == 3)
        {
            
        }
    }
    else if (indexPath.row == 3)
    {
        if (indexPath.row == 0) {
            
        }
        else if (indexPath.row == 1)
        {
            
        }
        else if (indexPath.row == 2)
        {
            
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

-(void)bookIn
{
    
    ViewController *vc = [[ViewController alloc]init];
    vc.selectedIndex = 1;
    [self presentViewController:vc animated:YES completion:nil];
}
@end

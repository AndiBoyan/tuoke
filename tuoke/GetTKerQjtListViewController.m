//
//  GetTKerQjtListViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/16.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "GetTKerQjtListViewController.h"
#import "JSGridView.h"
#import "URLApi.h"

@interface GetTKerQjtListViewController ()<JSGridViewDataSource, JSGridViewDelegate>
{
    
@private
    JSGridView *_gridView;
    
    NSInteger _lefeHeight;
    NSInteger _rightHeight;
    
    NSMutableArray *_leftArray;
    NSMutableArray *_rightArray;
    NSInteger _loadCount;
    
    UIView *examineView;
    BOOL _isLoading;
    
    NSMutableArray *_images;
    float cellImageWidth;
    NSMutableArray *nameAry;
}

//@property (strong, nonatomic) id detailItem;
@property int page;

@property (retain, nonatomic) IBOutlet JSGridView *gridView;

@end

@implementation GetTKerQjtListViewController
@synthesize gridView = _gridView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cellImageWidth = (self.view.frame.size.width/2)-10;
    self.gridView = [[JSGridView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height-65)];
    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    [self.view addSubview:self.gridView];
    _leftArray = [[NSMutableArray alloc] init];
    _rightArray = [[NSMutableArray alloc] init];
    _isLoading = NO;
    _page = 1;
    _images = [[NSMutableArray alloc]init];
    nameAry = [[NSMutableArray alloc]init];
    [self GetEmployeeInfo];
    
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
    [navigationItem setTitle:@"全景图"];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    navigationBar.barStyle = UIBarStyleBlack;
    [navigationBar setBarTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    [self.view addSubview:navigationBar];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navigationItem.leftBarButtonItem = leftButton;
}

-(void)back
{
    self.gridView.delegate = nil;
    self.gridView.dataSource = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Helper
- (NSArray *)arrayValueByTableKey:(NSInteger)columnIndex {
    NSArray *array = [NSArray array];
    if (columnIndex==0) {
        array = _leftArray;
    } else if (columnIndex==1) {
        array = _rightArray;
    }
    return array;
}

- (void)addTableViewData {
    // _loadCount += kOnceLoadingCount;
    for (int i = 0; i<_images.count; i++) {
        UIImage *img = [_images objectAtIndex:i];
        float height = img.size.height/(img.size.width/150);//(float)(arc4random()%225);
        double mininum = MIN(_lefeHeight, _rightHeight);
        // data info
        NSDictionary *info = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%f", height]
                                                         forKey:@"usingHeight"];
        if (_lefeHeight == mininum) {
            _lefeHeight += height;
            [_leftArray addObject:info];
        } else if (_rightHeight == mininum) {
            _rightHeight += height;
            [_rightArray addObject:info];
        }
    }
    [_gridView reloadData];
}

#pragma mark - JSGridView


- (JSGridViewConstSize)constSizeForGeidView:(JSGridView *)gridView {
    return JSGridViewConstSizeWidth;
}

- (CGFloat)gridView:(JSGridView *)gridView heightForCellAtRow:(NSInteger)row column:(NSInteger)column {
    id obj = [[self arrayValueByTableKey:column] objectAtIndex:row];
    return [[obj objectForKey:@"usingHeight"] intValue]+5;
}

- (CGFloat)gridView:(JSGridView *)gridView widthForCellAtColumnIndex:(NSInteger)column {
    return cellImageWidth+5;
}

- (NSInteger)numberOfRowsInGridView:(JSGridView *)gridView forConstColumnWithIndex:(NSInteger)column {
    return [[self arrayValueByTableKey:column] count];
}

- (NSInteger)numberOfConstColumnsInGridView:(JSGridView *)gridView {
    return 2;
}

- (void)gridView:(JSGridView *)gridView scrolledToEdge:(JSGridViewEdge)edge {
    if (edge == JSGridViewEdgeBottom) {
        //        _isLoading = YES;
        //[self addTableViewData];
    }
}
- (JSGridViewCell *)gridView:(JSGridView *)gridView viewForRow:(NSInteger)row column:(NSInteger)column {
    NSArray *array = [self arrayValueByTableKey:column];
    NSString *identifier = @"testCell";
    JSGridViewCell *cell = [gridView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[JSGridViewCell alloc] initWithReuseIdentifier:identifier];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.tag = 50;
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        
        [cell addSubview:imageView];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        lab.tag = 60;
        [cell addSubview:lab];
        
        cell.delegate = self;
    }
    cell.row = row;
    cell.column = column;
    NSDictionary *oneDic = [array objectAtIndex:row];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:50];
    float height = [[oneDic objectForKey:@"usingHeight"] floatValue];
    imageView.frame = CGRectMake(5, 5, cellImageWidth, height);
    NSInteger i = (row*2+column)%[_images count];
    
    imageView.image = [_images objectAtIndex:i];
    
    UILabel *lab = (UILabel*)[cell viewWithTag:60];
    lab.frame = CGRectMake(5, height-25, cellImageWidth, 30);
    lab.textAlignment = NSTextAlignmentCenter ;
    lab.font = [UIFont systemFontOfSize:10.0f];
    lab.text = [nameAry objectAtIndex:i];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lab.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = lab.bounds;
    maskLayer.path = maskPath.CGPath;
    lab.layer.mask = maskLayer;
    
    return cell;
}

- (void)gridViewCellWasTouched:(JSGridViewCell *)gridViewCell {
    
    examineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:examineView];
    examineView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.0f];
    UIImage *image = [_images objectAtIndex:(gridViewCell.row*2+gridViewCell.column)%(_images.count)];
    if (gridViewCell.row*2+gridViewCell.column == _images.count) {
        image = [_images objectAtIndex:_images.count-1];
    }
    float w = self.view.frame.size.width-40;
    float h = (w*image.size.height)/image.size.width;
    
    UIImageView *imageExamine = [[UIImageView alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height-h)/2, w, h)];
    imageExamine.image = image;
    [examineView addSubview:imageExamine];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:imageExamine.bounds  byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = imageExamine.bounds;
    maskLayer1.path = maskPath1.CGPath;
    imageExamine.layer.mask = maskLayer1;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(self.view.frame.size.width-50, (self.view.frame.size.height-h)/2, 30, 30);
    
    [closeBtn setImage:[[UIImage imageNamed:@"delete_img"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [examineView addSubview:closeBtn];
    
}

-(void)close:(id)sender
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         examineView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         [examineView removeFromSuperview];
                     }];
}

-(void)GetEmployeeInfo
{
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:[URLApi requestURL]];//不需要传递参数
    //    2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=10.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    NSString *authCode = [URLApi readAuthCodeString];
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"Params={\"authCode\":\"%@\",\"pageIndex\":\"%d\",\"pageSize\":\"10\"}&Command=tuoke/GetTKerQjtList",[self encodeToPercentEscapeString:authCode],_page];
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
             
             //将数据变成标准的json数据
             NSLog(@"%@",[self newJsonStr:str]);
             NSData *newData = [[self newJsonStr:str] dataUsingEncoding:NSUTF8StringEncoding];
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData options:NSJSONReadingMutableContainers error:nil];
             NSArray *ReturnList = [[dic objectForKey:@"JSON"]objectForKey:@"ReturnList"];
             for (id list in ReturnList) {
                 NSString *name = [list objectForKey:@"SchemeName"];
                 NSString *ImagePath = [NSString stringWithFormat:@"%@%@",[URLApi imageURL],[list objectForKey:@"ImagePath"]];
                 NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImagePath]];
                 if ([UIImage imageWithData:imageData]) {
                     [nameAry addObject:name];
                     [_images addObject:[UIImage imageWithData:imageData]];

                 }
            }
         }
         [self addTableViewData];
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
/*
 [UMSocialSnsService presentSnsIconSheetView:self
 appKey:@"55fa8188e0f55ae5bb000b6a"
 shareText:@"你要分享的文字"
 shareImage:[UIImage imageNamed:@"icon.png"]
 shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,nil]
 delegate:self];
 */
@end

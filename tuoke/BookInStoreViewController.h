//
//  BookInStoreViewController.h
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件


@interface BookInStoreViewController : UIViewController<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    NSString *storeName;
    NSString *storeType;
    UIImage *storeImage;
    
    NSString *city;
    NSString *address;
    
    NSString *storeManName;
    NSString *storeManPhone;
    UIImage *storeImageCard1;
    UIImage *storeImageCard2;
    
    NSString *visitName;
    NSString *visitPhone;
    NSString *visitDegree;
    
    
    UILabel *storeNameLab;
    UILabel *storeTypeLab;
    UIImageView *storeImageView;
    
    UILabel *cityLab;
    UILabel *addressLab;
    
    UILabel *storeManNameLab;
    UILabel *storeManPhoneLab;
    UIImageView *cardImage1;
    UIImageView *cardImage2;
    
    UILabel *visitNameLab;
    UILabel *visitPhoneLab;
    UILabel *visitDegreeLab;
    
    BMKLocationService* _locService;
    BMKGeoCodeSearch* _geocodesearch;
    
    int imageType;
    
    NSString *storeImageFileId;
    NSString *storeImageCard1FileId;
    NSString *storeImageCard2FileId;
    
    NSString *storeImagePath;
    NSString *storeImageCard1Path;
    NSString *storeImageCard2Path;
    
    NSInteger storeManType;
    NSInteger visitManType;
    
}
@end

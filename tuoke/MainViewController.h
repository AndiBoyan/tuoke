//
//  MainViewController.h
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
{
    NSArray *userStateArray;//用户基本信息数组
    NSMutableArray *userCountAry;
    NSArray *tuokeFuncArray;//拓客功能以及功能图标
    NSArray *tuokeFuncImageArray;
    
    UIButton *face;//用户头像以及功能
    UILabel *userNameLab;//用户名
    
    //用户基本信息
    NSString *name;
    NSString *phone;
    NSString *nick;
    
    UILabel *stateLab1;
    UILabel *stateLab2;
    UILabel *stateLab3;
    
    UIImage *faceImage;
}
@end

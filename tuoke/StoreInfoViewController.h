//
//  StoreInfoViewController.h
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreInfoViewController : UIViewController
{
    NSString *storeName;
    NSString *address;
    NSString *bookinDate;
    NSString *setUpDate;
    
    NSString *name;
    NSString *phone;
    NSString *lastLoginDate;
    int type;
}
@property NSString *deptid;

@end

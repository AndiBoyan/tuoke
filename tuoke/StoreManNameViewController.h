//
//  StoreManNameViewController.h
//  tuoke
//
//  Created by 3Vjia on 15/9/14.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ablock)(NSString *str);

@interface StoreManNameViewController : UIViewController

@property (nonatomic, copy) ablock block;

@end

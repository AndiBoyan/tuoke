//
//  StoreViewController.h
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *storeTableView;
}

@end
//
//  StoreViewController.h
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"

@interface StoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *storeTableView;
    YiRefreshHeader *refreshHeader;//下拉刷新
    YiRefreshFooter *refreshFooter;//上拉加载
}

@end

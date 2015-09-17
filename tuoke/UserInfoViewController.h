//
//  UserInfoViewController.h
//  tuoke
//
//  Created by 3Vjia on 15/9/10.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *table;
        
    NSArray *userInfoArray1;
    NSArray *userInfoArray2;
        
    
    UIImageView *faveImgView;
}
@property UIImage *faceImg;
@property NSString *name;
@property NSString *phone;
@property NSString *nickName;

@end

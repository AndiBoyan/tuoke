//
//  ViewController.m
//  tuoke
//
//  Created by 3Vjia on 15/9/9.
//  Copyright (c) 2015年 3Vjia. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "StoreViewController.h"
#import "WealthViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MainViewController *mainVC = [[MainViewController alloc]init];
    StoreViewController *storeVC = [[StoreViewController alloc]init];
    WealthViewController *wealthVC = [[WealthViewController alloc]init];
    
    mainVC.title = @"首页";
    storeVC.title = @"门店";
    wealthVC.title = @"财富";
    
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    UINavigationController *storeNav = [[UINavigationController alloc]initWithRootViewController:storeVC];
    UINavigationController *wealthNav = [[UINavigationController alloc]initWithRootViewController:wealthVC];
    
    mainNav.tabBarItem.image = [[UIImage imageNamed:@"first_normal"]
                                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"first_selected"]
                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    storeNav.tabBarItem.image = [[UIImage imageNamed:@"second_normal"]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    storeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"second_selected"]
                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    wealthNav.tabBarItem.image = [[UIImage imageNamed:@"third_normal"]
                                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    wealthNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"third_selected"]
                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = [NSArray arrayWithObjects:mainNav,storeNav,wealthNav,nil];
    
    self.tabBar.tintColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  baseViewController.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DeviceConstant.h"
#import "CustomTabBarController.h"

#define appDel (AppDelegate*)[[UIApplication sharedApplication] delegate]

@interface BaseViewController : UIViewController
{
    @protected
    ModelUser *user;
}

@property(strong,nonatomic) IBOutlet UIButton *btnBack;

@end

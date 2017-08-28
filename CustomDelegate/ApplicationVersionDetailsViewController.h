//
//  ApplicationVersionDetailsViewController.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 04/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ApplicationVersionDetailsViewControllerDelegate <NSObject>

@optional
-(void)didOkPressed;

@end

@interface ApplicationVersionDetailsViewController : UIViewController

@property(weak,nonatomic) id <ApplicationVersionDetailsViewControllerDelegate> delegate;

+(ApplicationVersionDetailsViewController*)sharedInstance;

@end

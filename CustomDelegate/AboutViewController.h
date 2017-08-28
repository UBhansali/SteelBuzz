//
//  AboutViewController.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 13/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "BaseViewController.h"

@protocol AboutViewControllerDelegate <NSObject>

@optional

-(void)aboutControllerClosePressed;

@end

@interface AboutViewController : BaseViewController

@property(weak,nonatomic) id <AboutViewControllerDelegate> delegate;

@end

//
//  FaqViewController.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 14/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaqViewControllerDelegate <NSObject>

@optional

-(void)faqControllerBackPressed;

@end

@interface FaqViewController : UIViewController

@property(weak,nonatomic) id <FaqViewControllerDelegate> delegate;

@end

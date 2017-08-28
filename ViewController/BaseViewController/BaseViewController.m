//
//  baseViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITextFieldDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate=appDel;
    if (appDelegate.user) {
        user=appDelegate.user;
    }
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
//    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
//        NSLog(@"Left Swipe");
//    }
//    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        //NSLog(@"Right Swipe");
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.btnBack) {
        if (self.navigationController.viewControllers.count>1) {
            self.btnBack.hidden=NO;
        }else{
            self.btnBack.hidden=YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)btnBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

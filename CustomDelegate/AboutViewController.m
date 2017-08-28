//
//  AboutViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 13/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "AboutViewController.h"
#import "CustomTabBarController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnClosePressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(aboutControllerClosePressed)]) {
        [self.delegate aboutControllerClosePressed];
    }
}


@end

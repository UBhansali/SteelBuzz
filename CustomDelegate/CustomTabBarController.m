//
//  CustomTabBarController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "CustomTabBarController.h"
#import "AboutViewController.h"
#import "FaqViewController.h"

@interface CustomTabBarController ()<AboutViewControllerDelegate,FaqViewControllerDelegate>
{
    UIView *tabBarView;
    AboutViewController *aboutController;
    FaqViewController *faqController;
}

@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIButton *btn2;
@property (strong, nonatomic) UIButton *btn3;
@property (strong, nonatomic) UIButton *btn4;
@property (strong, nonatomic) UIButton *btn5;
@property (weak, nonatomic) UIButton *lastSender;

@end


@implementation CustomTabBarController

-(id)init
{
    if (self=[super init]) {
        [self settUpTabBar];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self settUpTabBar];
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self settUpTabBar];
    }
    return self;
}

-(void)settUpTabBar
{
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *navControllerMember=[storyBoard instantiateViewControllerWithIdentifier:@"MemberStartPoint"];
    [viewControllers addObject:navControllerMember];
    
    UIViewController *blankController1 = [storyBoard instantiateViewControllerWithIdentifier:@"productStartPoint"];
    [viewControllers addObject:blankController1];
    
    UIViewController *blankController2 = [storyBoard instantiateViewControllerWithIdentifier:@"DialarStartPoint"];
    [viewControllers addObject:blankController2];
    
    UIViewController *blankController3 = [storyBoard instantiateViewControllerWithIdentifier:@"BuzzStartPoint"];
    [viewControllers addObject:blankController3];

    UIViewController *blankController4 = [storyBoard instantiateViewControllerWithIdentifier:@"SupportStartPoint"];
    [viewControllers addObject:blankController4];
    
    self.viewControllers=viewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tabBarView = [[[NSBundle mainBundle] loadNibNamed:@"CustomTabBarController" owner:nil options:nil] objectAtIndex:0]; 
    tabBarView.frame = CGRectMake(0.0,[[UIScreen mainScreen] bounds].size.height-70,[[UIScreen mainScreen] bounds].size.width,70);
    [self.view addSubview:tabBarView];
    
    _btn1 = (UIButton *)[tabBarView viewWithTag:1];
    [_btn1 addTarget:self action:@selector(processBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn2 = (UIButton *)[tabBarView viewWithTag:2];
    [_btn2 addTarget:self action:@selector(processBtn:) forControlEvents:UIControlEventTouchUpInside];

    _btn3 = (UIButton *)[tabBarView viewWithTag:3];
    [_btn3 addTarget:self action:@selector(processBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn4 = (UIButton *)[tabBarView viewWithTag:4];
    [_btn4 addTarget:self action:@selector(processBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn5 = (UIButton *)[tabBarView viewWithTag:5];
    [_btn5 addTarget:self action:@selector(processBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)processBtn:(UIButton *)sender {
    _lastSender = sender;
    [self setSelectedViewController:[self.viewControllers objectAtIndex:sender.tag - 1]];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    
    for (UIButton *btn in [tabBarView subviews]) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn == _lastSender) {
                btn.selected = YES;
            }
            else {
                btn.selected = NO;
                [btn setTitle:@"" forState:UIControlStateSelected];
            }
        }
    }
    [super setSelectedViewController:selectedViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayAboutController
{
    NSLog(@"%s",__func__);
    
    aboutController=[[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    aboutController.view.frame=[[UIScreen mainScreen] bounds];
    [self.view addSubview:aboutController.view];
    aboutController.delegate = self;
}

-(void)aboutControllerClosePressed
{
    [aboutController.view removeFromSuperview];
    aboutController=nil;
}

-(void)displayFAQController
{
    faqController=[[FaqViewController alloc] initWithNibName:@"FaqViewController" bundle:nil];
    faqController.view.frame=[[UIScreen mainScreen] bounds];
    [self.view addSubview:faqController.view];
    faqController.delegate = self;
}

-(void)faqControllerBackPressed
{
    [faqController.view removeFromSuperview];
    faqController=nil;
}

@end

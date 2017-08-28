//
//  ApplicationVersionDetailsViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 04/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ApplicationVersionDetailsViewController.h"

@interface ApplicationVersionDetailsViewController ()
{
    @private
    IBOutlet UILabel *lblDeviceName;
    IBOutlet UILabel *lblIOSVersion;
    IBOutlet UILabel *lblAppName;
    IBOutlet UILabel *lblAppVersion;
    IBOutlet UILabel *lblBuildNo;
}

@end

@implementation ApplicationVersionDetailsViewController

+(ApplicationVersionDetailsViewController*)sharedInstance
{
    static ApplicationVersionDetailsViewController *appDetController=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appDetController=[[ApplicationVersionDetailsViewController alloc] initWithNibName:@"ApplicationVersionDetailsViewController" bundle:nil];
    });
    return appDetController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    lblDeviceName.text=[[[UIDevice currentDevice] name] capitalizedString];
    lblIOSVersion.text=[[UIDevice currentDevice] systemVersion];
    lblAppName.text=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    lblAppVersion.text=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    lblBuildNo.text=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnOKPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didOkPressed)]) {
        [self.delegate didOkPressed];
    }
}



@end

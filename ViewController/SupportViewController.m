//
//  SupportViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "SupportViewController.h"
#import <MessageUI/MessageUI.h>
#import "ApplicationVersionDetailsViewController.h"
#import "AboutViewController.h"
#import "CustomTabBarController.h"
#import "MemberMainTableViewCell.h"

typedef NS_ENUM(NSUInteger, TableRowFor) {
    AboutUS=0,
    FAQ,
    RegisterFirm,
    ContactUS,
    WriteReview,
    Version,
    Logout,
    Total,
};

NSString static *strTableContent[]={
    [AboutUS]=@"About Us",
    [FAQ]=@"FAQ",
    [RegisterFirm]=@"Register Your Firm",
    [ContactUS]=@"Contact Us",
    [WriteReview]=@"Write a review",
    [Version]=@"Version",
    [Logout]=@"Logout",
};

@interface SupportViewController ()<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,ApplicationVersionDetailsViewControllerDelegate>
{
    @private
    MFMailComposeViewController *comp;
    CustomTabBarController *tabController;
}

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tabController=(CustomTabBarController*)self.parentViewController.parentViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Total;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str=@"MyCell";
    MemberMainTableViewCell *cell=(MemberMainTableViewCell*)[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MemberMainTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.lblFeatured.hidden=YES;
    cell.imgFeatured.hidden=YES;
    cell.imgBG.backgroundColor=[UIColor whiteColor];
    cell.lblContent.textColor=[UIColor blackColor];
    cell.vwBorder.backgroundColor=[UIColor colorWithRed:194.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0f];
    
    cell.lblContent.text=strTableContent[indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case AboutUS:
            [tabController displayAboutController];
            break;
        case FAQ:
            [tabController displayFAQController];
            break;
        case RegisterFirm:
            break;
        case ContactUS:
            [self openMailComposer];
            break;
        case WriteReview:
            
            break;
        case Version:
            [self displayAppLicationDetails];
            break;
        case Logout:
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isSignIn"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [(UINavigationController*)[[self.navigationController parentViewController] parentViewController] popToRootViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

-(void)openMailComposer
{
    comp=[[MFMailComposeViewController alloc]init];
    [comp setMailComposeDelegate:(id<MFMailComposeViewControllerDelegate>)self];
    if([MFMailComposeViewController canSendMail]) {
        [comp setToRecipients:[NSArray arrayWithObjects:@"udit@yahoo.com", nil]];
        [comp setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [self presentViewController:comp animated:YES completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if(error) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Something is wrong, please try again later." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
            [comp dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:actionOK];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    else {
        [comp dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void)displayAppLicationDetails
{
    ApplicationVersionDetailsViewController *appController=[ApplicationVersionDetailsViewController sharedInstance];
    appController.view.frame=[[UIScreen mainScreen] bounds];
    [self presentViewController:appController animated:YES completion:^{
        appController.delegate=self;
    }];
}

-(void)didOkPressed
{
    ApplicationVersionDetailsViewController *appController=[ApplicationVersionDetailsViewController sharedInstance];
    [appController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
}

@end


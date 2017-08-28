//
//  ResetPaswordViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ResetPaswordViewController.h"
#import "ResetPasswordWebService.h"

@interface ResetPaswordViewController ()
{
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtConfirmPassword;
}

@end

@implementation ResetPaswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)alertChecking
{
    BOOL flag=YES;
    NSString *strMsg=@"";
    if ([txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        flag=NO;
        strMsg=@"Please enter the password";
    }
    if ([txtConfirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        flag=NO;
        strMsg=@"Please enter the confirm password";
    }
    if (![txtPassword.text isEqualToString:txtConfirmPassword.text]) {
        flag=NO;
        strMsg=@"Password and Confirm Password are mismatching, Please enter the password and confirm password";
    }
    if (!flag) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:actionOK];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    return flag;
}

-(IBAction)btnSubmitPressed:(id)sender
{
    if ([self alertChecking]) {
        [[ResetPasswordWebService service] callForgetPasswordWebServiceForEmailID:[self.strEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] Password:txtPassword.text WithCompletionHandler:^(id result, BOOL isError, NSString *strMsg) {
            if (isError) {
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }];
                [alertController addAction:actionOK];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}

-(IBAction)btnCancelPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

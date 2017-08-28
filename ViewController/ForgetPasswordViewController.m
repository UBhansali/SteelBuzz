//
//  FogetPasswordViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordWebService.h"
#import "ResetPaswordViewController.h"

@interface ForgetPasswordViewController ()
{
    IBOutlet UITextField *txtEmail;
}

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)isValidEmail:(NSString*)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL)alertChecking
{
    BOOL flag=YES;
    NSString *strMsg=@"";
    if ([txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        flag=NO;
        strMsg=@"Please enter the email";
    }
    if (![self isValidEmail:txtEmail.text]) {
        flag=NO;
        strMsg=@"Please enter a valid email";
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
        [[ForgetPasswordWebService service] callForgetPasswordWebServiceForEmailID:[txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] WithCompletionHandler:^(id result, BOOL isError, NSString *strMsg) {
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
                [self performSegueWithIdentifier:@"ResetPaswordViewController" sender:self];
            }
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ResetPaswordViewController"]) {
        ResetPaswordViewController *master=[segue destinationViewController];
        master.strEmail=txtEmail.text;
    }
}

-(IBAction)btnCancelPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

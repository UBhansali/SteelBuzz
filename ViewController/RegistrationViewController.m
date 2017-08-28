//
//  RegistrationViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "RegistrationViewController.h"
#import "RegistrationWebService.h"

@interface RegistrationViewController ()<UITextFieldDelegate>
{
    IBOutlet UITextField *txtFirstName;
    IBOutlet UITextField *txtLastName;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
}

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField setReturnKeyType:UIReturnKeyDone];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)alertChecking
{
    if ([txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter your first name." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        return NO;
    }
    
    if ([txtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter your last name." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        return NO;
    }
    
    if ([txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter your email." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        return NO;
    }
    
    if ([txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter your user name." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        return NO;
    }
    
    return YES;
}

-(IBAction)btnCreateAccountPresed:(id)sender
{
    if ([self alertChecking]) {
        [[RegistrationWebService service] callRegistrationServiceForFirstName:txtFirstName.text LastName:txtLastName.text Email:txtEmail.text Password:txtPassword.text UserName:nil  WithCompletionHandler:^(id result, BOOL isError, NSString *strMsg) {
            if (isError) {
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }else{
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Success" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }
        }];
    }
}



@end

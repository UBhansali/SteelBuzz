//
//  LoginViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginWebService.h"
#import "ModelUser.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "RegistrationWebService.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <TwitterKit/TwitterKit.h>

static NSString * const kClientId = @"946840916964-9ie92e0s2e4j0o6so1m6kfd1pinpgs4u.apps.googleusercontent.com";

@interface LoginViewController ()<UITextFieldDelegate,GPPSignInDelegate>
{
    IBOutlet UITextField *txtUserName;
    IBOutlet UITextField *txtPassword;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isSignIn"]) {
        [self performSegueWithIdentifier:@"segueToSuccess" sender:self];
    }
    
    
    // Do any additional setup after loading the view.
    
    txtUserName.text=@"aa@aa.aa";
    txtPassword.text=@"aa";
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;
    signIn.clientID = kClientId;
    signIn.scopes = @[ kGTLAuthScopePlusUserinfoEmail,kGTLAuthScopePlusUserinfoEmail ];  // "https://www.googleapis.com/auth/plus.login" scope
    signIn.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnGoToRegistrationPressed:(id)sender
{
    [self performSegueWithIdentifier:@"segueToRegistration" sender:self];
}

-(BOOL)alertChecking
{
    if ([txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
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
    if ([txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter your password." preferredStyle:UIAlertControllerStyleAlert];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)btnLoginPressed:(id)sender
{
    if ([self alertChecking]) {
        [self.view endEditing:YES];
        [[LoginWebService service] callLoginServiceForUserName:txtUserName.text Password:txtPassword.text WithCompletionHandler:^(id result, BOOL isError, NSString *strMsg) {
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
                AppDelegate *del=appDel;
                del.user=(ModelUser*)result;
                UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Success" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    [self performSegueWithIdentifier:@"segueToSuccess" sender:self];
                }];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
            }
        }];
    }
}

-(IBAction)btnFBPressed:(id)sender
{
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]
                                        initWithGraphPath:@"me" parameters:nil];
        FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
        
        [connection addRequest:requestMe
             completionHandler:^(FBSDKGraphRequestConnection *connection, id resultGraph, NSError *error) {
                 //TODO: process me information
                 NSLog(@"fetched user:%@", resultGraph);
                 NSDictionary *dictUser=(NSDictionary*)resultGraph;
                 [self callLoginServiceWithFirstName:[[[dictUser objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0] LastName:[[[dictUser objectForKey:@"name"] componentsSeparatedByString:@" "] lastObject] UserName:[dictUser objectForKey:@"id"] Password:@"00" Email:@""];
             }];
        [connection start];
    }else{
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                
            } else if (result.isCancelled) {
                
            } else {
                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                              initWithGraphPath:@"me"
                                              parameters:nil
                                              HTTPMethod:@"GET"];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                      id resultGraph,
                                                      NSError *error) {
                    NSLog(@"fetched user:%@", resultGraph);
                    NSDictionary *dictUser=(NSDictionary*)resultGraph;
                    
                    [self callLoginServiceWithFirstName:[[[dictUser objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0] LastName:[[[dictUser objectForKey:@"name"] componentsSeparatedByString:@" "] lastObject] UserName:[dictUser objectForKey:@"id"] Password:@"00" Email:@""];
                }];
            }
        }];
    }
}

-(IBAction)btnGooglePlusPressed:(id)sender
{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    [signIn authenticate];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        NSLog(@"oAuth = %@",auth);
        
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
        plusService.retryEnabled = YES;
        [plusService setAuthorizer:auth];
        
        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
        
        [plusService executeQuery:query
                completionHandler:^(GTLServiceTicket *ticket,
                                    GTLPlusPerson *person,
                                    NSError *error) {
                    if (error) {
                        GTMLoggerError(@"Error: %@", error);
                    } else {
                        NSMutableDictionary *dictResponse=person.JSON;
                        

                        [self callLoginServiceWithFirstName:[[dictResponse objectForKey:@"name"] objectForKey:@"givenName"] LastName:[[dictResponse objectForKey:@"name"] objectForKey:@"familyName"] UserName:[dictResponse objectForKey:@"id"] Password:@"00" Email:[[[dictResponse objectForKey:@"emails"] objectAtIndex:0] objectForKey:@"value"]];
                    }
                }];
    }
}

-(IBAction)btnTwitterPressed:(id)sender
{
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        // play with Twitter session
        NSLog(@"session = %@",session);
        
        [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID]
                                                  completion:^(TWTRUser *TWTRuser,
                                                               NSError *error)
         {
             // handle the response or error
             if (![error isEqual:nil]) {
                 NSLog(@"Twitter info   -> user = %@ ",TWTRuser);
                 NSString *urlString = [[NSString alloc]initWithString:TWTRuser.profileImageLargeURL];
                 NSURL *url = [[NSURL alloc]initWithString:urlString];
                 NSData *pullTwitterPP = [[NSData alloc]initWithContentsOfURL:url];
                 
                 UIImage *profImage = [UIImage imageWithData:pullTwitterPP];
                 NSLog(@"Name = %@ ",TWTRuser.name);
                 NSLog(@"screenName = %@ ",TWTRuser.screenName);
                 NSLog(@"userID = %@ ",TWTRuser.userID);
                 NSLog(@"formattedScreenName = %@ ",TWTRuser.formattedScreenName);
                 [self callLoginServiceWithFirstName:[[TWTRuser.name componentsSeparatedByString:@" "] objectAtIndex:0] LastName:[[TWTRuser.name componentsSeparatedByString:@" "] lastObject] UserName:TWTRuser.userID Password:@"00" Email:@""];
             } else {
                 NSLog(@"Twitter error getting profile : %@", [error localizedDescription]);
                 
             }
         }];
    }];
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];
    logInButton.hidden=YES;
    [logInButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)callLoginServiceWithFirstName:(NSString*)strFirstName LastName:(NSString*)strLastName UserName:(NSString*)strUserName Password:(NSString*)strPassword Email:(NSString*)strEmail
{
    [[RegistrationWebService service] callRegistrationServiceForFirstName:strFirstName LastName:strLastName Email:strEmail Password:strPassword UserName:strUserName WithCompletionHandler:^(id result, BOOL isError, NSString *strMsg) {
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
            AppDelegate *del=appDel;
            del.user=(ModelUser*)result;
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Success" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                }];
                [self performSegueWithIdentifier:@"segueToSuccess" sender:self];
            }];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
        }
    }];
}

@end

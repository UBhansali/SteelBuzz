//
//  DialarViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>

@implementation NSString (FindPreviousNo)

-(NSString*)getCallingNo
{
    if (self) {
        if (self.length<4) {
            return nil;
        }else{
            NSInteger p=0;
            NSInteger val=[self integerValue];
            if(val>=1000 && val<=1099){
                p = 6645;
            }else if(val>=1100 && val<=1299){
                p = 6752;
            }else if(val>=1300 && val<=1499){
                p = 6615;
            }else if(val>=1500 && val<=1679){
                p = 6658;
            }else if(val>=1680 && val<=1999){
                p = 6615;
            }else if(val>=2000 && val<=3499){
                p = 6636;
            }else if(val>=3500 && val<=4999){
                p = 6639;
            }else if(val>=5000 && val<=5999){
                p = 6659;
            }else if(val>=6000 && val<=6399){
                p = 6749;
            }else if(val>=6400 && val<=6999){
                p = 6743;
            }else if(val>=7000 && val<=7099){
                p = 6615;
            }else if(val>=7100 && val<=7999){
                p = 6743;
            }else if(val>=8000 && val<=8099){
                p = 6615;
            }else if(val>=8100 && val<=8499){
                p = 6743;
            }else if(val>=8500 && val<=8999){
                p = 6651;
            }else if(val>=9000 && val<=9099){
                p = 6615;
            }else if(val>=9100 && val<=9199){
                p = 6743;
            }else if(val>=9200 && val<=9999){
                p = 6610;
            }
            return ([NSString stringWithFormat:@"022%ld%@",(long)p,self]);
        }
    }
    return nil;
}

@end

#import "DialarViewController.h"

@interface DialarViewController ()
{
    IBOutlet UILabel *lblNo;
    
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    IBOutlet UIButton *btn3;
    IBOutlet UIButton *btn4;
    IBOutlet UIButton *btn5;
    IBOutlet UIButton *btn6;
    IBOutlet UIButton *btn7;
    IBOutlet UIButton *btn8;
    IBOutlet UIButton *btn9;
    IBOutlet UIButton *btn0;
}

@end

@implementation DialarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    btn0.layer.cornerRadius=btn0.frame.size.width/2;
//    btn1.layer.cornerRadius=btn1.frame.size.width/2;
//    btn2.layer.cornerRadius=btn2.frame.size.width/2;
//    btn3.layer.cornerRadius=btn3.frame.size.width/2;
//    btn4.layer.cornerRadius=btn4.frame.size.width/2;
//    btn5.layer.cornerRadius=btn5.frame.size.width/2;
//    btn6.layer.cornerRadius=btn6.frame.size.width/2;
//    btn7.layer.cornerRadius=btn7.frame.size.width/2;
//    btn8.layer.cornerRadius=btn8.frame.size.width/2;
//    btn9.layer.cornerRadius=btn9.frame.size.width/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnPressed:(id)sender
{
    if (lblNo.text.length<4) {
        UIButton *btn=(UIButton*)sender;
        lblNo.text=[NSString stringWithFormat:@"%@%@",lblNo.text,btn.titleLabel.text];
    }
}

-(IBAction)btnClearPressed:(id)sender
{
    lblNo.text=@"";
}

-(IBAction)btnCallPressed:(id)sender
{
    if (lblNo.text.length>0 && lblNo.text.length==4) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Are you sure to make this call" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYES=[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
            [self makeCall];
        }];
        UIAlertAction *actionNo=[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        [alertController addAction:actionYES];
        [alertController addAction:actionNo];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}

-(void)makeCall
{
    NSString *strCallingNo=[lblNo.text getCallingNo];
    NSLog(@"Calling No= %@",strCallingNo);
    NSString *phoneNumber = [@"tel://" stringByAppendingString:strCallingNo];
    lblNo.text=@"";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:phoneNumber]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }else{
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Your device does not support the calling feature." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}

@end

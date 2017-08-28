//
//  FaqViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 14/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "FaqViewController.h"
#import "FAQTableViewCell.h"

@interface FaqViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblList;
}

@end

@implementation FaqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tblList.estimatedRowHeight=35.0f;
    tblList.rowHeight=UITableViewAutomaticDimension;
    [tblList reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if (section==1){
        return 19;
    }
    return 0;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 30.0f;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"MyCell";
    FAQTableViewCell *cell=(FAQTableViewCell*)[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FAQTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    NSString *strMsg=@"";
    if (indexPath.section==0) {
        strMsg=@"This FAQ provides answers to basic questions about Steel Buzz. If you cannot find an answer to your question, then please submit a support ticket and we will be happy to help you!";
        cell.lblContent.textColor=[UIColor grayColor];
        cell.lblContent.text=strMsg;
    }
    else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                strMsg=@"What is Steel Buzz?";
                break;
            case 1:
                strMsg=@"Steel Buzz is smart directory which connects the Asia’s largest steel industry.";
                break;
            case 2:
                strMsg=@"How do I use Steel Buzz?";
                break;
            case 3:
                strMsg=@"First of all you need to download our application either on your iOS or Android device. Once you have downloaded the application, you can use it for FREE for one week without signing up. After one week you will need to Sign up for FREE in order to gain full access to the application.";
                break;
            case 4:
                strMsg=@"How should I register my company with Steel Buzz?";
                break;
            case 5:
                strMsg=@"Please use the Register Your Firm form or you can create a support ticket on our website to submit information about your company.";
                break;
            case 6:
                strMsg=@"How can I update my company's information?";
                break;
            case 7:
                strMsg=@"You can create a new support ticket and provide us with new updated details. Make sure you attach a copy of your business card in order for us to verify the information and we will update it in no time.";
                break;
            case 8:
                strMsg=@"What are the costs to join Steel Buzz?";
                break;
            case 9:
                strMsg=@"Membership with Steel Buzz is completely FREE. It doesn’t cost anything to join Steel Buzz. If your company is not registered with us, then just create a support ticket to ‘Register a New Company’ and submit your company details and we will take care of the rest from there on.";
                break;
            case 10:
                strMsg=@"Does Steel Buzz work in offline mode?";
                break;
            case 11:
                strMsg=@"Yes, it works without an active internet connection. You only need to connect to our web servers once and then you can access Steel Buzz without an active Internet connection.";
                break;
            case 12:
                strMsg=@"Can I access Steel Buzz from my mobile phone or tablet?";
                break;
            case 13:
                strMsg=@"You will be able to ACCESS Steel Buzz on iPhones, and Android devices; however, you cannot access our directory from a mobile device, laptop or desktop computer. We are seamlessly working to make the data accessible from any device which has Internet connectivity.";
                break;
            case 14:
                strMsg=@"Why am I being asked to register?";
                break;
            case 15:
                strMsg=@"The application is fairly new and we are trying to keep the database free from spammers and scammers. By signing up, you claim your company's profile, verify your profile and even update details like address, phone number, fax number, email id and website URL.";
                break;
            case 16:
                strMsg=@"What are the benefits of registering with Steel Buzz?";
                break;
            case 17:
                strMsg=@"There are many benefits of signing up with Steel Buzz for Free:\n\nYou can claim your company's profile and by doing this your company gets a verified profile badge. This also creates a sense of security for End-User, if they are planning to work with your esteemed company.\n                You get access to feeds on Buzz Storm page which gives you\nYou get connected with us. For all future updates and new features you will be the first one to get notified!\nYou get access to data in the application even when you are not connected to the Internet.";
                break;
            case 18:
                strMsg=@"Where is Steel Buzz?";
                break;
            case 19:
                strMsg=@"Based in Boston, Massachusetts, Steel Buzz’s collaborative office is located in Mumbai, India.";
                break;
                
            default:
                break;
        }
        cell.lblContent.text=strMsg;
        if (indexPath.row%2==0) {
            cell.lblContent.textColor=[UIColor blueColor];
        }else{
            cell.lblContent.textColor=[UIColor blackColor];
        }
    }
    
    cell.backgroundColor=cell.contentView.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(IBAction)btnBackPressed:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(faqControllerBackPressed)]) {
        [self.delegate faqControllerBackPressed];
    }
}

@end

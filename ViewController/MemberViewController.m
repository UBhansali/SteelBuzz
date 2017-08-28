//
//  MemberViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelMember.h"

@implementation NSMutableArray (IndexedArray)

-(id)getSortedArray
{
    NSMutableDictionary *dictResult=[NSMutableDictionary dictionary];
    for (int i=0; i<self.count; i++) {
        
        ModelMember *objMember=[self objectAtIndex:i];
        NSString *strFirst=[[objMember.strMembersName substringToIndex:1] uppercaseString];
        
        if ([[dictResult allKeys] containsObject:strFirst]) {
            NSMutableArray *arrTemp=(NSMutableArray*)[dictResult objectForKey:strFirst];
            [arrTemp addObject:objMember];
            [dictResult removeObjectForKey:strFirst];
            [dictResult setObject:arrTemp forKey:strFirst];
        }else{
            NSMutableArray *arrTemp=[NSMutableArray array];
            [arrTemp addObject:objMember];
            [dictResult setObject:arrTemp forKey:strFirst];
        }
    }
    NSLog(@"dictResult = %@",[dictResult allKeys]);
    return dictResult;
}

-(NSMutableArray*)searchingArrayForString:(NSString*)strSearchString
{
    NSMutableArray *arrResult=[NSMutableArray array];
    for (int i=1; i<self.count; i++) {
        ModelMember *objMember=self[i];
        if ([objMember.strMembersName rangeOfString:strSearchString options:NSCaseInsensitiveSearch].location == NSNotFound) {
            // no ( or ) in the string
        } else {
            // ( or ) are present
            [arrResult addObject:[[ModelMember alloc] initWithCopy:objMember]];
        }
    }
    return arrResult;
}

@end



#import "MemberViewController.h"
#import "MemberListWebService.h"
#import "ModelMember.h"
#import "MemberDetailsViewController.h"
#import "MemberMainTableViewCell.h"

@interface MemberViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    IBOutlet UITableView *tblMembers;
    IBOutlet UITableView *tblSearch;
    
    IBOutlet NSLayoutConstraint *consIconCenter;
    IBOutlet UITextField *txtSearch;
    IBOutlet UIButton *btnSearch;
    
    NSMutableArray *arrResult,*arrSortedKey,*arrSearchingArray;
    NSMutableDictionary *dictSortedArray;
    
    ModelMember *objMemberSelected;
    
    UIRefreshControl *refreshControl;
}

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isSignIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    arrResult=nil;
    // Do any additional setup after loading the view.
    
    arrSearchingArray=[NSMutableArray array];
    tblSearch.hidden=YES;
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor clearColor];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self
                            action:@selector(loadWebServiceData)
                  forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Please wait"];
    [tblMembers addSubview:refreshControl];
    
//    tblMembers.estimatedRowHeight=30.0f;
//    tblMembers.rowHeight=UITableViewAutomaticDimension;
//    tblSearch.estimatedRowHeight=30.0f;
//    tblSearch.rowHeight=UITableViewAutomaticDimension;
    
    [self loadWebServiceData];
}

-(void)loadWebServiceData
{
    [[MemberListWebService service] callAllMemberListServiceWithCompletionHandler:^(id result, BOOL isError, NSString *strMsg) {
        if (refreshControl.isRefreshing) {
            [refreshControl endRefreshing];
        }
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
            arrResult=(NSMutableArray*)result;
            dictSortedArray=[arrResult getSortedArray];
            arrSortedKey=[NSMutableArray arrayWithArray:[dictSortedArray allKeys]];
            
            NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
            arrSortedKey = [[arrSortedKey sortedArrayUsingDescriptors:@[sd]] mutableCopy];
            
            [tblMembers reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==tblMembers) {
        return arrSortedKey.count;
    }
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tblMembers) {
        return [(NSMutableArray*)[dictSortedArray objectForKey:[arrSortedKey objectAtIndex:section]] count];
    }
    else if (tableView==tblSearch)
        return arrSearchingArray.count;
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"MyCell";
    UITableViewCell *myCell;
    
    if (tableView==tblMembers) {
        MemberMainTableViewCell *cell=(MemberMainTableViewCell*)[tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MemberMainTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        
        if (indexPath.row>=0 && indexPath.row<=2) {
            cell.lblContent.textColor=[UIColor whiteColor];
            cell.imgBG.backgroundColor=[UIColor colorWithRed:1.0f/255.0f green:105.0f/255.0f blue:168.0f/255.0f alpha:1.0f];
            cell.vwBorder.backgroundColor=[UIColor colorWithRed:47.0f/255.0f green:136.0f/255.0f blue:179.0f/255.0f alpha:1.0f];
        }else{
            cell.lblFeatured.hidden=YES;
            cell.imgFeatured.hidden=YES;
            cell.imgBG.backgroundColor=[UIColor whiteColor];
            cell.lblContent.textColor=[UIColor blackColor];
            cell.vwBorder.backgroundColor=[UIColor colorWithRed:194.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0f];
        }
        
        ModelMember *objMember=[(NSMutableArray*)[dictSortedArray objectForKey:[arrSortedKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        cell.lblContent.text=objMember.strMembersName;
        
        cell.backgroundColor=cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        myCell=cell;
    }
    if (tableView==tblSearch) {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        ModelMember *objMember=[arrSearchingArray objectAtIndex:indexPath.row];
        cell.textLabel.numberOfLines=0;
        [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        cell.textLabel.text=objMember.strMembersName;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        cell.backgroundColor=cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        myCell=cell;
    }
    return myCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tblMembers) {
        objMemberSelected=[(NSMutableArray*)[dictSortedArray objectForKey:[arrSortedKey objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }else{
        objMemberSelected=[arrSearchingArray objectAtIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:@"segueToMemberDetail" sender:self];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView==tblMembers) {
        return (NSArray*)arrSortedKey;
    }
    return nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueToMemberDetail"]) {
        MemberDetailsViewController *master=segue.destinationViewController;
        master.objMember=objMemberSelected;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resetSearch
{
    txtSearch.text=@"Search";
    consIconCenter.constant=0.0f;
    btnSearch.hidden=NO;
    tblSearch.hidden=YES;
    tblMembers.hidden=NO;
    [arrSearchingArray removeAllObjects];
    [tblSearch reloadData];
    [txtSearch resignFirstResponder];
    [self.view endEditing:YES];
}

-(IBAction)txtFieldTapped:(id)sender
{
    if (arrResult.count>0) {
        NSLog(@"%s",__func__);
        txtSearch.text=@"";
        btnSearch.hidden=YES;
        tblMembers.hidden=YES;
        tblSearch.hidden=NO;
        [UIView animateWithDuration:10 animations:^{
            if (IsIpad) {
                
            }else{
                if (IsIphone4s) {
                    consIconCenter.constant=-100.0f;
                }
                else if (IsIphone5_5s){
                    consIconCenter.constant=-100.0f;
                }
                else if (IsIphone6){
                    consIconCenter.constant=-135.0f;
                }
                else if (IsIphone6Plus){
                    consIconCenter.constant=-155.0f;
                }
            }
        } completion:^(BOOL finished) {
            [txtSearch becomeFirstResponder];
            txtSearch.clearButtonMode=UITextFieldViewModeWhileEditing;
        }];
    }else{
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Error" message:@"Please wait untill the main list of member will not appear." preferredStyle:UIAlertControllerStyleAlert];
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

-(IBAction)txtFieldValueChanged:(id)sender
{
    NSLog(@"%s",__func__);
    arrSearchingArray=[arrResult searchingArrayForString:txtSearch.text];
    [tblSearch reloadData];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType=UIReturnKeyDone;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self resetSearch];
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}


@end

//
//  CategoryMemberViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/08/15.
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

#import "CategoryMemberViewController.h"
#import "MemberDetailsViewController.h"

@interface CategoryMemberViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrSearchingArray;
    IBOutlet UITableView *tblSearch;
    IBOutlet UITextField *txtSearch;
    ModelMember *objMemberSelected;
}

@end

@implementation CategoryMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrSearchingArray=_arrSelectedMember;
    
    tblSearch.estimatedRowHeight=30.0f;
    tblSearch.rowHeight=UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)txtFieldValueChanged:(id)sender
{
    NSLog(@"%s",__func__);
    UITextField *txtField=(UITextField*)sender;
    if (txtField.text.length==0) {
        arrSearchingArray=_arrSelectedMember;
        [tblSearch reloadData];
        return;
    }
    arrSearchingArray=[_arrSelectedMember searchingArrayForString:txtSearch.text];
    [tblSearch reloadData];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    txtSearch.text=@"";
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    txtSearch.text=@"Search";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    if (tableView==tblSearch)
        return arrSearchingArray.count;
    return 0;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 30.0f;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"MyCell";
    UITableViewCell *myCell;
    if (tableView==tblSearch) {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        ModelMember *objMember=[arrSearchingArray objectAtIndex:indexPath.row];
        cell.textLabel.lineBreakMode=0;
        cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
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
    if (tableView==tblSearch){
        objMemberSelected=[arrSearchingArray objectAtIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:@"segueToMemberDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueToMemberDetail"]) {
        MemberDetailsViewController *master=segue.destinationViewController;
        master.objMember=objMemberSelected;
    }
}

@end

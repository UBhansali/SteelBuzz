//
//  MemberDetailsViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "MemberDetailsViewController.h"
#import "MemberDetailTab.h"
#import "DetailTableViewCellAddress.h"
#import "MemberDetailHeaderTableViewCell.h"

@interface MemberDetailsViewController ()<MemberDetailTabDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView *vwTabPanel;
    IBOutlet UITableView *tblDetails;
    NSInteger selectedIndex;
    
    IBOutlet UILabel *lblCompanyName;
    IBOutlet UILabel *lblStateContryName;
    IBOutlet UIImageView *imgBadge;
}

@end

@implementation MemberDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    lblCompanyName.text = self.objMember.strMembersName;
    lblStateContryName.text = [NSString stringWithFormat:@"%@,%@",self.objMember.strCity,self.objMember.strCountry];
    if ([self.objMember.strStatus boolValue]) {
        imgBadge.hidden=NO;
    }else{
        imgBadge.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MemberDetailTab *tab=[[MemberDetailTab alloc] initWithFrame:CGRectMake(0, 0, vwTabPanel.frame.size.width, vwTabPanel.frame.size.height)];
    tab.delegate=self;
    [vwTabPanel addSubview:tab];
}

-(void)didSelectedTabIndex:(NSInteger)tabIndex
{
    NSLog(@"index = %ld",(long)tabIndex);
    selectedIndex=tabIndex;
    [tblDetails reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (selectedIndex==1) {
        return 2;
    }
    else if (selectedIndex==2){
        return 3;
    }
    else if (selectedIndex==3){
        return 3;
    }
    else if (selectedIndex==4){
        return 2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (selectedIndex==1) {
        return 40.0f;
    }
    else if (selectedIndex==2){
        return 40.0f;
    }
    else if (selectedIndex==3){
        return 40.0f;
    }
    else if (selectedIndex==4){
        return 40.0f;
    }
    return 0.0f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vwHeader;
    static NSString *strTemp=@"MyCell1";
    if (selectedIndex==1) {
        MemberDetailHeaderTableViewCell *cell=(MemberDetailHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:strTemp];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MemberDetailHeaderTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        if (section==0) {
            cell.lblContent.text = @"Address";
            cell.imgLeft.image=[UIImage imageNamed:@"ic_location_black.png"];
        }
        else if (section==1){
            cell.lblContent.text = @"Contact Person";
            cell.imgLeft.image=[UIImage imageNamed:@"first-name-icon.png"];
        }
        vwHeader=cell;
    }
    else if (selectedIndex==2){
        MemberDetailHeaderTableViewCell *cell=(MemberDetailHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:strTemp];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MemberDetailHeaderTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        if (section==0) {
            cell.lblContent.text = @"Phone:";
            cell.imgLeft.image=[UIImage imageNamed:@"ic_location_black.png"];
        }
        else if (section==1){
            cell.lblContent.text = @"Mobile:";
            cell.imgLeft.image=[UIImage imageNamed:@"ic_location_black.png"];
        }
        else if (section==2){
            cell.lblContent.text = @"Hughes:";
            cell.imgLeft.image=[UIImage imageNamed:@"first-name-icon.png"];
        }
        vwHeader=cell;
    }
    else if (selectedIndex==3){
        MemberDetailHeaderTableViewCell *cell=(MemberDetailHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:strTemp];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MemberDetailHeaderTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        if (section==0) {
            cell.lblContent.text = @"Email:";
            cell.imgLeft.image=[UIImage imageNamed:@"ic_location_black.png"];
        }
        else if (section==1){
            cell.lblContent.text = @"Website:";
            cell.imgLeft.image=[UIImage imageNamed:@"first-name-icon.png"];
        }
        else if (section==2){
            cell.lblContent.text = @"Fax:";
            cell.imgLeft.image=[UIImage imageNamed:@"first-name-icon.png"];
        }
        vwHeader=cell;
    }
    else if (selectedIndex==4){
        MemberDetailHeaderTableViewCell *cell=(MemberDetailHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:strTemp];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MemberDetailHeaderTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        if (section==0) {
            cell.lblContent.text = @"Address:";
            cell.imgLeft.image=[UIImage imageNamed:@"ic_location_black.png"];
        }
        else if (section==1){
            cell.lblContent.text = @"Contact Person:";
            cell.imgLeft.image=[UIImage imageNamed:@"first-name-icon.png"];
        }
        vwHeader=cell;
    }
    return vwHeader;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectedIndex==1) {
        return 1;
    }
    else if (selectedIndex==2){
        if (section==0) {
            return [self.objMember.strPhoneNo componentsSeparatedByString:@"/"].count;
        }
        if (section==1) {
            return [self.objMember.strMobileNo componentsSeparatedByString:@"/"].count;
        }
        if (section==0) {
            return [self.objMember.strHughes componentsSeparatedByString:@"/"].count;
        }
    }
    else if (selectedIndex==3){
        if (section==0) {
            return [self.objMember.strEmail componentsSeparatedByString:@"/"].count;
        }
        if (section==1) {
            return [self.objMember.strWeb componentsSeparatedByString:@"/"].count;
        }
        if (section==0) {
            return [self.objMember.strFax componentsSeparatedByString:@"/"].count;
        }
    }
    else if (selectedIndex==4){
        return 0;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex==1) {
        return 103.0f;
    }
    else if (selectedIndex==2){
        return 50.0f;
    }
    else if (selectedIndex==3){
        return 50.0f;
    }
    else if (selectedIndex==4){
        return 50.0f;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell=@"MyCell";
    UITableViewCell *myCell;
    if (selectedIndex==1) {
        DetailTableViewCellAddress *cell=(DetailTableViewCellAddress*)[tableView dequeueReusableCellWithIdentifier:strCell];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCellAddress" owner:self options:nil] objectAtIndex:0];
        }
        if (indexPath.row==0 && indexPath.section==0) {
            cell.lblHeading.text=@"Address";
            cell.lblContent.text=self.objMember.strAddress;
        }
        if (indexPath.row==0 && indexPath.section==1) {
            cell.lblHeading.text=@"Contact Person";
            cell.lblContent.text=self.objMember.strContactPerson;
        }
        myCell=cell;
    }
    else if (selectedIndex==2){
        DetailTableViewCellAddress *cell=(DetailTableViewCellAddress*)[tableView dequeueReusableCellWithIdentifier:strCell];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCellAddress" owner:self options:nil] objectAtIndex:0];
        }
        
        if (indexPath.section==0) {
            cell.lblContent.text=[[self.objMember.strPhoneNo componentsSeparatedByString:@"/"] objectAtIndex:indexPath.row];
        }
        else if (indexPath.section==1) {
            cell.lblContent.text=[[self.objMember.strMobileNo componentsSeparatedByString:@"/"] objectAtIndex:indexPath.row];
        }
        else if (indexPath.section==2) {
            cell.lblContent.text=[[self.objMember.strHughes componentsSeparatedByString:@"/"] objectAtIndex:indexPath.row];
        }
        myCell=cell;
    }
    else if (selectedIndex==3){
        DetailTableViewCellAddress *cell=(DetailTableViewCellAddress*)[tableView dequeueReusableCellWithIdentifier:strCell];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCellAddress" owner:self options:nil] objectAtIndex:0];
        }
        if (indexPath.section==0) {
            cell.lblContent.text=[[self.objMember.strEmail componentsSeparatedByString:@"/"] objectAtIndex:indexPath.row];
        }
        else if (indexPath.section==1) {
            cell.lblContent.text=[[self.objMember.strWeb componentsSeparatedByString:@"/"] objectAtIndex:indexPath.row];
        }
        else if (indexPath.section==2) {
            cell.lblContent.text=[[self.objMember.strFax componentsSeparatedByString:@"/"] objectAtIndex:indexPath.row];
        }
        myCell=cell;
    }
    else if (selectedIndex==4){
        DetailTableViewCellAddress *cell=(DetailTableViewCellAddress*)[tableView dequeueReusableCellWithIdentifier:strCell];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCellAddress" owner:self options:nil] objectAtIndex:0];
        }
        cell.lblHeading.text=@"Fax No";
        cell.lblContent.text=self.objMember.strFax;
        myCell=cell;
    }
    return myCell;
}


@end

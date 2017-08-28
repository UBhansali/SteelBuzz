//
//  BuzzViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "BuzzViewController.h"
#import "BuzzListWebService.h"
#import "ModelBuzz.h"
#import "BuzzTableViewCell.h"
#import "BuzzDetailsViewController.h"

static NSString *cellIdentifier;

@interface BuzzViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblBuzz;
    NSMutableArray *arrDisplay;
    ModelBuzz *objSelected;
}

@end

@implementation BuzzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cellIdentifier=@"MyCell";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[BuzzListWebService service] callBuzzListServiceWithCompletionHandler:^(id result, BOOL isError, NSString *strMsg) {
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
            arrDisplay=(NSMutableArray*)result;
            [tblBuzz reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrDisplay.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=0.0f;
    BuzzTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BuzzTableViewCell" owner:self options:nil] lastObject];
    }
    if (arrDisplay.count>0) {
        ModelBuzz *obj=[arrDisplay objectAtIndex:indexPath.row];
        cell.lblTop.text=obj.strTitle;
        cell.lblBottom.text=obj.strDate;
        
        if (cell.lblTop.text.length>0) {
            cell.lblTop.attributedText=[[NSAttributedString alloc] initWithString:cell.lblTop.text attributes:@{NSFontAttributeName: cell.lblTop.font}];
            cell.lblTop.lineBreakMode=NSLineBreakByWordWrapping;
            height+=[cell.lblTop sizeThatFits:CGSizeMake(cell.lblTop.frame.size.width, CGFLOAT_MAX)].height;
            NSLog(@"height= %f",height);
        }
        if (cell.lblBottom.text.length>0) {
            cell.lblBottom.attributedText=[[NSAttributedString alloc] initWithString:cell.lblBottom.text attributes:@{NSFontAttributeName: cell.lblBottom.font}];
            cell.lblBottom.lineBreakMode=NSLineBreakByWordWrapping;
            height+=[cell.lblBottom sizeThatFits:CGSizeMake(cell.lblBottom.frame.size.width, CGFLOAT_MAX)].height;
            NSLog(@"height= %f",height);
        }
    }
    NSLog(@"height= %f",height);
    cell=nil;
    return height+50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"CELL";
    BuzzTableViewCell *cell=(BuzzTableViewCell*)[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BuzzTableViewCell" owner:self options:nil] lastObject];
    }
    ModelBuzz *obj=[arrDisplay objectAtIndex:indexPath.row];
    cell.lblTop.text=obj.strTitle;
    cell.lblBottom.text=obj.strDate;
    
    [cell.imgBG.layer setShadowColor:[UIColor blackColor].CGColor];
    [cell.imgBG.layer setShadowOpacity:0.6f];
    [cell.imgBG.layer setShadowRadius:3.0f];
    [cell.imgBG.layer setShadowOffset:CGSizeMake(2.0f, 2.0f)];
    
    cell.backgroundColor=cell.contentView.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objSelected=[arrDisplay objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"BuzzDetailsViewController" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BuzzDetailsViewController"]) {
        BuzzDetailsViewController *master=segue.destinationViewController;
        master.buzzSelected=objSelected;
    }
}


@end

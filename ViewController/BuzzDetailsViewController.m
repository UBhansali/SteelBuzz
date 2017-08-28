//
//  BuzzDetailsViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 30/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "BuzzDetailsViewController.h"
#import "DownloadableImageView.h"
#import "BuzzDetailTableViewCell.h"

@interface BuzzDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    IBOutlet UILabel *lblTopLeft;
    IBOutlet UILabel *lblTopRight;
    IBOutlet DownloadableImageView *imgDownloadable;
    CGFloat height;
    IBOutlet UITableView *tblDisplay;
}

@end

@implementation BuzzDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lblTopLeft.text=[NSString stringWithFormat:@"%@\n%@",self.buzzSelected.strTitle,self.buzzSelected.strDescription];
    lblTopRight.text=self.buzzSelected.strDate;
    if (self.buzzSelected.strImage.length>0) {
        [imgDownloadable downloadImageFromURL:[NSURL URLWithString:self.buzzSelected.strImage] WithDictionary:nil];
    }
    height=0.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strTemp=@"myCell";
    BuzzDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strTemp];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BuzzDetailTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.myWebView.delegate=self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cell.myWebView loadHTMLString:self.buzzSelected.strDescription baseURL:nil];
    });
    cell.contentView.backgroundColor=cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (height==0.0f) {
        height=webView.scrollView.contentSize.height;
        [tblDisplay reloadData];
    }
}



@end

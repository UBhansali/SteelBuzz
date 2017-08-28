//
//  CategoryViewController.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 04/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryWebService.h"
#import "CustomVerticalScroller.h"
#import "NSMutableArray+MemberOfTypeCategory.h"
#import "CategoryMemberViewController.h"

@interface CategoryViewController ()<CustomVerticalScrollerDelegate>
{
    @private
    IBOutlet UIView *vwDisplay;
    NSMutableArray *arrDisplay;
    CustomVerticalScroller *scroller;
    NSMutableArray *arrSelectedMember;
}

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    arrDisplay=[NSMutableArray array];
    [[CategoryWebService service] callCategoryServiceWithCompletionHandler:^(id result, BOOL isError, NSString *strMsg) {
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
            if ([result isKindOfClass:[NSMutableArray class]]) {
                arrDisplay=(NSMutableArray*)result;
                if (!scroller) {
                    scroller=[[CustomVerticalScroller alloc] initWithFrame:[vwDisplay bounds]];
                }
                NSLog(@"%@",NSStringFromCGRect(scroller.frame));
                scroller.delegate=self;
                [scroller reloadData];
                [vwDisplay addSubview:scroller];
                NSLog(@"%@",NSStringFromCGRect(vwDisplay.frame));
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*)dataSourceForVerticalScroller:(CustomVerticalScroller *)scroller
{
    return arrDisplay;
}

-(void)didSelectedCategory:(ModelCategory *)objSelctedCategory
{
    AppDelegate *appDell=appDel;
    arrSelectedMember=[appDell.arrAllMemberForAllCategory getMemberForCategory:objSelctedCategory];
    [self performSegueWithIdentifier:@"CategoryMemberViewController" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CategoryMemberViewController"]) {
        CategoryMemberViewController *master=[segue destinationViewController];
        master.arrSelectedMember=arrSelectedMember;
    }
}
@end

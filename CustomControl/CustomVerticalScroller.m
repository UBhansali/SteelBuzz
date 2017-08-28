//
//  CustomVerticalScroller.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 10/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "CustomVerticalScroller.h"
#import "ModelCategory.h"
#import "CategoryCell.h"
//#import "CategoryHeaderTableViewCell.h"

@implementation CustomVerticalScroller

-(id)init
{
    if (self=[super init]) {
        [self initializer];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self initializer];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.myFrame=frame;
        [self initializer];
    }
    return self;
}

-(void)initializer
{
    startPoint=0;
    arrSelectionContainer=[NSMutableArray array];
    NSLog(@"%@",NSStringFromCGRect(self.myFrame));
    scrollViewContainer=[[UIScrollView alloc] initWithFrame:self.myFrame];
    scrollViewContainer.delegate=self;
    [scrollViewContainer setBackgroundColor:[UIColor clearColor]];
    NSLog(@"%@",NSStringFromCGRect(scrollViewContainer.frame));
    [self addSubview:scrollViewContainer];
    
}

-(void)displayDataOnScrollView:(NSMutableArray*)arr DisplayLevel:(NSInteger)level LeadSpace:(CGFloat)leadSpace
{
    for (int i=0; i<arr.count; i++) {
        ModelCategory *obj=[arr objectAtIndex:i];
        CategoryCell *cell=[[CategoryCell alloc] init];
        cell=[[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil] objectAtIndex:0];
        cell.delegate=self;
        cell.objCategory=obj;
        if (level==0) {
            cell.frame=CGRectMake(0, startPoint, self.myFrame.size.width, 100);
            startPoint+=100;
            [scrollViewContainer setContentSize:CGSizeMake(scrollViewContainer.frame.size.width, startPoint)];
            if ([cell.objCategory.strName isEqualToString:@"Nickel Alloys"]) {
                cell.imgBG.image=[UIImage imageNamed:@"Nickel-Alloys.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            if ([cell.objCategory.strName isEqualToString:@"Stainless Steel Pipes"]) {
                cell.imgBG.image=[UIImage imageNamed:@"SS-Pipes.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            if ([cell.objCategory.strName isEqualToString:@"Stainless Steel Sheets & Plates"]) {
                cell.imgBG.image=[UIImage imageNamed:@"SS-Sheets-&-Plates.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            if ([cell.objCategory.strName isEqualToString:@"Stainless Steel Round Bar"]) {
                cell.imgBG.image=[UIImage imageNamed:@"SS-Bars.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            if ([cell.objCategory.strName isEqualToString:@"Fitings"]) {
                cell.imgBG.image=[UIImage imageNamed:@"Fittings.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            if ([cell.objCategory.strName isEqualToString:@"Flanges"]) {
                cell.imgBG.image=[UIImage imageNamed:@"Flanges.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            if ([cell.objCategory.strName isEqualToString:@"Stainless Steel Scrap"]) {
                cell.imgBG.image=[UIImage imageNamed:@"SS-Scrap.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            if ([cell.objCategory.strName isEqualToString:@"Copper and Brass"]) {
                cell.imgBG.image=[UIImage imageNamed:@"Copper-&-Brass.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            if ([cell.objCategory.strName isEqualToString:@"Aluminium"]) {
                cell.imgBG.image=[UIImage imageNamed:@"SS-Bars-1.png"];
                cell.lblContent.backgroundColor=[UIColor clearColor];
            }
            cell.consWidth.constant=0.0f;
            cell.imgArrow.hidden=YES;
        }else{
            if (obj.arrCategory.count>0) {
                cell.imgArrow.hidden=NO;
            }else{
                cell.imgArrow.hidden=YES;
                cell.imgGol.hidden=YES;
                cell.lblContent.backgroundColor=[UIColor colorWithRed:119.0f/255.0f green:181.0f/255.0f blue:211.0f/255.0f alpha:1.0f];
            }
            
            cell.frame=CGRectMake(0, startPoint, self.myFrame.size.width, 70);
            startPoint+=70;
            [scrollViewContainer setContentSize:CGSizeMake(scrollViewContainer.frame.size.width, startPoint)];
        }
        if (level==0) {
            cell.lblContent.text=obj.strName;
        }else{
            cell.lblContent.text=[NSString stringWithFormat:@"  %@",obj.strName];
        }
        cell.consLaedSpace.constant=leadSpace;
        [scrollViewContainer addSubview:cell];
        if ([arrSelectionContainer containsObject:obj.strID]) {
            cell.imgArrow.image=[UIImage imageNamed:@"upore.png"];
            [self displayDataOnScrollView:obj.arrCategory DisplayLevel:level+1 LeadSpace:cell.consLaedSpace.constant-10.0f];
        }else{
            cell.imgArrow.image=[UIImage imageNamed:@"niche.png"];
        }
        
        
    }
    [scrollViewContainer setContentOffset:scrollingOffset];
    return;
}

-(void)btnClickedWithCategory:(ModelCategory *)clickedCategory
{
    if (clickedCategory.arrCategory.count>0) {
        if ([arrSelectionContainer containsObject: clickedCategory.strID]) {
            NSUInteger indexOfTheObject = [arrSelectionContainer indexOfObject: clickedCategory.strID];
            [arrSelectionContainer removeObjectAtIndex:indexOfTheObject];
        }else{
            [arrSelectionContainer addObject:clickedCategory.strID];
        }
        [self reloadData];
    }else{
        //Segue To Next Page...
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCategory:)]) {
            [self.delegate didSelectedCategory:clickedCategory];
        }
    }
}

-(void)reloadData
{
    startPoint=0;
    if (scrollViewContainer.subviews.count>0) {
        for (UIView *vw in scrollViewContainer.subviews) {
            [vw removeFromSuperview];
        }
    }
    arrDataSource=[self.delegate dataSourceForVerticalScroller:self];
    
    if (arrDataSource.count==0) {
        return;
    }
    [scrollViewContainer setContentSize:CGSizeMake(scrollViewContainer.frame.size.width, 0)];
    [self displayDataOnScrollView:arrDataSource DisplayLevel:0 LeadSpace:-10.0f];
    
}

-(void)didMoveToSuperview
{
    scrollingOffset=CGPointZero;
    [self reloadData];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollingOffset=scrollView.contentOffset;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    scrollingOffset=scrollView.contentOffset;
//}

//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    scrollingOffset=scrollView.contentOffset;
//}

@end

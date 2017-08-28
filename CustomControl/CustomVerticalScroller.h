//
//  CustomVerticalScroller.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 10/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCell.h"

@protocol CustomVerticalScrollerDelegate;

@interface CustomVerticalScroller : UIView<CategoryCellDelegate,UIScrollViewDelegate>
{
    @private
    UIScrollView *scrollViewContainer;
    NSMutableArray *arrDataSource;
    NSMutableArray *arrSelectionContainer;
    CGFloat startPoint;
    CGPoint scrollingOffset;
}

@property(assign,nonatomic) CGRect myFrame;
@property(weak,nonatomic) id <CustomVerticalScrollerDelegate> delegate;

-(void)reloadData;

@end

@protocol CustomVerticalScrollerDelegate <NSObject>

@required

-(NSMutableArray*)dataSourceForVerticalScroller:(CustomVerticalScroller*)scroller;

@optional

-(void)didSelectedCategory:(ModelCategory*)objSelctedCategory;

@end

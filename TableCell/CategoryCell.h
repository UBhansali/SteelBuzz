//
//  CategoryCell.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 10/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelCategory.h"

@protocol CategoryCellDelegate <NSObject>

@required

-(void)btnClickedWithCategory:(ModelCategory*)clickedCategory;

@end

@interface CategoryCell : UIView

@property(strong,nonatomic) IBOutlet UILabel *lblContent;
@property(strong,nonatomic) IBOutlet UIImageView *imgBG;
@property(strong,nonatomic) IBOutlet UIImageView *imgArrow;
@property(strong,nonatomic) IBOutlet UIImageView *imgGol;
@property(strong,nonatomic) IBOutlet UIButton *btnTap;
@property(strong,nonatomic) ModelCategory *objCategory;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *consLaedSpace;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *consWidth;
@property(strong,nonatomic) IBOutlet NSLayoutConstraint *consBottomSpace;

@property(weak,nonatomic) id <CategoryCellDelegate> delegate;


@end

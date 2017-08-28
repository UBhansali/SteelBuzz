//
//  MemberMainTableViewCell.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 25/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberMainTableViewCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIImageView *imgBG;
@property(strong,nonatomic) IBOutlet UILabel *lblContent;
@property(strong,nonatomic) IBOutlet UILabel *lblFeatured;
@property(strong,nonatomic) IBOutlet UIImageView *imgFeatured;
@property(strong,nonatomic) IBOutlet UIView *vwBorder;

@end

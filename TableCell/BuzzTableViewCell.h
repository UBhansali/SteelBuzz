//
//  BuzzTableViewCell.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzzTableViewCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UILabel *lblTop;
@property(strong,nonatomic) IBOutlet UILabel *lblBottom;
@property(strong,nonatomic) IBOutlet UIImageView *imgBG;

@end

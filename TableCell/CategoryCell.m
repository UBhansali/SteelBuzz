//
//  CategoryCell.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 10/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

-(IBAction)btnTapPressed:(id)sender
{
    [self.delegate btnClickedWithCategory:self.objCategory];
}


@end

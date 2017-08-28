//
//  PhonePadButton.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 28/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "PhonePadButton.h"

@implementation PhonePadButton

-(id)init
{
    if (self=[super init]) {
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
//    self.layer.cornerRadius=self.frame.size.height/2;
//    self.backgroundColor=[UIColor colorWithRed:207.0f/255.0f green:238.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//    self.layer.borderWidth=2.0f;
//    self.layer.borderColor=[UIColor colorWithRed:162.0f/255.0f green:209.0f/255.0f blue:232.0f/255.0f alpha:1.0f].CGColor;
    
}

@end

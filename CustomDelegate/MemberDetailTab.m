//
//  MemberDetailTab.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "MemberDetailTab.h"

@interface MemberDetailTab ()

@property(strong,nonatomic) IBOutlet UIButton *btn1;
@property(strong,nonatomic) IBOutlet UIButton *btn2;
@property(strong,nonatomic) IBOutlet UIButton *btn3;
@property(strong,nonatomic) IBOutlet UIButton *btn4;
@property(strong,nonatomic) IBOutlet UIImageView *imgHeighlight1;
@property(strong,nonatomic) IBOutlet UIImageView *imgHeighlight2;
@property(strong,nonatomic) IBOutlet UIImageView *imgHeighlight3;
@property(strong,nonatomic) IBOutlet UIImageView *imgHeighlight4;
@property(strong,nonatomic) IBOutlet UIView *vwTemp;

@property(assign,nonatomic) NSInteger lastSelectedSender;

@end

@implementation MemberDetailTab


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
    _vwTemp=[[[NSBundle mainBundle] loadNibNamed:@"MemberDetailTab" owner:self options:nil] lastObject];
    
    _vwTemp.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_vwTemp];

    self.imgHeighlight1=(UIImageView*)[self.vwTemp viewWithTag:1];
    self.imgHeighlight2=(UIImageView*)[self.vwTemp viewWithTag:2];
    self.imgHeighlight3=(UIImageView*)[self.vwTemp viewWithTag:3];
    self.imgHeighlight4=(UIImageView*)[self.vwTemp viewWithTag:4];
    
    self.btn1=(UIButton*)[self.vwTemp viewWithTag:1000];
    [self.btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.btn2=(UIButton*)[self.vwTemp viewWithTag:2000];
    [self.btn2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.btn3=(UIButton*)[self.vwTemp viewWithTag:3000];
    [self.btn3 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.btn4=(UIButton*)[self.vwTemp viewWithTag:4000];
    [self.btn4 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)updateUI
{
    for (int i=1; i<=4; i++) {
        if (i==_lastSelectedSender/1000) {
            UIImageView *imgTemp=(UIImageView*)[self.vwTemp viewWithTag:i];
            imgTemp.backgroundColor=[UIColor whiteColor];
            
        }else{
            UIImageView *imgTemp=(UIImageView*)[self.vwTemp viewWithTag:i];
            imgTemp.backgroundColor=[UIColor colorWithRed:171.0f/255.0f green:171.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
        }
    }
}

-(void)btnClicked:(id)sender
{
    if (_lastSelectedSender!=(NSInteger)[sender tag]) {
        _lastSelectedSender=(NSInteger)[sender tag];
        [self updateUI];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedTabIndex:)]) {
            [self.delegate didSelectedTabIndex:_lastSelectedSender/1000];
        }
    }
}

-(void)didMoveToSuperview
{
    [self.btn1 sendActionsForControlEvents:
     UIControlEventTouchUpInside];}

@end

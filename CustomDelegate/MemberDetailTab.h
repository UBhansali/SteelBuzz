//
//  MemberDetailTab.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MemberDetailTabDelegate <NSObject>

@optional
-(void)didSelectedTabIndex:(NSInteger)tabIndex;

@end

@interface MemberDetailTab : UIView

@property(weak,nonatomic) id <MemberDetailTabDelegate> delegate;

@end

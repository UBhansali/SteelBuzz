//
//  ModelCategory.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 04/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelCategory : NSObject<NSCopying>

@property(strong,nonatomic) NSString *strID;
@property(strong,nonatomic) NSString *strName;
@property(assign,nonatomic) BOOL isSelected;
@property(strong,nonatomic) NSMutableArray *arrCategory;

+(NSMutableArray*)getCategoryObjectArray:(NSArray*)arr;

@end

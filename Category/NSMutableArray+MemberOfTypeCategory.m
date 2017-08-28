//
//  NSMutableArray+MemberOfTypeCategory.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "NSMutableArray+MemberOfTypeCategory.h"
#import "ModelMember.h"

@implementation NSMutableArray (MemberOfTypeCategory)

-(NSMutableArray*)getMemberForCategory:(ModelCategory*)objCategory
{
    NSMutableArray *arrTemp=[NSMutableArray array];
    for (ModelMember *objMember in self) {
        if ([objMember.strCategoryID isEqualToString:objCategory.strID]) {
            [arrTemp addObject:objMember];
        }
    }
    return arrTemp;
}

@end

//
//  NSMutableArray+MemberOfTypeCategory.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelCategory.h"

@interface NSMutableArray (MemberOfTypeCategory)

-(NSMutableArray*)getMemberForCategory:(ModelCategory*)objCategory;

@end

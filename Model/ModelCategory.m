//
//  ModelCategory.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 04/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ModelCategory.h"

@implementation ModelCategory

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self=[super init]) {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
            self.strID=[dict objectForKey:@"id"];
        }else{
            self.strID=@"";
        }
        if ([dict objectForKey:@"name"] && ![[dict objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
            self.strName=[dict objectForKey:@"name"];
        }else{
            self.strName=@"";
        }
        if ([dict objectForKey:@"root"] && ![[dict objectForKey:@"root"] isKindOfClass:[NSNull class]]) {
            self.arrCategory=[ModelCategory getCategoryObjectArray:(NSArray*)[dict objectForKey:@"root"]];
        }else{
            self.arrCategory=[NSMutableArray array];
        }
        
        self.isSelected=NO;
    }
    return self;
}

+(NSMutableArray*)getCategoryObjectArray:(NSArray*)arr
{
    NSMutableArray *arrTemp=[NSMutableArray array];
    for (int i=0; i<arr.count; i++) {
        ModelCategory *obj=[[ModelCategory alloc] initWithDictionary:[arr objectAtIndex:i]];
        [arrTemp addObject:obj];
    }
    return arrTemp;
}

@end

//
//  ModelUser.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ModelUser.h"

@implementation ModelUser

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self=[super init]) {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
            self.strID=[dict objectForKey:@"id"];
        }else{
            self.strID=@"";
        }

        if ([dict objectForKey:@"firstname"] && ![[dict objectForKey:@"firstname"] isKindOfClass:[NSNull class]]) {
            self.strFirstName=[dict objectForKey:@"firstname"];
        }else{
            self.strFirstName=@"";
        }
        
        if ([dict objectForKey:@"lastname"] && ![[dict objectForKey:@"lastname"] isKindOfClass:[NSNull class]]) {
            self.strLastName=[dict objectForKey:@"lastname"];
        }else{
            self.strLastName=@"";
        }
        
        if ([dict objectForKey:@"email"] && ![[dict objectForKey:@"email"] isKindOfClass:[NSNull class]]) {
            self.strEmail=[dict objectForKey:@"email"];
        }else{
            self.strEmail=@"";
        }
    }
    return self;
}

@end

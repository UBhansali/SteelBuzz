//
//  ModelBuzz.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ModelBuzz.h"

#define imageURLPrefix @"http://www.steelbuzz.com/sb/buzz_image/"

@implementation ModelBuzz

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self=[super init]) {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
            self.strID=[dict objectForKey:@"id"];
        }else{
            self.strID=@"";
        }
        
        if ([dict objectForKey:@"buzz_title"] && ![[dict objectForKey:@"buzz_title"] isKindOfClass:[NSNull class]]) {
            self.strTitle=[dict objectForKey:@"buzz_title"];
        }else{
            self.strTitle=@"";
        }
        
        if ([dict objectForKey:@"buzz_date"] && ![[dict objectForKey:@"buzz_date"] isKindOfClass:[NSNull class]]) {
            self.strDate=[dict objectForKey:@"buzz_date"];
        }else{
            self.strDate=@"";
        }
        
        if ([dict objectForKey:@"buzz_image"] && ![[dict objectForKey:@"buzz_image"] isKindOfClass:[NSNull class]]) {
            self.strImage=[NSString stringWithFormat:@"%@%@",imageURLPrefix,[dict objectForKey:@"buzz_image"]];
        }else{
            self.strImage=@"";
        }
        
        if ([dict objectForKey:@"buzz_description"] && ![[dict objectForKey:@"buzz_description"] isKindOfClass:[NSNull class]]) {
            self.strDescription=[dict objectForKey:@"buzz_description"];
        }else{
            self.strDescription=@"";
        }
    }
    return self;
}

@end

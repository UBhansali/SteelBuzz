//
//  ModelMember.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ModelMember.h"

@implementation ModelMember

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self=[super init]) {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]]) {
            self.strID=[dict objectForKey:@"id"];
        }else{
            self.strID=@"";
        }
        
        if ([dict objectForKey:@"product_type"] && ![[dict objectForKey:@"product_type"] isKindOfClass:[NSNull class]]) {
            self.strProductType=[dict objectForKey:@"product_type"];
        }else{
            self.strProductType=@"";
        }
        
        if ([dict objectForKey:@"members_name"] && ![[dict objectForKey:@"members_name"] isKindOfClass:[NSNull class]]) {
            self.strMembersName=[dict objectForKey:@"members_name"];
        }else{
            self.strMembersName=@"";
        }
        
        if ([dict objectForKey:@"address"] && ![[dict objectForKey:@"address"] isKindOfClass:[NSNull class]]) {
            self.strAddress=[dict objectForKey:@"address"];
        }else{
            self.strAddress=@"";
        }
        
        if ([dict objectForKey:@"city"] && ![[dict objectForKey:@"city"] isKindOfClass:[NSNull class]]) {
            self.strCity=[dict objectForKey:@"city"];
        }else{
            self.strCity=@"";
        }
        
        if ([dict objectForKey:@"country"] && ![[dict objectForKey:@"country"] isKindOfClass:[NSNull class]]) {
            self.strCountry=[dict objectForKey:@"country"];
        }else{
            self.strCountry=@"";
        }
        
        if ([dict objectForKey:@"contact_person"] && ![[dict objectForKey:@"contact_person"] isKindOfClass:[NSNull class]]) {
            self.strContactPerson=[dict objectForKey:@"contact_person"];
        }else{
            self.strContactPerson=@"";
        }
        
        if ([dict objectForKey:@"hughes_no"] && ![[dict objectForKey:@"hughes_no"] isKindOfClass:[NSNull class]]) {
            self.strHughes=[dict objectForKey:@"hughes_no"];
        }else{
            self.strHughes=@"";
        }
        
        if ([dict objectForKey:@"phone_no"] && ![[dict objectForKey:@"phone_no"] isKindOfClass:[NSNull class]]) {
            self.strPhoneNo=[dict objectForKey:@"phone_no"];
        }else{
            self.strPhoneNo=@"";
        }
        
        if ([dict objectForKey:@"mobile_no"] && ![[dict objectForKey:@"mobile_no"] isKindOfClass:[NSNull class]]) {
            self.strMobileNo=[dict objectForKey:@"mobile_no"];
        }else{
            self.strMobileNo=@"";
        }
        
        if ([dict objectForKey:@"fax"] && ![[dict objectForKey:@"fax"] isKindOfClass:[NSNull class]]) {
            self.strFax=[dict objectForKey:@"fax"];
        }else{
            self.strFax=@"";
        }
        
        if ([dict objectForKey:@"residence"] && ![[dict objectForKey:@"residence"] isKindOfClass:[NSNull class]]) {
            self.strResidance=[dict objectForKey:@"residence"];
        }else{
            self.strResidance=@"";
        }
        
        if ([dict objectForKey:@"email"] && ![[dict objectForKey:@"email"] isKindOfClass:[NSNull class]]) {
            self.strEmail=[dict objectForKey:@"email"];
        }else{
            self.strEmail=@"";
        }
        
        if ([dict objectForKey:@"web"] && ![[dict objectForKey:@"web"] isKindOfClass:[NSNull class]]) {
            self.strWeb=[dict objectForKey:@"web"];
        }else{
            self.strWeb=@"";
        }
        
        if ([dict objectForKey:@"status"] && ![[dict objectForKey:@"status"] isKindOfClass:[NSNull class]]) {
            self.strStatus=[dict objectForKey:@"status"];
        }else{
            self.strStatus=@"";
        }
        
        if ([dict objectForKey:@"rank"] && ![[dict objectForKey:@"rank"] isKindOfClass:[NSNull class]]) {
            self.strRank=[dict objectForKey:@"rank"];
        }else{
            self.strRank=@"";
        }
        
        if ([dict objectForKey:@"category_id"] && ![[dict objectForKey:@"category_id"] isKindOfClass:[NSNull class]]) {
            self.strCategoryID=[dict objectForKey:@"category_id"];
        }else{
            self.strCategoryID=@"";
        }
    }
    return self;
}

-(id)initWithCopy:(ModelMember*)obj
{
    if (self=[super init]) {
        self.strAddress=[[NSString alloc] initWithString:obj.strAddress];
        self.strCity=[[NSString alloc] initWithString:obj.strCity];
        self.strContactPerson=[[NSString alloc] initWithString:obj.strContactPerson];
        self.strCountry=[[NSString alloc] initWithString:obj.strCountry];
        self.strEmail=[[NSString alloc] initWithString:obj.strEmail];
        self.strFax=[[NSString alloc] initWithString:obj.strFax];
        self.strHughes=[[NSString alloc] initWithString:obj.strHughes];
        self.strID=[[NSString alloc] initWithString:obj.strID];
        self.strMembersName=[[NSString alloc] initWithString:obj.strMembersName];
        self.strMobileNo=[[NSString alloc] initWithString:obj.strMobileNo];
        self.strPhoneNo=[[NSString alloc] initWithString:obj.strPhoneNo];
        self.strProductType=[[NSString alloc] initWithString:obj.strProductType];
        self.strRank=[[NSString alloc] initWithString:obj.strRank];
        self.strResidance=[[NSString alloc] initWithString:obj.strResidance];
        self.strStatus=[[NSString alloc] initWithString:obj.strStatus];
        self.strWeb=[[NSString alloc] initWithString:obj.strWeb];
        self.strCategoryID=[[NSString alloc] initWithString:obj.strCategoryID];
    }
    return self;
}

@end

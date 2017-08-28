//
//  ModelMember.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelMember : ModelBaseClass

@property(strong,nonatomic) NSString *strID;
@property(strong,nonatomic) NSString *strProductType;
@property(strong,nonatomic) NSString *strMembersName;
@property(strong,nonatomic) NSString *strAddress;
@property(strong,nonatomic) NSString *strCity;
@property(strong,nonatomic) NSString *strCountry;
@property(strong,nonatomic) NSString *strContactPerson;
@property(strong,nonatomic) NSString *strHughes;
@property(strong,nonatomic) NSString *strPhoneNo;
@property(strong,nonatomic) NSString *strMobileNo;
@property(strong,nonatomic) NSString *strFax;
@property(strong,nonatomic) NSString *strResidance;
@property(strong,nonatomic) NSString *strEmail;
@property(strong,nonatomic) NSString *strWeb;
@property(strong,nonatomic) NSString *strStatus;
@property(strong,nonatomic) NSString *strRank;
@property(strong,nonatomic) NSString *strCategoryID;

-(id)initWithDictionary:(NSDictionary*)dict;
-(id)initWithCopy:(ModelMember*)obj;

@end

//
//  ModelUser.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelUser : ModelBaseClass

@property(strong,nonatomic) NSString *strID;
@property(strong,nonatomic) NSString *strFirstName;
@property(strong,nonatomic) NSString *strLastName;
@property(strong,nonatomic) NSString *strEmail;

-(id)initWithDictionary:(NSDictionary*)dict;

@end

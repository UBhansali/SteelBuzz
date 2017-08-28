//
//  ModelBuzz.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "ModelBaseClass.h"

@interface ModelBuzz : ModelBaseClass

@property(strong,nonatomic) NSString *strID;
@property(strong,nonatomic) NSString *strTitle;
@property(strong,nonatomic) NSString *strDate;
@property(strong,nonatomic) NSString *strImage;
@property(strong,nonatomic) NSString *strDescription;

-(id)initWithDictionary:(NSDictionary*)dict;

@end

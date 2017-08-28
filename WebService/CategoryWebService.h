//
//  CategoryWebService.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 04/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface CategoryWebService : WebServiceBaseClass

+(CategoryWebService*)service;

-(void)callCategoryServiceWithCompletionHandler:(WebServiceCompletionHandler)handler;

@end

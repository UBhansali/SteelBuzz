//
//  MemberForCategoryWebService.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface MemberForCategoryWebService : WebServiceBaseClass

+(MemberForCategoryWebService*)service;

-(void)callMemberForCategoryWebServiceWithCompletionHandler:(WebServiceCompletionHandler)handler;


@end
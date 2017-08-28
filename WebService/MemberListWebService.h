//
//  MemberListWebService.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface MemberListWebService : WebServiceBaseClass

+(MemberListWebService*)service;

-(void)callAllMemberListServiceWithCompletionHandler:(WebServiceCompletionHandler)handler;

@end

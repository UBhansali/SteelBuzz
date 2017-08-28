//
//  LoginService.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface LoginWebService : WebServiceBaseClass

+(LoginWebService*)service;

-(void)callLoginServiceForUserName:(NSString*)strUserName Password:(NSString*)strPassword WithCompletionHandler:(WebServiceCompletionHandler)handler;

@end

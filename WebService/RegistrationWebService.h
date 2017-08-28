//
//  RegistrationWebService.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface RegistrationWebService : WebServiceBaseClass

+(RegistrationWebService*)service;

-(void)callRegistrationServiceForFirstName:(NSString*)strFirstName LastName:(NSString*)strLastName Email:(NSString*)strEmail Password:(NSString*)strPassword UserName:(NSString*)strUserName WithCompletionHandler:(WebServiceCompletionHandler)handler;


@end

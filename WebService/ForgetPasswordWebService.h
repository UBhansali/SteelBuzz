//
//  ForgetPasswordWebService.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface ForgetPasswordWebService : WebServiceBaseClass

+(ForgetPasswordWebService*)service;

-(void)callForgetPasswordWebServiceForEmailID:(NSString*)strEmailID WithCompletionHandler:(WebServiceCompletionHandler)handler;

@end

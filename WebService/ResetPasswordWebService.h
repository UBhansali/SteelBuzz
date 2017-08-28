//
//  ResetPasswordWebService.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface ResetPasswordWebService : WebServiceBaseClass

+(ResetPasswordWebService*)service;

-(void)callForgetPasswordWebServiceForEmailID:(NSString*)strEmailID Password:(NSString*)strPassword WithCompletionHandler:(WebServiceCompletionHandler)handler;

@end

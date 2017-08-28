//
//  BuzzListWebService.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"

@interface BuzzListWebService : WebServiceBaseClass

+(BuzzListWebService*)service;

-(void)callBuzzListServiceWithCompletionHandler:(WebServiceCompletionHandler)handler;


@end

//
//  WebServiceBaseClass.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WebServiceCompletionHandler)(id result,BOOL isError,NSString *strMsg);

typedef NS_ENUM(NSUInteger, WebServices) {
    Login=0,
    Registration,
    AllMemberList,
    CategoryList,
    CategoryMemberList,
    CategoryMamberDetailList,
    BuzzList,
    ForgetPassword,
    ResetPassword,
};

@interface WebServiceBaseClass : NSObject
{
    @protected
    NSURL *urlWebService;
}

-(id)initWithService:(WebServices)serviceType;

@end

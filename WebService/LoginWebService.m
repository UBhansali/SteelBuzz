//
//  LoginService.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "LoginWebService.h"
#import "ModelUser.h"

@implementation LoginWebService

-(id)initWithService:(WebServices)serviceType
{
    if (self=[super initWithService:serviceType]) {
        
    }
    return self;
}

+(LoginWebService*)service
{
    static LoginWebService *loginService=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginService=[[LoginWebService alloc] initWithService:Login];
    });
    return loginService;
}

-(void)callLoginServiceForUserName:(NSString*)strUserName Password:(NSString*)strPassword WithCompletionHandler:(WebServiceCompletionHandler)handler
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:strUserName forKey:@"email"];
    [dict setObject:strPassword forKey:@"pass"];
    
    NSLog(@"post param=%@",dict);
    
    NSError *errorConversion;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&errorConversion];
    if (errorConversion) {
        handler(errorConversion,YES,@"Something is wrong, please try again later...");
    }else{
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        [request setURL:urlWebService];
        NSLog(@"urlService=%@",urlWebService.absoluteString);
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setTimeoutInterval:60.0];
        [request setHTTPBody:postData];
        
        NSURLResponse *response;
        NSError *connectionError;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        if (connectionError) {
            handler(connectionError,YES,@"Please check your network connectivity...");
        }else{
            NSLog(@"response = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSError *jsonError;
            dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            if (jsonError) {
                handler(jsonError,YES,@"Something is wrong, please try again later...");
            }else{
                if ([[dict objectForKey:@"status"] boolValue]) {
                    ModelUser *obj=[[ModelUser alloc] initWithDictionary:[dict objectForKey:@"user"]];
                    handler(obj,NO,@"You have successfully logged in.");
                }else{
                    handler(nil,YES,@"Something is wrong, please try again later...");
                }
                
            }
        }
    }
}

@end

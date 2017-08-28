//
//  RegistrationWebService.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "RegistrationWebService.h"

@implementation RegistrationWebService

-(id)initWithService:(WebServices)serviceType
{
    if (self=[super initWithService:serviceType]) {
        
    }
    return self;
}

+(RegistrationWebService*)service
{
    static RegistrationWebService *registrationService=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        registrationService=[[RegistrationWebService alloc] initWithService:Registration];
    });
    return registrationService;
}

-(void)callRegistrationServiceForFirstName:(NSString*)strFirstName LastName:(NSString*)strLastName Email:(NSString*)strEmail Password:(NSString*)strPassword UserName:(NSString*)strUserName WithCompletionHandler:(WebServiceCompletionHandler)handler
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:strFirstName forKey:@"firstname"];
    [dict setObject:strLastName forKey:@"lastname"];
    [dict setObject:strEmail forKey:@"email"];
    [dict setObject:strPassword forKey:@"pass"];
    if (strUserName) {
        [dict setObject:strUserName forKey:@"username"];
    }
    
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
                    if (strUserName) {
                        handler(nil,NO,@"Social login is successful");
                    }else{
                        handler(nil,NO,@"Registration is successful");
                    }
                }else{
                    if (strUserName) {
                        handler(nil,NO,@"Social login is unsuccessful");
                    }else{
                        handler(nil,NO,@"Registration is not successful, please try again later...");
                    }
                }
            }
        }
    }
}

@end

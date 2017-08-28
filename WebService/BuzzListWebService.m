//
//  BuzzListWebService.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 11/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "BuzzListWebService.h"
#import "ModelBuzz.h"

@implementation BuzzListWebService

-(id)initWithService:(WebServices)serviceType
{
    if (self=[super initWithService:serviceType]) {
        
    }
    return self;
}

+(BuzzListWebService*)service
{
    static BuzzListWebService *buzzListService=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        buzzListService=[[BuzzListWebService alloc] initWithService:BuzzList];
    });
    return buzzListService;
}

-(void)callBuzzListServiceWithCompletionHandler:(WebServiceCompletionHandler)handler
{
    __block NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
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
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (connectionError) {
                    handler(connectionError,YES,@"Please check your network connectivity...");
                }else{
                    NSLog(@"response = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    NSError *jsonError;
                    dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                    if (jsonError) {
                        handler(jsonError,YES,@"Something is wrong, please try again later...");
                    }else{
                        if ([dict objectForKey:@"status"] && ![[dict objectForKey:@"status"] isKindOfClass:[NSNull class]]) {
                            if ([[dict objectForKey:@"status"] boolValue]) {
                                NSMutableArray *arrTemp=[[dict objectForKey:@"buzzsettings"] mutableCopy];
                                for (int i=0; i<arrTemp.count; i++) {
                                    ModelBuzz *obj=[[ModelBuzz alloc] initWithDictionary:[arrTemp objectAtIndex:i]];
                                    [arrTemp removeObjectAtIndex:i];
                                    [arrTemp insertObject:obj atIndex:i];
                                }
                                handler(arrTemp,NO,@"Retrived.");
                            }else{
                                handler(nil,YES,@"Something is wrong, please try again later.");
                            }
                        }else{
                            handler(nil,YES,@"Something is wrong, please try again later.");
                        }
                    }
                }
            });
        }];
    }
}


@end

//
//  MemberForCategoryWebService.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 09/08/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "MemberForCategoryWebService.h"
#import "ModelMember.h"

@implementation MemberForCategoryWebService

-(id)initWithService:(WebServices)serviceType
{
    if (self=[super initWithService:serviceType]) {
        
    }
    return self;
}

+(MemberForCategoryWebService*)service
{
    static MemberForCategoryWebService *memberForCategoryService=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        memberForCategoryService=[[MemberForCategoryWebService alloc] initWithService:CategoryMamberDetailList];
    });
    return memberForCategoryService;
}

-(void)callMemberForCategoryWebServiceWithCompletionHandler:(WebServiceCompletionHandler)handler
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
                        if ([[dict objectForKey:@"status"] boolValue]) {
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                                NSMutableArray *arrResponse=[[dict objectForKey:@"details"] mutableCopy];
                                for (int i=0; i<arrResponse.count; i++) {
                                    ModelMember *obj=[[ModelMember alloc] initWithDictionary:[arrResponse objectAtIndex:i]];
                                    if (obj) {
                                        [arrResponse removeObjectAtIndex:i];
                                        [arrResponse insertObject:obj atIndex:i];
                                    }
                                }
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    handler(arrResponse,NO,@"Everything is ok.");
                                });
                            });
                        }else{
                            handler(nil,YES,@"something wrong, please try again later.");
                        }
                        handler(nil,NO,@"Everything is ok");
                    }
                }
            });
        }];
    }
}

@end

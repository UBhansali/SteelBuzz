//
//  MemberListWebService.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "MemberListWebService.h"
#import "ModelMember.h"

@implementation MemberListWebService

-(id)initWithService:(WebServices)serviceType
{
    if (self=[super initWithService:serviceType]) {
        
    }
    return self;
}

+(MemberListWebService*)service
{
    static MemberListWebService *memberListService=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        memberListService=[[MemberListWebService alloc] initWithService:AllMemberList];
    });
    return memberListService;
}

-(void)callAllMemberListServiceWithCompletionHandler:(WebServiceCompletionHandler)handler
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
                        NSMutableArray *arrMembers=[[dict objectForKey:@"members"] mutableCopy];
                        for (int i=0; i<arrMembers.count; i++) {
                            ModelMember *objMember=[[ModelMember alloc] initWithDictionary:[arrMembers objectAtIndex:i]];
                            [arrMembers removeObjectAtIndex:i];
                            [arrMembers insertObject:objMember atIndex:i];
                        }
                        handler(arrMembers,NO,@"Member Retrived Successfully...");
                    }
                }
            });
        }];
    }
}

@end

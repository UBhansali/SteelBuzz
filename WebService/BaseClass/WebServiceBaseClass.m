//
//  WebServiceBaseClass.m
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "WebServiceBaseClass.h"
#import "WebServiceConstant.h"

NSString static *strAllService[]={
    [Login]=@"http://www.steelbuzz.com/sb/app/login.php",
    [Registration]=@"http://steelbuzz.com/sb/app/register.php",
    [BuzzList]=@"http://www.steelbuzz.com/sb/app/buzzsettings.php",
    [CategoryMamberDetailList]=@"isteel/index.php/category/findAllCategories",
    [CategoryMemberList]=@"isteel/index.php/category/categorydetails",
    [CategoryList]=@"isteel/index.php/category/findcategories",
    [AllMemberList]=@"isteel/index.php/category/findMemberList",
    [ForgetPassword]=@"http://steelbuzz.com/sb/app/forgotpassword.php",
    [ResetPassword]=@"http://steelbuzz.com/sb/app/setpassword.php",
};

@implementation WebServiceBaseClass

-(id)initWithService:(WebServices)serviceType
{
    if (self=[super init]) {
        switch (serviceType) {
            case Login:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@",strAllService[Login]]];
                break;
            case Registration:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@",strAllService[Registration]]];
                break;
            case BuzzList:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@",strAllService[BuzzList]]];
                break;
            case CategoryMamberDetailList:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",__KBaseURL,strAllService[CategoryMamberDetailList]]];
                break;
            case CategoryMemberList:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",__KBaseURL,strAllService[CategoryMemberList]]];
                break;
            case CategoryList:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",__KBaseURL,strAllService[CategoryList]]];
                break;
            case AllMemberList:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",__KBaseURL,strAllService[AllMemberList]]];
                break;
            case ForgetPassword:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@",strAllService[ForgetPassword]]];
                break;
            case ResetPassword:
                urlWebService=[NSURL URLWithString:[NSString stringWithFormat:@"%@",strAllService[ResetPassword]]];
                break;
            default:
                break;
        }
    }
    return self;
}

@end

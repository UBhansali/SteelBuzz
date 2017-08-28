//
//  DownloadableImageView.m
//  UtilityApp
//
//  Created by Kaustav Shee on 03/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import "DownloadableImageView.h"

@implementation DownloadableImageView

-(id)init
{
    if (self=[super init]) {
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

-(id)initWithImage:(UIImage *)image
{
    if (self=[super initWithImage:image]) {
        [self initialize];
    }
    return self;
}

-(id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    if (self=[super initWithImage:image highlightedImage:highlightedImage]) {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.frame=CGRectMake(self.frame.size.width/2-activityIndicator.frame.size.width, self.frame.size.height/2-activityIndicator.frame.size.height, activityIndicator.frame.size.width, activityIndicator.frame.size.height);
    [self addSubview:activityIndicator];
    [activityIndicator setHidesWhenStopped:YES];
}

-(void)downloadImageFromURL:(NSURL*)urlImg WithDictionary:(NSMutableDictionary*)dict
{
    if ([dict objectForKey:urlImg.absoluteString]) {
        self.image=[UIImage imageWithData:[dict objectForKey:urlImg.absoluteString]];
    }else{
        [activityIndicator startAnimating];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *dataImg=[NSData dataWithContentsOfURL:urlImg];
            if (dataImg.length>0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (dict) {
                        [dict setObject:dataImg forKey:urlImg.absoluteString];
                    }
                    self.image=[UIImage imageWithData:dataImg];
                    [activityIndicator stopAnimating];
                });
            }
        });
    }
}

@end

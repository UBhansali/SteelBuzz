//
//  DownloadableImageView.h
//  UtilityApp
//
//  Created by Kaustav Shee on 03/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadableImageView : UIImageView
{
    @private
    UIActivityIndicatorView *activityIndicator;
}

-(void)downloadImageFromURL:(NSURL*)urlImg WithDictionary:(NSMutableDictionary*)dict;

@end

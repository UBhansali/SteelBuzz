//
//  AppDelegate.h
//  SteelBuzz
//
//  Created by Kaustav Shee on 08/07/15.
//  Copyright (c) 2015 Kaustav Shee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ModelUser.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(strong,nonatomic) ModelUser *user;

@property(strong,nonatomic) NSMutableArray *arrAllMemberForAllCategory;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end


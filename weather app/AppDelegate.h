//
//  AppDelegate.h
//  weather app
//
//  Created by Student P_05 on 07/03/17.
//  Copyright © 2017 Rupali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


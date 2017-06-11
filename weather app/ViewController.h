//
//  ViewController.h
//  weather app
//
//  Created by Student P_05 on 07/03/17.
//  Copyright © 2017 Rupali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>{
    CLLocationManager *manager;
    NSDictionary *list;
    
    
    NSArray *array;
    
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *tlbvw;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;



@end


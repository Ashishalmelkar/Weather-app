//
//  secondViewController.h
//  weather app
//
//  Created by Ashish on 09/03/17.
//  Copyright © 2017 Rupali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondViewController : UIViewController{
    NSDictionary *dictt;
    NSArray *weather;
}
@property (strong,nonatomic)NSString *str1lat;
@property (strong,nonatomic)NSString *str1long;
@property (strong,nonatomic)NSString *str1key;


@property (strong, nonatomic) IBOutlet UILabel *lblHum;


@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator2;


@end

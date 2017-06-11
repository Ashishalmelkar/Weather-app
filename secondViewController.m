//
//  secondViewController.m
//  weather app
//
//  Created by Ashish on 09/03/17.
//  Copyright © 2017 Rupali. All rights reserved.
//

#import "secondViewController.h"

@interface secondViewController ()

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getWeatherURL:_str1lat anlongwith:_str1long andKey:_str1key];
    // Do any additional setup after loading the view.
    
}
-(void)getWeatherURL: (NSString *)lats anlongwith: (NSString *)longs andKey: (NSString *)keys {
    
    [_activityIndicator2 startAnimating];
    NSString *strurl=[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&APPID=%@",lats,longs,keys];
    
   // NSLog(@"%@ %@ %@ %d",_str1lat,_str1long,_str1key);
    
    
    /*http://api.openweathermap.org/data/2.5/weather?lat=17.32&lon=76.83&APPID=c656219574cc9fd969b51be346b243e9*/
    
    NSURL *url=[NSURL URLWithString:strurl];
    NSLog(@"%@",url);
    NSLog(@"%@",strurl);
    
    
    
    
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *sessiondatatask1=[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse * response, NSError *error){
        
        
        if(error!=nil)
        {
            
            
            UIAlertController *alertcontrol=[UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *alertaction=[UIAlertAction actionWithTitle:@"OKAY" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            [alertcontrol addAction:alertaction];
            
            [self presentViewController:alertcontrol animated:YES completion:nil];
            
        }else {
            dictt=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@" sec vc =%@",dictt);
            _lbl1.text=[NSString stringWithFormat:@"%@",[dictt valueForKey:@"name"]];
            NSDictionary *dictmain=[dictt valueForKey:@"main"];
            _lbl2.text=[NSString stringWithFormat:@"%@",[dictmain valueForKey:@"temp_min"]];
            _lbl3.text=[NSString stringWithFormat:@"%@",[dictmain valueForKey:@"temp_max"]];
            _lblHum.text=[NSString stringWithFormat:@"%@",[dictmain valueForKey:@"humidity"]];

            
            
            }
        [_activityIndicator2 stopAnimating];
        _activityIndicator2.hidden=YES;

        }];
    

    
    [sessiondatatask1 resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  weather app
//
//  Created by Student P_05 on 07/03/17.
//  Copyright © 2017 Rupali. All rights reserved.
//

#import "ViewController.h"
#import "secondtblcell.h"
#import "secondViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSString *strlat,*strlong,*strkey;
    int i;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getcurrentlocation];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)getcurrentlocation{
    manager=[[CLLocationManager alloc]init];
    manager.delegate=self;
    
    [manager requestAlwaysAuthorization];
    [manager requestWhenInUseAuthorization];
    
    
    
    NSLog(@"%f",manager.location.coordinate.latitude);
    NSLog(@"%f",manager.location.coordinate.longitude);
    
    strlat=[NSString stringWithFormat:@"%f",manager.location.coordinate.latitude];
    strlong=[NSString stringWithFormat:@"%f",manager.location.coordinate.longitude];
    strkey=@"c656219574cc9fd969b51be346b243e9";
    
    i=7;
    
     [self getweather:strlat alongwithlongitude:strlong andWithKey:strkey andunit:i];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    secondtblcell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[secondtblcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
  
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    NSString *strDate= [NSString stringWithFormat:@"%@",[dict valueForKey:@"dt"]];
   NSString *str =  [self convertUNIXTIMETODAY:strDate];
   NSArray *weatherarray=[dict valueForKey:@"weather"];
    NSDictionary *dict2=[weatherarray objectAtIndex:0];
    
    cell.lbl1.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"pressure"]];
    
    cell.lbl2.text=[dict2 valueForKey:@"description"];
    cell.lbl3.text=str;
    
    
    return cell;
}


-(void)getweather:(NSString *)latitude alongwithlongitude:(NSString *)longitude andWithKey: (NSString *)key andunit:(NSInteger)day{
    
     [_activityindicator startAnimating];
    
   
    NSString *strurl=[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&APPID=%@&units=metric&cnt=%ld",latitude,longitude,key,(long)day];
    
    //http://api.openweathermap.org/data/2.5/forecast/daily?lat=18.5204&lon=73.8567&APPID=c656219574cc9fd969b51be346b243e9&units=metric&cnt=7
    
    NSLog(@"%@ %@ %@ %d",strlat,strlong,strkey,i);
    
    NSURL *jsonurl=[NSURL URLWithString:strurl];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *sessiondatatask=[session dataTaskWithURL:jsonurl completionHandler:^(NSData *data, NSURLResponse * response, NSError *error){
        

        
        
        if(error!=NULL)
        {
           
            
            UIAlertController *alertcontrol=[UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *alertaction=[UIAlertAction actionWithTitle:@"OKAY" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            [alertcontrol addAction:alertaction];
            
            [self presentViewController:alertcontrol animated:YES completion:nil];
                
        }else {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",dict);
        
            array = [dict valueForKey:@"list"];
            
            if([array count]){
                _tlbvw.delegate=self;
                _tlbvw.dataSource=self;
                [_tlbvw reloadData];
                
            }
            
        }
        [_activityindicator stopAnimating];
        _activityindicator.hidden=YES;
 
    }];
    [sessiondatatask resume];
}
-(NSString *)convertUNIXTIMETODAY:(NSString *)dateString{
    
    NSTimeInterval timeInterval=dateString.doubleValue;
    NSDate *weatherDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    dateString=[dateFormatter stringFromDate:weatherDate];
    
    return dateString;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"firsttoSec"]){
        secondViewController*sec=[segue destinationViewController];
        sec.str1lat=strlat;
        sec.str1long=strlong;
        sec.str1key=strkey;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

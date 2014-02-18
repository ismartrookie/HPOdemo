//
//  Reservation_HospitalList_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-11.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "Reservation_HospitalList_ViewController.h"
#import "AFNetworking.h"
#import "DepartmentListViewController.h"
#import "SVProgressHUD.h"
#import "Hospital.h"

@interface Reservation_HospitalList_ViewController ()
{
    UILabel *tipLabel;
    UITableView *hospitalTableView;
    UISegmentedControl *typeSegmentControl;
    CLLocationManager *locationManager;
    MKCoordinateRegion region;
    
    NSArray *hospitalArray;
}

@end

@implementation Reservation_HospitalList_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.titleLabel setText:@""];
    
    hospitalArray = [NSArray array];
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    } else {
//        NSLog(@"此设备不支持定位服务");
    }
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 78, 150, 15)];
    [tipLabel setText:@"之前约过的医院"];
    [tipLabel setTextColor:[UIColor darkGrayColor]];
    [tipLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self.view addSubview:tipLabel];
    
    hospitalTableView = [[UITableView alloc] initWithFrame:CGRectMake(17, 104, 286, self.view.bounds.size.height - 102)
                                                     style:UITableViewStylePlain];
    [hospitalTableView setDataSource:self];
    [hospitalTableView setDelegate:self];
    [hospitalTableView setRowHeight:88.0f];
    [hospitalTableView setSeparatorColor:HPO_BROWN];
    [hospitalTableView.layer setBorderWidth:1.0f];
    [hospitalTableView.layer setBorderColor:[HPO_BROWN CGColor]];
    [hospitalTableView.layer setCornerRadius:3.0f];
    [hospitalTableView.layer setMasksToBounds:YES];
    [self.view addSubview:hospitalTableView];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [hospitalTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [self requestListOfAllHospitals];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    region.center.latitude = currentLocation.coordinate.latitude;
    region.center.longitude = currentLocation.coordinate.longitude;
    region.span.latitudeDelta = 0.0001;
    region.span.longitudeDelta = 0.0001;
    
    [locationManager stopUpdatingLocation];
}

- (void)requestListOfAllHospitals
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://115.28.3.92:8000/all_hospitals"]];
    
    [urlRequest addValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [urlRequest setTimeoutInterval:10.0f];
    
    AFHTTPRequestOperation *httpRequest = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    [httpRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil];
        
        int result = [[responseDic objectForKey:@"result"] intValue];
        
        if (result == 1) {
            NSLog(@"%@", responseDic);
            
            hospitalArray = [responseDic objectForKey:@"hospitals"];
            
            [hospitalTableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                       }];
    
    [httpRequest start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return hospitalArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    HospitalListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HospitalListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setDelegate:self];
    }
    
    int index = indexPath.row;
    
    NSDictionary *hospitalDic = [hospitalArray objectAtIndex:index];
    
    [cell setName:[hospitalDic objectForKey:@"name"]];
    [cell setScore:[hospitalDic objectForKey:@"score"]];
    [cell setId_No:[hospitalDic objectForKey:@"id"]];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSDictionary *hospitalDic = [hospitalArray objectAtIndex:indexPath.row];
//    
//    NSString *hospitalId = [hospitalDic objectForKey:@"id"];
//    
//    
//}

- (void)reservation:(HospitalListCell *)cell
{
    DepartmentListViewController *dlVC = [[DepartmentListViewController alloc] init];
    [self.navigationController pushViewController:dlVC animated:YES];
    
    [dlVC setHospitalId:cell.id_No];
}

//- (NSArray *)analyzingHospitalInfoFromJSON:(NSArray *)hpArray
//{
//    NSMutableArray *mArray = [NSMutableArray array];
//    
//    for (NSDictionary *dic in hpArray) {
//        Hospital *hospital = [[Hospital alloc] init];
//        [hospital setAbbr:[dic objectForKey:@"abbr"]];
//        [hospital setAddress:[dic objectForKey:@"address"]];
//        [hospital setCity:[dic objectForKey:@"city"]];
//        [hospital setDescription:[dic objectForKey:@"description"]];
//        [hospital setDistrict:[dic objectForKey:@"district"]];
//        [hospital setId_No:[dic objectForKey:@"id"]];
//        [hospital setLatitude:[dic objectForKey:@"latitude"]];
//        [hospital setLongitude:[dic objectForKey:@"longitude"]];
//        [hospital setName:[dic objectForKey:@"name"]];
//        [hospital setPhoneArray:[dic objectForKey:@"phones"]];
//        [hospital setProvince:[dic objectForKey:@"province"]];
//        [hospital setWebsite:[dic objectForKey:@"website"]];
//        
//        [mArray addObject:hospital];
//    }
//    
//    return mArray;
//}

- (void)viewDidAppear:(BOOL)animated
{
    typeSegmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"约过", @"附近", @"全部", nil]];
    [typeSegmentControl setFrame:CGRectMake(45, 6, 231, 30)];
    [typeSegmentControl setTintColor:[UIColor whiteColor]];
    [typeSegmentControl setSelectedSegmentIndex:2];
    [typeSegmentControl addTarget:self action:@selector(selectSegment:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:typeSegmentControl];
}

- (void)selectSegment:(UISegmentedControl *)segment
{
    int index = segment.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}

- (void)updateCurrentLocation
{
    [locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [typeSegmentControl removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

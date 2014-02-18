//
//  ReservationCenterViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-11.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "ReservationCenterViewController.h"
#import "Reservation_HospitalList_ViewController.h"

@interface ReservationCenterViewController ()
{
    NSArray *titleArray;
}

@end

@implementation ReservationCenterViewController

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
    
    titleArray = [NSArray arrayWithObjects:@"按医院预约", @"按疾病预约", @"按专科预约", @"智能就医", nil];
    
    [self.titleLabel setText:@"就医预约"];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:nilView];
    
    UITableView *serviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(17, 84, 286, 352)
                                                                 style:UITableViewStylePlain];
    [serviceTableView setDataSource:self];
    [serviceTableView setDelegate:self];
    [serviceTableView setBounces:NO];
    [serviceTableView setRowHeight:88.0f];
    [serviceTableView setSeparatorColor:HPO_BROWN];
    [serviceTableView.layer setBorderWidth:1.0f];
    [serviceTableView.layer setBorderColor:[HPO_BROWN CGColor]];
    [serviceTableView.layer setCornerRadius:3.0f];
    [serviceTableView.layer setMasksToBounds:YES];
    [self.view addSubview:serviceTableView];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [serviceTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UIButton *revisitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [revisitButton setFrame:CGRectMake(98, 481, 125, 33)];
    [revisitButton setBackgroundColor:HPO_LINEN];
    [revisitButton setTitle:@"复诊请点此处" forState:UIControlStateNormal];
    [revisitButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [revisitButton.titleLabel setFont:[UIFont systemFontOfSize:13.5f]];
    [revisitButton.layer setCornerRadius:3.0f];
    [revisitButton.layer setMasksToBounds:YES];
    [revisitButton.layer setBorderWidth:1.0f];
    [revisitButton.layer setBorderColor:[HPO_BROWN CGColor]];
    //    [revisitButton addTarget:self action:@selector(resend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:revisitButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        [cell.textLabel setFont:[UIFont systemFontOfSize:20.0f]];
    }
    
    [cell.textLabel setText:[titleArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    
    NSString *className = @"";
    
    switch (index) {
        case 0:
            className = @"Reservation_HospitalList_ViewController";
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
    
    if (![className isEqualToString:@""]) {
        [self pushToViewControllerWithClassName:className];
    }
}

- (void)pushToViewControllerWithClassName:(NSString *)className
{
    Class class = NSClassFromString(className);
    
    id customVC = [[class alloc] init];
    
    [self.navigationController pushViewController:customVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

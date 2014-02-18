//
//  DepartmentListViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-10.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "DepartmentListViewController.h"
#import "SubdepartmentListCell.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

@interface DepartmentListViewController ()
{
    UITableView *departmentTableView;
    UITableView *subdepartmentTableView;
    UIView *cellSelectedBGView;
    
    NSArray *departmentArray;
    NSArray *subdepartmentArray;
}

@end

@implementation DepartmentListViewController

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
    
    [self.titleLabel setText:@"选择科室"];
    
    departmentArray = [NSArray array];
    subdepartmentArray = [NSArray array];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:nilView];
    
    departmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 160, self.view.bounds.size.height - 64)
                                                       style:UITableViewStylePlain];
    [departmentTableView setBackgroundColor:HPO_LINEN];
    [departmentTableView setDataSource:self];
    [departmentTableView setDelegate:self];
    [departmentTableView setSeparatorColor:HPO_BROWN];
    [self.view addSubview:departmentTableView];
    
    subdepartmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(160, 64, 160, self.view.bounds.size.height - 64)
                                                          style:UITableViewStylePlain];
    [subdepartmentTableView setDataSource:self];
    [subdepartmentTableView setDelegate:self];
    [subdepartmentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:subdepartmentTableView];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [departmentTableView setSeparatorInset:UIEdgeInsetsZero];
        [subdepartmentTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(160, 64, 1, self.view.bounds.size.height - 64)];
    [lineView setBackgroundColor:HPO_BROWN];
    [self.view addSubview:lineView];
    
    cellSelectedBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, departmentTableView.bounds.size.width, departmentTableView.rowHeight)];
    [cellSelectedBGView setBackgroundColor:[UIColor whiteColor]];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, departmentTableView.rowHeight)];
    [greenView setBackgroundColor:HPO_GREEN];
    [cellSelectedBGView addSubview:greenView];
    
    for (int i = 0; i < 2; i++) {
        UIView *cutLineView = [[UIView alloc] initWithFrame:CGRectMake(0, i * cellSelectedBGView.bounds.size.height, cellSelectedBGView.bounds.size.width, 1)];
        [cutLineView setBackgroundColor:HPO_BROWN];
        [cellSelectedBGView addSubview:cutLineView];
    }
}

- (void)setHospitalId:(NSString *)hospitalId
{
    _hospitalId = hospitalId;
    
    [self requestListOfDepartment];
}

- (void)requestListOfDepartment
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.3.92:8000/hospital_departments/%@", self.hospitalId]]];
    
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
            
            departmentArray = [responseDic objectForKey:@"departments"];
            subdepartmentArray = [[departmentArray objectAtIndex:0] objectForKey:@"sub_deparments"];
            
            [departmentTableView reloadData];
            [subdepartmentTableView reloadData];
            
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
    if ([tableView isEqual:departmentTableView]) {
        return departmentArray.count;
    } else {
        return subdepartmentArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:departmentTableView]) {
        static NSString *identifier = @"DepartmentListCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:identifier];
            [cell setBackgroundColor:HPO_LINEN];
            [cell setSelectedBackgroundView:cellSelectedBGView];
            [cell.textLabel setTextColor:HPO_GREEN];
        }
        
        [cell.textLabel setText:[[departmentArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        return cell;
    } else {
        static NSString *identifier = @"SubdepartmentListCell";
        
        SubdepartmentListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[SubdepartmentListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:identifier];
            
        }
        
        if (subdepartmentArray.count > 0) {
            [cell.textLabel setText:[[subdepartmentArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:departmentTableView]) {
        subdepartmentArray = [[departmentArray objectAtIndex:indexPath.row] objectForKey:@"sub_deparments"];
        
        [subdepartmentTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  PatientSelectView.m
//  HPOdemo
//
//  Created by Gueie on 14-2-12.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "PatientSelectView.h"
@interface PatientSelectView ()
{
    UITableView *patientTableView;
    NSArray *patientArray;
}

@end

@implementation PatientSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        UIView *bgView = [[UIView alloc] initWithFrame:frame];
//        [bgView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.75f]];
//        [self addSubview:bgView];
        
        patientArray = @[@"王宝强  (1110**********8888)", @"刘宝强  (1110**********8888)", @"牛宝强  (1110**********8888)", @"王宝强  (1110**********8888)", @"刘宝强  (1110**********8888)", @"牛宝强  (1110**********8888)", @"王宝强  (1110**********8888)", @"刘宝强  (1110**********8888)", @"牛宝强  (1110**********8888)"];
        
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
        
        UIView *listBgView = [[UIView alloc] initWithFrame:CGRectMake(16, 102, 288, 264)];
        [listBgView setBackgroundColor:[UIColor whiteColor]];
        [listBgView.layer setCornerRadius:3.0f];
        [listBgView.layer setMasksToBounds:YES];
        [self addSubview:listBgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 288, 44)];
        [titleLabel setBackgroundColor:HPO_GREEN];
        [titleLabel setText:@"选择就诊人"];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:19.0f]];
        [listBgView addSubview:titleLabel];
        
        patientTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 288, 44 * 4) style:UITableViewStylePlain];
        [patientTableView setDataSource:self];
        [patientTableView setDelegate:self];
        [patientTableView setRowHeight:44.0f];
        [listBgView addSubview:patientTableView];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [patientTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        UIButton *addPatientButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addPatientButton setFrame:CGRectMake(0, 176, 288, 44)];
        [addPatientButton setBackgroundColor:[UIColor whiteColor]];
        [addPatientButton setTitle:@"+添加新就诊人" forState:UIControlStateNormal];
        [addPatientButton setTitleColor:HPO_GREEN forState:UIControlStateNormal];
        [addPatientButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [addPatientButton addTarget:self action:@selector(addPatient) forControlEvents:UIControlEventTouchUpInside];
        [listBgView addSubview:addPatientButton];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(0, 220, 288, 44)];
        [cancelButton setBackgroundColor:[UIColor colorWithRed:70 / 255.0f green:70 / 255.0f blue:70 / 255.0f alpha:1.0f]];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [listBgView addSubview:cancelButton];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return patientArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
        [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
    }

    [cell.textLabel setText:[patientArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)cancel
{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

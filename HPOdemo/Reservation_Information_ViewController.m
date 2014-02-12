//
//  Reservation_Information_ViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-12.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "Reservation_Information_ViewController.h"

@interface Reservation_Information_ViewController ()
{
    UIScrollView *bgScrollView;
    UILabel *infoLabel;
    UILabel *nameLabel;
    UILabel *idCardNoLabel;
    UILabel *telNoLabel;
    
    UIView *diagnosisInfoBGView;
    UIView *diagnosisBGView;
    UIButton *diagnosisYesButton;
    UIButton *diagnosisNoButton;
    UITextField *detailDiagnosisTextField;
    
    BOOL isDiagnosisPanelShow;
    BOOL isDiagnosisYes;
    
    UIView *reasonInfoBGView;
    UIView *reasonBGView;
    UIButton *reasonButton;
    UILabel *reasonLabel;
    UITableView *reasonTableView;
    UITextField *noteTextField;
    
    NSArray *reasonArray;
    
    BOOL isReasonPanelShow;
    
    UIButton *nextButton;
}

@end

@implementation Reservation_Information_ViewController

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
    
    reasonArray = [NSArray arrayWithObjects:@"原因1", @"原因2", @"原因3", @"原因4", @"原因5", @"原因6", @"原因7", nil];
    
    [self.titleLabel setText:@"预约信息"];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:nilView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tapGesture setNumberOfTapsRequired:1];
    
    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height - 64)];
    [bgScrollView setContentSize:CGSizeMake(320, 550)];
    [bgScrollView addGestureRecognizer:tapGesture];
    [self.view addSubview:bgScrollView];
    
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 320, 15)];
    [infoLabel setText:@"北京协和医院 · 神经内科"];
    [infoLabel setTextColor:[UIColor grayColor]];
    [infoLabel setTextAlignment:NSTextAlignmentCenter];
    [infoLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [bgScrollView addSubview:infoLabel];
    
    UIView *personInfoBGView = [[UIView alloc] initWithFrame:CGRectMake(16, 37, 288, 132)];
    [personInfoBGView setBackgroundColor:[UIColor whiteColor]];
    [personInfoBGView.layer setCornerRadius:3.0f];
    [personInfoBGView.layer setMasksToBounds:YES];
    [personInfoBGView.layer setBorderWidth:1.0f];
    [personInfoBGView.layer setBorderColor:HPO_BROWN.CGColor];
    [bgScrollView addSubview:personInfoBGView];
    
    UIButton *demanderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [demanderButton setFrame:CGRectMake(0, 0, 288, 44)];
    [demanderButton setTitle:@"就诊人:" forState:UIControlStateNormal];
    [demanderButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [demanderButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [demanderButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -177, 0, 0)];
    [personInfoBGView addSubview:demanderButton];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, 44)];
    [nameLabel setText:@"王宝强"];
    [nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [demanderButton addSubview:nameLabel];
    
    UILabel *idCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 288, 44)];
    [idCardLabel setText:@"   身份证号:"];
    [idCardLabel setTextColor:[UIColor grayColor]];
    [idCardLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [idCardLabel.layer setBorderWidth:1.0f];
    [idCardLabel.layer setBorderColor:HPO_LINEN.CGColor];
    [personInfoBGView addSubview:idCardLabel];
    
    idCardNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, 44)];
    [idCardNoLabel setText:@"1101**********8888"];
    [idCardNoLabel setTextColor:[UIColor grayColor]];
    [idCardNoLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [idCardLabel addSubview:idCardNoLabel];
    
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 62, 44)];
    [telLabel setText:@"手机号:"];
    [telLabel setTextColor:[UIColor grayColor]];
    [telLabel setTextAlignment:NSTextAlignmentRight];
    [telLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [personInfoBGView addSubview:telLabel];
    
    telNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 88, 150, 44)];
    [telNoLabel setText:@"138****8888"];
    [telNoLabel setTextColor:[UIColor grayColor]];
    [telNoLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [personInfoBGView addSubview:telNoLabel];
    
    diagnosisInfoBGView = [[UIView alloc] initWithFrame:CGRectMake(16, 182, 288, 132)];
    [diagnosisInfoBGView setBackgroundColor:[UIColor whiteColor]];
    [diagnosisInfoBGView.layer setCornerRadius:3.0f];
    [diagnosisInfoBGView.layer setMasksToBounds:YES];
    [diagnosisInfoBGView.layer setBorderWidth:1.0f];
    [diagnosisInfoBGView.layer setBorderColor:HPO_BROWN.CGColor];
    [bgScrollView addSubview:diagnosisInfoBGView];
    
    UILabel *diagnosisTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 288, 44)];
    [diagnosisTipLabel setBackgroundColor:[UIColor colorWithRed:247 / 255.0f green:241 / 255.0f blue:227 / 255.0f alpha:1.0f]];
    [diagnosisTipLabel setText:@"   您是否已确诊?"];
    [diagnosisTipLabel setTextColor:HPO_GREEN];
    [diagnosisTipLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [diagnosisInfoBGView addSubview:diagnosisTipLabel];
    
    detailDiagnosisTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 88, 258, 44)];
    [detailDiagnosisTextField setDelegate:self];
    [detailDiagnosisTextField setPlaceholder:@"请输入确诊的疾病名称"];
    [detailDiagnosisTextField setTextColor:[UIColor darkGrayColor]];
    [diagnosisInfoBGView addSubview:detailDiagnosisTextField];
    
    diagnosisBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 288, 44)];
    [diagnosisBGView setBackgroundColor:[UIColor whiteColor]];
    [diagnosisBGView.layer setMasksToBounds:YES];
    [diagnosisBGView.layer setBorderWidth:1.0f];
    [diagnosisBGView.layer setBorderColor:HPO_BROWN.CGColor];
    [diagnosisInfoBGView addSubview:diagnosisBGView];
    
    diagnosisYesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [diagnosisYesButton setFrame:CGRectMake(0, 0, 288, 44)];
    [diagnosisYesButton setTitle:@"已确诊" forState:UIControlStateNormal];
    [diagnosisYesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [diagnosisYesButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [diagnosisYesButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -210, 0, 0)];
    [diagnosisYesButton addTarget:self action:@selector(selectDiagnosisState:) forControlEvents:UIControlEventTouchUpInside];
    [diagnosisYesButton.layer setBorderWidth:1.0f];
    [diagnosisYesButton.layer setBorderColor:HPO_BROWN.CGColor];
    [diagnosisBGView addSubview:diagnosisYesButton];
    
    diagnosisNoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [diagnosisNoButton setFrame:CGRectMake(0, 44, 288, 44)];
    [diagnosisNoButton setTitle:@"未确诊" forState:UIControlStateNormal];
    [diagnosisNoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [diagnosisNoButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [diagnosisNoButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -210, 0, 0)];
    [diagnosisNoButton addTarget:self action:@selector(selectDiagnosisState:) forControlEvents:UIControlEventTouchUpInside];
    [diagnosisBGView addSubview:diagnosisNoButton];
    
    isDiagnosisYes = YES;
    isDiagnosisPanelShow = NO;
    
    reasonInfoBGView = [[UIView alloc] initWithFrame:CGRectMake(16, 328, 288, 132)];
    [reasonInfoBGView setBackgroundColor:[UIColor whiteColor]];
    [reasonInfoBGView.layer setCornerRadius:3.0f];
    [reasonInfoBGView.layer setMasksToBounds:YES];
    [reasonInfoBGView.layer setBorderWidth:1.0f];
    [reasonInfoBGView.layer setBorderColor:HPO_BROWN.CGColor];
    [bgScrollView addSubview:reasonInfoBGView];
    
    UILabel *reasonTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 288, 44)];
    [reasonTipLabel setBackgroundColor:[UIColor colorWithRed:247 / 255.0f green:241 / 255.0f blue:227 / 255.0f alpha:1.0f]];
    [reasonTipLabel setText:@"   您预约的主要原因是?"];
    [reasonTipLabel setTextColor:HPO_GREEN];
    [reasonTipLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [reasonInfoBGView addSubview:reasonTipLabel];
    
    noteTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 88, 258, 44)];
    [noteTextField setDelegate:self];
    [noteTextField setPlaceholder:@"补充说明"];
    [noteTextField setTextColor:[UIColor darkGrayColor]];
    [reasonInfoBGView addSubview:noteTextField];
    
    reasonBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 288, 44)];
    [reasonBGView setBackgroundColor:[UIColor whiteColor]];
    [reasonBGView setUserInteractionEnabled:YES];
    [reasonBGView.layer setMasksToBounds:YES];
    [reasonBGView.layer setBorderWidth:1.0f];
    [reasonBGView.layer setBorderColor:HPO_BROWN.CGColor];
    [reasonInfoBGView addSubview:reasonBGView];
    
    reasonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reasonButton setFrame:CGRectMake(0, 0, 288, 44)];
    [reasonButton addTarget:self action:@selector(selectReason) forControlEvents:UIControlEventTouchUpInside];
    [reasonButton.layer setBorderWidth:1.0f];
    [reasonButton.layer setBorderColor:HPO_BROWN.CGColor];
    [reasonBGView addSubview:reasonButton];
    
    reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 225, 44)];
    [reasonLabel setText:@"原因1"];
    [reasonLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [reasonButton addSubview:reasonLabel];
    
    reasonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 288, 44 * reasonArray.count) style:UITableViewStylePlain];
    [reasonTableView setDelegate:self];
    [reasonTableView setDataSource:self];
    [reasonTableView setRowHeight:44.0f];
    [reasonBGView addSubview:reasonTableView];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [reasonTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setFrame:CGRectMake(16, 474, 320 - 32, 44)];
    [nextButton setBackgroundColor:HPO_GREEN];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [nextButton.layer setCornerRadius:3.0f];
    [nextButton.layer setMasksToBounds:YES];
    [bgScrollView addSubview:nextButton];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return reasonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
    }
    
    [cell.textLabel setText:[reasonArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [reasonLabel setText:cell.textLabel.text];
    
    NSLog(@"%@", cell.textLabel.text);
    
    [reasonInfoBGView setFrame:CGRectMake(reasonInfoBGView.frame.origin.x,
                                          reasonInfoBGView.frame.origin.y,
                                          reasonInfoBGView.frame.size.width,
                                          132)];
    
    [reasonBGView setFrame:CGRectMake(reasonBGView.frame.origin.x,
                                      reasonBGView.frame.origin.y,
                                      reasonBGView.frame.size.width,
                                      44)];
    
    [bgScrollView setContentSize:CGSizeMake(bgScrollView.contentSize.width,
                                            bgScrollView.contentSize.height - 44 * reasonArray.count)];
    
    [noteTextField setFrame:CGRectMake(noteTextField.frame.origin.x,
                                       reasonInfoBGView.bounds.size.height - 44,
                                       noteTextField.frame.size.width,
                                       noteTextField.frame.size.height)];
    
    [nextButton setFrame:CGRectMake(nextButton.frame.origin.x,
                                    reasonInfoBGView.frame.origin.y + reasonInfoBGView.frame.size.height + 12,
                                    nextButton.frame.size.width,
                                    nextButton.frame.size.height)];
    
    isReasonPanelShow = NO;
}

- (void)selectReason
{
    if (isReasonPanelShow) {
        [reasonInfoBGView setFrame:CGRectMake(reasonInfoBGView.frame.origin.x,
                                              reasonInfoBGView.frame.origin.y,
                                              reasonInfoBGView.frame.size.width,
                                              132)];
        
        [reasonBGView setFrame:CGRectMake(reasonBGView.frame.origin.x,
                                          reasonBGView.frame.origin.y,
                                          reasonBGView.frame.size.width,
                                          44)];
        
        [bgScrollView setContentSize:CGSizeMake(bgScrollView.contentSize.width,
                                                bgScrollView.contentSize.height - 44 * reasonArray.count)];
        
        isReasonPanelShow = NO;
    } else {
        [reasonInfoBGView setFrame:CGRectMake(reasonInfoBGView.frame.origin.x,
                                              reasonInfoBGView.frame.origin.y,
                                              reasonInfoBGView.frame.size.width,
                                              44 * (reasonArray.count + 2))];
        
        [reasonBGView setFrame:CGRectMake(reasonBGView.frame.origin.x,
                                          reasonBGView.frame.origin.y,
                                          reasonBGView.frame.size.width,
                                          44 * reasonArray.count)];
        
        [bgScrollView setContentSize:CGSizeMake(bgScrollView.contentSize.width,
                                                bgScrollView.contentSize.height + 44 * reasonArray.count)];
        
        [bgScrollView setContentOffset:CGPointMake(0, 300) animated:YES];
    
        isReasonPanelShow = YES;
    }
    
    [noteTextField setFrame:CGRectMake(noteTextField.frame.origin.x,
                                       reasonInfoBGView.bounds.size.height - 44,
                                       noteTextField.frame.size.width,
                                       noteTextField.frame.size.height)];
    
    [nextButton setFrame:CGRectMake(nextButton.frame.origin.x,
                                    reasonInfoBGView.frame.origin.y + reasonInfoBGView.frame.size.height + 12,
                                    nextButton.frame.size.width,
                                    nextButton.frame.size.height)];
}

- (void)selectDiagnosisState:(UIButton *)button
{
    if (!isDiagnosisPanelShow) {
        
        [diagnosisInfoBGView setFrame:CGRectMake(diagnosisInfoBGView.frame.origin.x,
                                                 diagnosisInfoBGView.frame.origin.y,
                                                 diagnosisInfoBGView.frame.size.width,
                                                 132)];
        
        [diagnosisBGView setFrame:CGRectMake(diagnosisBGView.frame.origin.x,
                                             diagnosisBGView.frame.origin.y,
                                             diagnosisBGView.frame.size.width,
                                             88)];
        isDiagnosisPanelShow = YES;
    } else {
        if ([button isEqual:diagnosisYesButton]) {
            [diagnosisYesButton setFrame:CGRectMake(0, 0, 288, 44)];
            [diagnosisNoButton setFrame:CGRectMake(0, 44, 288, 44)];
            
            isDiagnosisYes = YES;
        } else if ([button isEqual:diagnosisNoButton]) {
            [diagnosisNoButton setFrame:CGRectMake(0, 0, 288, 44)];
            [diagnosisYesButton setFrame:CGRectMake(0, 44, 288, 44)];
            
            [diagnosisInfoBGView setFrame:CGRectMake(diagnosisInfoBGView.frame.origin.x,
                                                     diagnosisInfoBGView.frame.origin.y,
                                                     diagnosisInfoBGView.frame.size.width,
                                                     88)];
            
            isDiagnosisYes = NO;
        }
        
        [diagnosisBGView setFrame:CGRectMake(diagnosisBGView.frame.origin.x,
                                             diagnosisBGView.frame.origin.y,
                                             diagnosisBGView.frame.size.width,
                                             44)];
        
        isDiagnosisPanelShow = NO;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:detailDiagnosisTextField]) {
        [bgScrollView setContentOffset:CGPointMake(0, 170) animated:YES];
    } else if ([textField isEqual:noteTextField]) {
        if (isReasonPanelShow) {
            //  todo
            
        } else {
            [bgScrollView setContentOffset:CGPointMake(0, 300) animated:YES];
        }
    }
    
    return YES;
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    if ([detailDiagnosisTextField isFirstResponder] || [noteTextField isFirstResponder]) {
        [detailDiagnosisTextField resignFirstResponder];
        [noteTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

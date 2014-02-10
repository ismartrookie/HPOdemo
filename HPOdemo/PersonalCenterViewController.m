//
//  PersonalCenterViewController.m
//  HPOdemo
//
//  Created by Gueie on 14-2-9.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "HomeViewController.h"
#import "PersonalCenterCell.h"

@interface PersonalCenterViewController ()
{
    NSDictionary *dataSourceDic;
    NSArray *titleArray;
    NSArray *imageArray;
}

@end

NSString *kCellID = @"cellID";

@implementation PersonalCenterViewController

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
    
//    dataSourceDic = [NSDictionary dictionaryWithObjectsAndKeys:@"personal_center_1", @"就医预约", @"personal_center_2", @"咨询医生", @"personal_center_3", @"医院导航", @"personal_center_4", @"我的账户", @"personal_center_5", @"电话热线", @"personal_center_6", @"医疗工具箱", @"personal_center_7", @"保险保障", @"personal_center_8", @"洗牙服务", nil];
    
    titleArray = [NSArray arrayWithObjects:@"就医预约", @"咨询医生", @"医院导航", @"我的账户", @"电话热线", @"医疗工具箱", @"保险保障", @"洗牙服务", nil];
    
    imageArray = [NSArray arrayWithObjects:@"personal_center_1", @"personal_center_2", @"personal_center_3", @"personal_center_4", @"personal_center_5", @"personal_center_6", @"personal_center_7", @"personal_center_8", nil];
    
//    dataSourceDic = [NSDictionary dictionaryWithObjects:imageArray forKeys:titleArray];
    
    UIView *headerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 107)];
    [headerBGView setBackgroundColor:HPO_GREEN];
    [self.view addSubview:headerBGView];
    
    UIImageView *faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 32, 58, 58)];
    [faceImageView.layer setCornerRadius:29.0f];
    [faceImageView.layer setMasksToBounds:YES];
    [faceImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [faceImageView.layer setBorderWidth:2.0f];
    [headerBGView addSubview:faceImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 39, 135, 21)];
    [nameLabel setText:@"王宝强"];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:20.5f]];
    [headerBGView addSubview:nameLabel];
    
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(81, 69, 135, 15)];
    [companyLabel setText:@"某某公司"];
    [companyLabel setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.75f]];
    [companyLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [headerBGView addSubview:companyLabel];
    
    UIImageView *cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(254, 37, 52, 32)];
    [cardImageView setBackgroundColor:[UIColor lightGrayColor]];
    [cardImageView.layer setCornerRadius:4.0f];
    [cardImageView.layer setMasksToBounds:YES];
    [headerBGView addSubview:cardImageView];
    
    UILabel *cardNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(217, 76, 90, 10)];
    [cardNameLabel setText:@"华夏员工健康卡"];
    [cardNameLabel setTextAlignment:NSTextAlignmentRight];
    [cardNameLabel setTextColor:[UIColor whiteColor]];
    [cardNameLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [headerBGView addSubview:cardNameLabel];
    
    UIView *messageBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 107, 320, 44)];
    [messageBGView setBackgroundColor:HPO_LINEN];
    [self.view addSubview:messageBGView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(86, 86)];
    [layout setMinimumLineSpacing:27.0f];
    [layout setSectionInset:UIEdgeInsetsMake(29.0f, 15.0f, 0, 15.0f)];
    
    UICollectionView *serviceCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 151, 320, self.view.bounds.size.height - 151)
                                                                 collectionViewLayout:layout];
    [serviceCollectionView registerClass:[PersonalCenterCell class]
         forCellWithReuseIdentifier:kCellID];
    [serviceCollectionView setBackgroundColor:[UIColor whiteColor]];
    [serviceCollectionView setDelegate:self];
    [serviceCollectionView setDataSource:self];
    [self.view addSubview:serviceCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    PersonalCenterCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    int index = indexPath.row;
    
//    [cell.titleLabel setText:[[dataSourceDic allKeys] objectAtIndex:index]];
//    [cell.imageView setImage:[UIImage imageNamed:[[dataSourceDic allValues] objectAtIndex:index]]];
    
    [cell.titleLabel setText:[titleArray objectAtIndex:index]];
    [cell.imageView setImage:[UIImage imageNamed:[imageArray objectAtIndex:index]]];
    
    return cell;
}

- (void)viewDidAppear:(BOOL)animated
{
    HomeViewController *hVC = [[HomeViewController alloc] init];
    
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:hVC];
    
    [self presentViewController:unc animated:NO completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
#import "ReservationCenterViewController.h"
#import "UserInfo.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "FormatCheck.h"


@interface PersonalCenterViewController ()
{
    NSArray *titleArray;
    NSArray *imageArray;
    
    UILabel *nameLabel;
}

@property (nonatomic, strong) UIImageView *portraitImageView;

@end

#define ORIGINAL_MAX_WIDTH 640.0f

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

    titleArray = [NSArray arrayWithObjects:@"就医预约", @"咨询医生", @"医院导航", @"我的账户", @"电话热线", @"医疗工具箱", @"保险保障", @"洗牙服务", nil];
    
    imageArray = [NSArray arrayWithObjects:@"personal_center_1", @"personal_center_2", @"personal_center_3", @"personal_center_4", @"personal_center_5", @"personal_center_6", @"personal_center_7", @"personal_center_8", nil];
    
    [self.view setHidden:YES];
    
    UIView *headerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 107)];
    [headerBGView setBackgroundColor:HPO_GREEN];
    [self.view addSubview:headerBGView];
    
    UIImageView *faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 32, 58, 58)];
    [faceImageView.layer setCornerRadius:29.0f];
    [faceImageView.layer setMasksToBounds:YES];
    [faceImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [faceImageView.layer setBorderWidth:2.0f];
    [headerBGView addSubview:faceImageView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 39, 135, 21)];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:20.5f]];
    [headerBGView addSubview:nameLabel];
    
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(81, 69, 135, 15)];
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
    
    [self.view addSubview:self.portraitImageView];
    [self loadPortrait];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    PersonalCenterCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    int index = indexPath.row;
    
    [cell.titleLabel setText:[titleArray objectAtIndex:index]];
    [cell.imageView setImage:[UIImage imageNamed:[imageArray objectAtIndex:index]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    
    NSString *className = @"";
    
    switch (index) {
        case 0:
            className = @"ReservationCenterViewController";
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
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

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"userInfo"] ==  nil) {
        HomeViewController *hVC = [[HomeViewController alloc] init];
        
        UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:hVC];
        
        [self presentViewController:unc animated:NO completion:NULL];
    } else {
        UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"userInfo"]];
        
        NSString *mobilePhone = userInfo.mobilephone;
        NSString *password = userInfo.password;
        
        if (userInfo != nil) {
            if (userInfo.mobilephone != nil && userInfo.password != nil) {
                [self.view setHidden:NO];
                
                [self requestSignInByMobilePhone:mobilePhone AndPassword:password];
            }
        } else {
            HomeViewController *hVC = [[HomeViewController alloc] init];
            
            UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:hVC];
            
            [self presentViewController:unc animated:NO completion:NULL];
        }
    }
}

- (void)requestSignInByMobilePhone:(NSString *)mobilePhone
                       AndPassword:(NSString *)password
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://115.28.3.92:8000/login?mobilephone=%@&password=%@", mobilePhone, password]]];
    
    [urlRequest addValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [urlRequest setTimeoutInterval:10.0f];
    
    AFHTTPRequestOperation *httpRequest = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    [httpRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil];
        
        int result = [[responseDic objectForKey:@"result"] intValue];
        
        NSString *sessionId = [self analysisSessionId:[[operation.response allHeaderFields] objectForKey:@"Set-Cookie"]];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:sessionId forKey:@"cookie"];
        [userDefaults synchronize];
        
        if (result == 1) {
            [self requestUserInfo];
        } else {
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
            
            HomeViewController *hVC = [[HomeViewController alloc] init];
            
            UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:hVC];
            
            [self presentViewController:unc animated:NO completion:NULL];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                       }];
    
    [httpRequest start];
}

- (void)requestUserInfo
{
    [SVProgressHUD show];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionId = [userDefaults objectForKey:@"cookie"];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://115.28.3.92:8000/userinfo"]];
    
    [urlRequest addValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [urlRequest addValue:sessionId forHTTPHeaderField:@"Cookie"];
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
            if ([[[responseDic objectForKey:@"user_info"] objectForKey:@"real_name"] isEqual:[NSNull null]]) {
                [nameLabel setText:[[responseDic objectForKey:@"user_info"] objectForKey:@"mobilephone"]];
            } else {
                [nameLabel setText:[[responseDic objectForKey:@"user_info"] objectForKey:@"real_name"]];
            }

            [self saveUserInfo:[responseDic objectForKey:@"user_info"]];
        } else {
            [SVProgressHUD showErrorWithStatus:[responseDic objectForKey:@"message"] duration:1.5f];
        }
    }
                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           [SVProgressHUD dismissWithError:@"网络异常" afterDelay:2];
                                       }];
    
    [httpRequest start];
}

- (void)saveUserInfo:(NSDictionary *)userInfoDic
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"userInfo"]];
    
    [userInfo setReal_name:     [userInfoDic objectForKey:@"real_name"]];
    [userInfo setId_number:     [userInfoDic objectForKey:@"id_number"]];
    [userInfo setGender:        [userInfoDic objectForKey:@"gender"]];
    [userInfo setBirthday:      [userInfoDic objectForKey:@"birthday"]];
    [userInfo setAddress:       [userInfoDic objectForKey:@"address"]];
    [userInfo setAge:           [userInfoDic objectForKey:@"age"]];
    [userInfo setAvatar:        [userInfoDic objectForKey:@"avatar"]];
    [userInfo setEducation:     [userInfoDic objectForKey:@"education"]];
    [userInfo setMarital_status:[userInfoDic objectForKey:@"marital_status"]];
    [userInfo setJob:           [userInfoDic objectForKey:@"job"]];
    [userInfo setNation:        [userInfoDic objectForKey:@"nation"]];
    [userInfo setNationality:   [userInfoDic objectForKey:@"nationality"]];
    [userInfo setProvince:      [userInfoDic objectForKey:@"province"]];
    
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:userInfo] forKey:@"userInfo"];
    [userDefaults synchronize];
}

- (NSString *)analysisSessionId:(NSString *)code
{
    int endIndex = [code rangeOfString:@";"].location;
    
    NSString *sessionId = [code substringToIndex:endIndex];
    
    return sessionId;
}
////////////////////////////
- (void)loadPortrait {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        NSURL *portraitUrl = [NSURL URLWithString:@"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg"];
        UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.portraitImageView.image = protraitImg;
        });
    });
}

- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // save and upload
        NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/portrait.png"];
//        NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.jpg"];
        
        // Write a UIImage to JPEG with minimum compression (best quality)
        // The value 'image' must be a UIImage object
        // The value '1.0' represents image compression quality as value from 0.0 to 1.0
//        [UIImageJPEGRepresentation(editedImage, 1.0) writeToFile:jpgPath atomically:YES];
        
        // Write image to PNG
        [UIImagePNGRepresentation(editedImage) writeToFile:pngPath atomically:YES];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 32, 58, 58)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height / 2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _portraitImageView.layer.shadowOpacity = 0.5;
        _portraitImageView.layer.shadowRadius = 2.0;
        _portraitImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _portraitImageView.layer.borderWidth = 2.0f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}
////////////////////////////

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

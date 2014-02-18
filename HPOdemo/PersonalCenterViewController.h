//
//  PersonalCenterViewController.h
//  HPOdemo
//
//  Created by Gueie on 14-2-9.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface PersonalCenterViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>

@end

//
//  Reservation_HospitalList_ViewController.h
//  HPOdemo
//
//  Created by Gueie on 14-2-11.
//  Copyright (c) 2014年 Gueie. All rights reserved.
//

#import "HPONavigationViewController.h"
#import "HospitalListCell.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Reservation_HospitalList_ViewController : HPONavigationViewController<UITableViewDataSource, UITableViewDelegate, HospitalListCellDelegate, CLLocationManagerDelegate>

@end

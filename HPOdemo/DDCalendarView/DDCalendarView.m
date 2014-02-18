//
//  DDCalendarView.m
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DDCalendarView.h"

@interface DDCalendarView ()
{
    int todayButtonTag;
    int selectedDayButtonTag;
//    NSDateComponents *selectedDay;
}

@end

@implementation DDCalendarView

- (id)initWithFrame:(CGRect)frame fontName:(NSString *)fontName delegate:(id)theDelegate {
	if ((self = [super initWithFrame:frame])) {
		self.delegate = theDelegate;
		
		//Initialise vars
		calendarWidth = frame.size.width;
		calendarHeight = frame.size.height;
        cellWidth = frame.size.width / 7.2f;
		cellHeight = frame.size.height / 9.0f;
		
		//Set up the calendar header
		UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [prevBtn setFrame:CGRectMake(0, 8, 70, 30)];
        [prevBtn setTitle:@"< 上个月" forState:UIControlStateNormal];
        [prevBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [prevBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[prevBtn addTarget:self action:@selector(prevBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
		
		UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[nextBtn setFrame:CGRectMake(frame.size.width - 70, 8, 70, 30)];
        [nextBtn setTitle:@"下个月 >" forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
		[nextBtn addTarget:self action:@selector(nextBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
		
		CGRect monthLabelFrame = CGRectMake(cellWidth, 4, calendarWidth - 2 * cellWidth, cellHeight);
		monthLabel = [[UILabel alloc] initWithFrame:monthLabelFrame];
        monthLabel.font = [UIFont boldSystemFontOfSize:19.0f];
		monthLabel.textAlignment = NSTextAlignmentCenter;
		monthLabel.backgroundColor = [UIColor clearColor];
		monthLabel.textColor = [UIColor blackColor];
		
		//Add the calendar header to view
		[self addSubview: prevBtn];
		[self addSubview: nextBtn];
		[self addSubview: monthLabel];
		
		//Add the day labels to the view
        NSArray *days = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
		for(int i = 0; i < 7; i++) {
			CGRect dayLabelFrame = CGRectMake(i*cellWidth + 5, cellHeight + 7, cellWidth, cellHeight);
			UILabel *dayLabel = [[UILabel alloc] initWithFrame:dayLabelFrame];
            dayLabel.text = [days objectAtIndex:i];
			dayLabel.textAlignment = NSTextAlignmentCenter;
			dayLabel.backgroundColor = [UIColor clearColor];
			dayLabel.font = [UIFont fontWithName:calendarFontName size:15];
			dayLabel.textColor = [UIColor darkGrayColor];
			
			[self addSubview:dayLabel];
		}
		
		[self drawDayButtons];
		
		//Set the current month and year and update the calendar
		calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		
		NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
		NSDateComponents *dateParts = [calendar components:unitFlags fromDate:[NSDate date]];
		currentMonth = [dateParts month];
		currentYear = [dateParts year];
        
        self.today = dateParts;
        
        NSLog(@"%@", dateParts);
		
		[self updateCalendarForMonth:currentMonth forYear:currentYear];
        
        selectedDayButtonTag = -1000;
        self.selectedDay = [[NSDateComponents alloc] init];
		
    }
    return self;
}

- (void)drawDayButtons {
	dayButtons = [[NSMutableArray alloc] initWithCapacity:42];
    
    int tag = 1001;
    
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			CGRect buttonFrame = CGRectMake(j * cellWidth + 5, (i + 2) * 43 - 7, 43, 43);
			DayButton *dayButton = [[DayButton alloc] buttonWithFrame:buttonFrame];
            dayButton.backgroundColor = HPO_LINEN;
            dayButton.tag = tag++;
			dayButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
            dayButton.layer.borderWidth = 0.5f;
            dayButton.layer.borderColor = [[UIColor colorWithRed:231 / 255.0f green:228 / 255.0f blue:215 / 255.0f alpha:1.0f] CGColor];
            
			dayButton.delegate = self;
			
			[dayButtons addObject:dayButton];
            
//            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//            gradientLayer.frame = CGRectMake(0, 0, dayButton.frame.size.width, 43.0f);
//            gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor],
//                             (id)[HPO_LINEN CGColor], nil];
//            [dayButton.layer insertSublayer:gradientLayer below:dayButton.titleLabel.layer];
			[self addSubview:dayButton];
		}
	}
}

- (void)updateCalendarForMonth:(int)month forYear:(int)year {
	monthLabel.text = [NSString stringWithFormat:(month < 10)?@"%d年0%d月":@"%d年%d月", year, month];
	
	//Get the first day of the month
	NSDateComponents *dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:month];
	[dateParts setYear:year];
	[dateParts setDay:1];
    
	NSDate *dateOnFirst = [calendar dateFromComponents:dateParts];
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit
                                                      fromDate:dateOnFirst];
    
	int weekdayOfFirst = [weekdayComponents weekday];
    
	int numDaysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit
										inUnit:NSMonthCalendarUnit
                                       forDate:dateOnFirst].length;
	
	int day = 1;
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			int buttonNumber = i * 7 + j;
			
			DayButton *button = [dayButtons objectAtIndex:buttonNumber];
			
			button.enabled = NO; //Disable buttons by default
			[button setTitle:nil forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
			[button setButtonDate:nil];
			
			if(buttonNumber >= (weekdayOfFirst - 1) && day <= numDaysInMonth) {
                
                [button setTitle:[NSString stringWithFormat:@"%d", day]
                        forState:UIControlStateNormal];
                
                if (day == 1) {
                    [button setTag:99];
                }
                
				NSDateComponents *dateParts = [[NSDateComponents alloc] init];
				[dateParts setMonth:month];
				[dateParts setYear:year];
				[dateParts setDay:day];
                
                if (self.today.year == dateParts.year && self.today.month == dateParts.month && self.today.day == dateParts.day) {
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    todayButtonTag = button.tag;
                    
                    NSLog(@"tbtag  = %d", todayButtonTag);
                    
//                    CAGradientLayer *shadow = [CAGradientLayer layer];
//                    shadow.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
//                    shadow.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.3 alpha:1.0] CGColor], // 0.2
//                                     (id)[[UIColor clearColor] CGColor], nil];
//                    [button.layer addSublayer:shadow];
                }
                
				NSDate *buttonDate = [calendar dateFromComponents:dateParts];
				[button setButtonDate:buttonDate];
                
                NSLog(@"%@", buttonDate);
				
                button.showsTouchWhenHighlighted = YES;
                button.enabled = YES;
                
				++day;
			}
		}
	}
}

- (void)prevBtnPressed:(id)sender {
	if(currentMonth == 1) {
		currentMonth = 12;
		--currentYear;
	} else {
		--currentMonth;
	}
	
	[self updateCalendarForMonth:currentMonth forYear:currentYear];
    
    DayButton *dayButton = (DayButton *)[self viewWithTag:todayButtonTag];
    
    if (self.today.year == currentYear && self.today.month == currentMonth) {
        [dayButton setBackgroundColor:[UIColor lightGrayColor]];
    } else {
        [dayButton setBackgroundColor:HPO_LINEN];
    }
    
    DayButton *selectedDayButton = (DayButton *)[self viewWithTag:selectedDayButtonTag];
    
    if (self.selectedDay.year == currentYear && self.selectedDay.month == currentMonth) {
        [selectedDayButton setImage:[UIImage imageNamed:@"day_selected"] forState:UIControlStateNormal];
    } else {
        [selectedDayButton setImage:nil forState:UIControlStateNormal];
    }
	
	if ([self.delegate respondsToSelector:@selector(prevButtonPressed)]) {
		[self.delegate prevButtonPressed];
	}
}

- (void)nextBtnPressed:(id)sender {
	if(currentMonth == 12) {
		currentMonth = 1;
		++currentYear;
	} else {
		++currentMonth;
	}
	
	[self updateCalendarForMonth:currentMonth forYear:currentYear];
    
    DayButton *dayButton = (DayButton *)[self viewWithTag:todayButtonTag];
    
    if (self.today.year == currentYear && self.today.month == currentMonth) {
        [dayButton setBackgroundColor:[UIColor lightGrayColor]];
    } else {
        [dayButton setBackgroundColor:HPO_LINEN];
    }
    
    DayButton *selectedDayButton = (DayButton *)[self viewWithTag:selectedDayButtonTag];
    
    if (self.selectedDay.year == currentYear && self.selectedDay.month == currentMonth) {
        [selectedDayButton setImage:[UIImage imageNamed:@"day_selected"] forState:UIControlStateNormal];
    } else {
        [selectedDayButton setImage:nil forState:UIControlStateNormal];
    }
	
	if ([self.delegate respondsToSelector:@selector(nextButtonPressed)]) {
		[self.delegate nextButtonPressed];
	}
}

- (void)dayButtonPressed:(id)sender {
	DayButton *dayButton = (DayButton *) sender;
	[self.delegate dayButtonPressed:dayButton];
    
    //  清除之前选中按钮的IMAGE
    if (selectedDayButtonTag != -1000) {
        DayButton *selectedDayButton = (DayButton *)[self viewWithTag:selectedDayButtonTag];
        [selectedDayButton setImage:nil forState:UIControlStateNormal];
    }
    
    selectedDayButtonTag = dayButton.tag;
    
    [dayButton setImage:[UIImage imageNamed:@"day_selected"] forState:UIControlStateNormal];
    
    self.selectedDay.year = currentYear;
    self.selectedDay.month = currentMonth;
    
//    NSLog(@"date = %@, tag = %d", dayButton.currentTitle, dayButton.tag);
}



@end

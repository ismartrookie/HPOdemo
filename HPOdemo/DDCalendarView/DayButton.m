//
//  DayButton.m
//  DDCalendarView
//
//  Created by Damian Dawber on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DayButton.h"

@implementation DayButton

- (id)buttonWithFrame:(CGRect)buttonFrame {
	UIButton *button = [DayButton buttonWithType:UIButtonTypeCustom];
	
	button.frame = buttonFrame;
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button addTarget:self.delegate action:@selector(dayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	
	return button;
}

@end

//
//  AnnouncementViewController.m
//  FoxLaneAppObC
//
//  Created by Brian Poor on 6/1/17.
//  Copyright © 2017 Brian Poor. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ChangeNavThing
    
    //self.automaticallyAdjustsScrollViewInsets = false;
    NSString *urlString = @"http://www.bcsdny.org/m/events.cfm";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

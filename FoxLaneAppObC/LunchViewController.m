//
//  AnnouncementViewController.m
//  FoxLaneAppObC
//
//  Created by Brian Poor on 6/1/17.
//  Copyright © 2017 Brian Poor. All rights reserved.
//

#import "LunchViewController.h"

@interface LunchViewController()

@end

@implementation LunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    NSString *urlString = @"http://www.bcsdny.org/files/filesystem/May%20MS%20HS%20Lunch.pdf";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    _webView.scalesPageToFit=true;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  Logger
//
//  Created by GNR solution PVT.LTD on 10/08/15.
//  Copyright (c) 2015 Harshavardhan Edke. All rights reserved.
//

#import "ViewController.h"
#import "HDLogger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HDLogger sharedInstance]logFor:@"ViewDidLoad"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[HDLogger sharedInstance]logFor:@"viewWillAppear"];
    
    NSLog(@"Printing file contents");
    NSLog(@"\n%@",[[HDLogger sharedInstance]getLogFilesContentWithMaxSize:1000]);
    
    /*
    NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    NSString *s = [d objectForKey:@"CFBundleExecutable"];
    NSLog(@"d: %@", s);
    
    NSLog(@"Pr %@",[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleName"]);*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

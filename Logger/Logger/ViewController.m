//
//  ViewController.m
//  Logger
//
//  Created by GNR solution PVT.LTD on 10/08/15.
//  Copyright (c) 2015 Harshavardhan Edke. All rights reserved.
//

#import "ViewController.h"
#import "HDLogger.h"


#import <MessageUI/MessageUI.h>


@interface ViewController ()<MFMailComposeViewControllerDelegate>

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
    
    
    UIButton *btnComposeEmail = [[UIButton alloc]initWithFrame:CGRectMake(10, 300, 300, 30)];
    [btnComposeEmail setTitle:@"Email Log" forState:UIControlStateNormal];
    btnComposeEmail.backgroundColor = [UIColor redColor];
    [btnComposeEmail addTarget:self action:@selector(openMailComposer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnComposeEmail];
    /*
    NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    NSString *s = [d objectForKey:@"CFBundleExecutable"];
    NSLog(@"d: %@", s);
    
    NSLog(@"Pr %@",[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleName"]);*/
}

#pragma mark -
#pragma mark -
#pragma mark -

-(void)openMailComposer:(UIButton *)sender{
    
    NSString *emailTitle = @"Feedback";
    // Email Content
    NSString *messageBody = @"Please type your feedback here:";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"jude@packedful.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:[[HDLogger sharedInstance] documentDirectoryLogFileLocation]];
    [mc addAttachmentData:data mimeType:@"application/log" fileName:[NSString stringWithFormat:@"%@.log",[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleName"]]];
    
    [self presentViewController:mc animated:YES completion:NULL];

}

#pragma mark -
#pragma mark - Mail Composer Delegate
#pragma mark -

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    //   [self.navigationController presentViewController:HomeVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

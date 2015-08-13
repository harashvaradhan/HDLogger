//
//  HDLogger.m
//  Logger
//
//  Created by GNR solution PVT.LTD on 10/08/15.
//  Copyright (c) 2015 Harshavardhan Edke. All rights reserved.
//
#define APPNAME @"Packedful"

#import "HDLogger.h"

@implementation HDLogger

static HDLogger *sharedInstance;
static NSString *appName;
+(HDLogger *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HDLogger alloc] init];
        appName = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleName"];
    });
    return sharedInstance;

}

-(NSString *)documentDirectoryLogFileLocation{
    
    NSArray *documentDirectoryFolderLocation = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    return [[documentDirectoryFolderLocation objectAtIndex:0]stringByAppendingString:[NSString stringWithFormat:@"%@.log",appName]];
}

-(void)logFor:(NSString *)text{
//    NSLog(@"HDLogger : %@",text);
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    NSString *logText;
    
    NSString *filePath = [self documentDirectoryLogFileLocation];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) { // if file is not exist, create it.
        NSError *error;
        logText = [NSString stringWithFormat:@"%@ : [%@] %@\n",[dateFormatter stringFromDate:[NSDate date]],appName,text];
        [logText writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }else{
        if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
            logText = [NSString stringWithFormat:@"%@ : [%@] %@\n",[dateFormatter stringFromDate:[NSDate date]],appName,text];
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[logText dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle closeFile];
        }else {
            NSLog(@"Not Writable");
        }
    }
}

- (NSString *) getLogFilesContentWithMaxSize:(NSInteger)maxSize {
    NSMutableString *description = [NSMutableString string];
    NSData *logData = [[NSFileManager defaultManager] contentsAtPath:[self documentDirectoryLogFileLocation]];
    if ([logData length] > 0) {
        NSString *result = [[NSString alloc] initWithBytes:[logData bytes]
                                                    length:[logData length]
                                                  encoding: NSUTF8StringEncoding];
        
        [description appendString:result];
    }
    if ([description length] > maxSize) {
        description = (NSMutableString *)[description substringWithRange:NSMakeRange([description length]-maxSize-1, maxSize)];
    }
    
    return description;
}

@end

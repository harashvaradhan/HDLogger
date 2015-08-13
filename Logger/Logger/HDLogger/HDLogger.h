//
//  HDLogger.h
//  Logger
//
//  Created by GNR solution PVT.LTD on 10/08/15.
//  Copyright (c) 2015 Harshavardhan Edke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDLogger : NSObject


+(HDLogger *)sharedInstance;
-(void)logFor:(NSString *)text;

-(NSString *)documentDirectoryLogFileLocation;

- (NSString *) getLogFilesContentWithMaxSize:(NSInteger)maxSize;
@end

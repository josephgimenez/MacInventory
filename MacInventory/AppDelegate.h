//
//  AppDelegate.h
//  MacInventory
//
//  Created by joseph gimenez on 4/28/12.
//  Copyright (c) 2012 PeopleMatter. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CredentialsWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, WriteToShareDrive>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSTextField *serialNumber;
@property (strong) IBOutlet NSTextField *model;
@property (strong) IBOutlet NSTextField *bank0;
@property (strong) IBOutlet NSTextField *bank1;
@property (strong) IBOutlet NSTextField *osVersion;
@property (strong) IBOutlet NSTextField *disk0;
@property (strong) IBOutlet NSTextField *disk1;
@property (strong) CredentialsWindowController *credentialsController;
@property (strong) NSString *owner;
@property (strong) NSString *userName;
@property (strong) NSString *data;

- (IBAction)Save:(id)sender;


- (NSString *) writeToBelarc: (NSString *) userName withPass: (NSString *) passWord;
- (NSString *) acquireStat: (NSString *) fileName withType: (NSString *) fileType;

@end

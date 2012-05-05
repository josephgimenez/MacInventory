//
//  CredentialsWindowController.m
//  MacInventory
//
//  Created by joseph gimenez on 4/30/12.
//  Copyright (c) 2012 PeopleMatter. All rights reserved.
//

#import "CredentialsWindowController.h"

@interface CredentialsWindowController ()

@end

@implementation CredentialsWindowController
@synthesize userName;
@synthesize passWord;
@synthesize delegate;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)mountShare:(id)sender {
    [[self delegate] writeToBelarc:[userName stringValue] withPass:[passWord stringValue]];
    [self close];
}
@end

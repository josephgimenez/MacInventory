//
//  AppDelegate.m
//  MacInventory
//
//  Created by joseph gimenez on 4/28/12.
//  Copyright (c) 2012 PeopleMatter. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate
@synthesize serialNumber = _serialNumber;
@synthesize model = _model;
@synthesize bank0 = _bank0;
@synthesize bank1 = _bank1;
@synthesize osVersion = _osVersion;
@synthesize disk0 = _disk0;
@synthesize disk1 = _disk1;
@synthesize credentialsController = _credentialsController;
@synthesize data = _data;
@synthesize owner = _owner;
@synthesize userName = _userName;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.window.backgroundColor = [NSColor colorWithSRGBRed:1.0f green:0.75f blue:0.79f alpha:1.0f];
    
    [self.serialNumber setStringValue:[self acquireStat:@"getserial" withType:@"sh"]];
    [self.model setStringValue:[self acquireStat:@"getmodel" withType:@"sh"]];
    
    /*
     * Grab RAM Speed & Size
     */
    
    NSString *bankSize;
    bankSize = [[NSString alloc] initWithString:[self acquireStat:@"banksize" withType:@"sh"]];
    NSArray *bankSizeArray = [bankSize componentsSeparatedByString:@"\n"];
    NSString *bankSpeed;
    bankSpeed = [[NSString alloc] initWithString:[self acquireStat:@"bankspeed" withType:@"sh"]];
    NSArray *bankSpeedArray = [bankSpeed componentsSeparatedByString:@"\n"];
    [self.bank0 setStringValue:[NSString stringWithFormat:@"%@ GB/%@ mhz", [bankSizeArray objectAtIndex:0], [bankSpeedArray objectAtIndex:0]]];
    [self.bank1 setStringValue:[NSString stringWithFormat:@"%@ GB/%@ mhz", [bankSizeArray objectAtIndex:1], [bankSpeedArray objectAtIndex:1]]];
    
    
    /*
     * Grab Operating System
     */
     
    NSString *os = [[NSString alloc] initWithString:[self acquireStat:@"getos" withType:@"sh"]];
    os = [os stringByReplacingOccurrencesOfString:@"System Version: " withString:@""];
    os = [os stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.osVersion setStringValue:os];
    
    /*
     * Grab Disk Size Information
     */
    
    NSString *diskSizeInfo;
    diskSizeInfo = [[NSString alloc] initWithString:[self acquireStat:@"getdisks" withType:@"sh"]];
    diskSizeInfo = [diskSizeInfo stringByReplacingOccurrencesOfString:@"*" withString:@""];
    diskSizeInfo = [diskSizeInfo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Create an array by splitting script by line breaks
    NSArray *disks = [diskSizeInfo componentsSeparatedByString:@"\n"];
    
    [self.disk0 setStringValue:[NSString stringWithFormat:@"%@",[disks objectAtIndex:0]]];
    
    if ([disks count] > 1) {
        [self.disk1 setStringValue:[NSString stringWithFormat:@"%@", [disks objectAtIndex:1]]];
    } else {
        // Second disk not found so set textfield to N/A
        [self.disk1 setStringValue:@"N/A"];
    }
    
    /*
     * Grab Disk Model Information
     */
    
    NSString *diskModelInfo;
    diskModelInfo = [[NSString alloc] initWithString:[self acquireStat:@"drivemodel" withType:@"sh"]];
    NSLog(@"Disk Model: %@", diskModelInfo);
    diskModelInfo = [diskModelInfo stringByReplacingOccurrencesOfString:@"*" withString:@""];
    diskModelInfo = [diskModelInfo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    disks = [diskModelInfo componentsSeparatedByString:@"\n"];
    [self.disk0 setStringValue:[NSString stringWithFormat:@"%@ GB / %@",[self.disk0 stringValue],[disks objectAtIndex:0]]];
    
    if ([disks count] > 1 && [[disks objectAtIndex:1] rangeOfString:@"DVD"].location == NSNotFound) {
        [self.disk1 setStringValue:[NSString stringWithFormat:@"%@ GB / %@", [self.disk1 stringValue], [disks objectAtIndex:1]]];
        
    } else {
        // Second disk not found so set textfield to N/A
        [self.disk1 setStringValue:@"N/A"];
    }

}

- (IBAction)Save:(id)sender {
    
    /* 
     * Ask for Computer Owner's Name
     */
    
    // Create new NSAlert to acquire User's credentials with access to Belarc share
    NSAlert *ownerAlert = [NSAlert alertWithMessageText:@"Whose Mac is this?" defaultButton:@"OK" alternateButton:@"Cancel" otherButton:nil informativeTextWithFormat:@"Please use format: firstname lastname"];
    
    // Create accessory text field and add to NSAlert modal window
    NSTextField *ownerName = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 25)];
    [ownerAlert setAccessoryView:ownerName];
    
    NSInteger buttonSelected = [ownerAlert runModal];
    
    // Did user submit credentials?
    if (buttonSelected == NSAlertDefaultReturn) {
        // User didn't cancel so set inputted value to self.owner string
        [ownerName validateEditing];
        self.owner = [[NSString alloc] initWithString:[ownerName stringValue]];
    } else {
        // User cancelled
        return;
    }
    
    
    /*
     * Get username of account running
     */
    
    self.userName = [[NSString alloc] initWithString:[self acquireStat:@"whoami" withType:@"sh"]];
    self.userName = [self.userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    /*
     * Generate HTML for report and save to Belarc share
     */
    
    self.data = [[NSString alloc]
                      initWithFormat:@"<HTML>\n \
                      \t<HEAD>\n \
                      \t\t<TITLE> Report for %@ </TITLE>\n \
                      \t\t\t<STYLE type=\"text/css\">\n \
                      \t\t\t\tBODY {\n \
                      \t\t\t\t\tfont-family: tahoma;\n \
                      \t\t\t\t\tfont-size: 10pt;\n \
                      \t\t\t\t}\n \
                      \t\t\t</STYLE>\n \
                      \t\t</HEAD>\n \
                      \t<BODY>\n \
                      \t\t<B>Serial Number:</B> %@<BR>\n \
                      \t\t<B>Owner:</B> %@<BR>\n \
                      \t\t<B>Username:</B> %@<BR>\n \
                      \t\t<B>Model:</B> %@<BR>\n \
                      \t\t<B>Operating System:</B> %@<BR>\n \
                      \t\t<B>RAM Bank 0:</B> %@<BR>\n \
                      \t\t<B>RAM Bank 1:</B> %@<BR>\n \
                      \t\t<B>Disk 0:</B> %@<BR>\n \
                      \t\t<B>Disk 1:</B> %@<BR>\n \
                      \t</BODY>\n \
                      </HTML> \
                      ",
                      
                      self.owner, [self.serialNumber stringValue], self.owner, self.userName,
                      [self.model stringValue], [self.osVersion stringValue],
                      [self.bank0 stringValue], [self.bank1 stringValue],
                      [self.disk0 stringValue], [self.disk1 stringValue]];
    
    
    // Create Credentials Window
    self.credentialsController = [[CredentialsWindowController alloc]
                             initWithWindowNibName:@"CredentialsWindowController"];
    
    // Set our delegate "writeToBelarc" to this class
    [self.credentialsController setDelegate:self];
    
    
    // Show window
    [self.credentialsController showWindow:self];
    
    
    
}

- (NSString *) writeToBelarc:(NSString *)userName withPass:(NSString *)passWord
{
    // Run script to mount samba share (Belarc) and write report to share
    NSTask *mountShare;
    mountShare = [[NSTask alloc] init];
    [mountShare setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments;
    NSString *newPath = [[NSBundle mainBundle] pathForResource:@"mountshare" ofType:@"sh"];
    NSLog(@"shell script path: %@", newPath);
    arguments = [NSArray arrayWithObjects:newPath, userName, passWord, nil];
    [mountShare setArguments:arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [mountShare setStandardOutput:pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [mountShare launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *stat;
    stat = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self.data writeToFile:[NSString stringWithFormat:@"/Users/%@/smbshare/%@.html", self.userName, self.owner] atomically:YES encoding:NSUTF8StringEncoding error:nil];

    return stat;

}

- (NSString *) acquireStat:(NSString *)fileName withType:(NSString *)fileType
{
    // Run specified script "fileName + fileType" and return script return value as NSString
    NSTask *runMacSpecScript;
    runMacSpecScript = [[NSTask alloc] init];
    [runMacSpecScript setLaunchPath: @"/bin/sh"];
    
    // Specify script path as argument to /bin/sh interpreter
    NSArray *arguments;
    NSString *newPath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    NSLog(@"shell script path: %@", newPath);
    arguments = [NSArray arrayWithObjects:newPath, nil];
    [runMacSpecScript setArguments:arguments];
    
    // Set pipe to collect return value of script
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [runMacSpecScript setStandardOutput:pipe];
    
    // Point file handle to pipe buffer
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [runMacSpecScript launch];
    
    // Read data from buffer using file handle
    NSData *data;
    data = [file readDataToEndOfFile];
    
    // Collect data (output from script) and return as NSString
    NSString *stat;
    stat = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return stat;
    
}

@end

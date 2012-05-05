//
//  CredentialsWindowController.h
//  MacInventory
//
//  Created by joseph gimenez on 4/30/12.
//  Copyright (c) 2012 PeopleMatter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol WriteToShareDrive <NSObject>
@required
- (void) writeToBelarc:(NSString *) userName withPass: (NSString*) passWord;
@end


@interface CredentialsWindowController : NSWindowController
{
    id <WriteToShareDrive> delegate;
}
@property (strong) id delegate;
@property (unsafe_unretained) IBOutlet NSTextField *userName;
@property (unsafe_unretained) IBOutlet NSTextField *passWord;
- (IBAction)mountShare:(id)sender;


@end

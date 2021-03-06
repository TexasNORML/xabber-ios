//
//  XBContactsViewController.m
//  xabber
//
//  Created by Dmitry Sobolev on 16/09/14.
//  Copyright (c) 2014 Redsolution LLC. All rights reserved.
//

#import "XBContactsViewController.h"
#import "XBContactListController.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XBXMPPConnector.h"
#import "XBContact.h"
#import "XBContactViewCell.h"
#import "XBChatViewController.h"

@interface XBContactsViewController () <XBContactListControllerDelegate> {
    XBContactListController *contactListController;
}
@end

@implementation XBContactsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.contactListController.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.contactListController numberOfContactsInSection:(NSUInteger) section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.contactListController titleOfSectionAtIndex:(NSUInteger) section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XBContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    XBContact *contact = [self.contactListController contactAtIndexPath:indexPath];

    [cell fillCellWithObject:contact];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChat"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

        XBContact *contact = [self.contactListController contactAtIndexPath:indexPath];

        XBChatViewController *chatViewController = segue.destinationViewController;

        chatViewController.contact = contact;
    }
}

#pragma mark Private

- (XBContactListController *)contactListController {
    if (!contactListController) {
        contactListController = [XBContactListController controllerWithStorage:[XMPPRosterCoreDataStorage sharedInstance]];
        contactListController.delegate = self;
    }

    return contactListController;
}

//- (void)controllerWillChangeContent:(XBContactListController *)controller {
//    [self.tableView beginUpdates];
//}

- (void)controllerDidChangeContent:(XBContactListController *)controller {
    [self.tableView reloadData];
}


@end

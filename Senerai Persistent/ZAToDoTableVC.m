//
//  ZAToDoTableVC.m
//  Senerai Persistent
//
//  Created by Ezekiel Abuhoff on 3/6/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "ZAToDoTableVC.h"
#import "ZADataStore.h"
#import "ToDo.h"
#import "Tag.h"
#import "ZAViewToDoVC.h"

@interface ZAToDoTableVC ()

@property ZADataStore *myData;

@end

@implementation ZAToDoTableVC

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
    
    self.myData = [ZADataStore sharedDataStore];
    
    Tag *business = [self.myData createTagWithName:@"Business"];
    Tag *pleasure = [self.myData createTagWithName:@"Pleasure"];
    ToDo *sortFiles = [self.myData createToDoWithName:@"Sort files"];
    ToDo *dance = [self.myData createToDoWithName:@"Dance dance dance"];
    [self.myData addTag:business toToDo:sortFiles];
    [self.myData addTag:pleasure toToDo:dance];
    
    [self.myData fetchData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.myData fetchData];
    [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.myData.toDos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"toDoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ToDo *thisToDo = self.myData.toDos[indexPath.row];
    cell.textLabel.text = thisToDo.name;
    cell.detailTextLabel.text = thisToDo.tag.name;
    
    // Configure the cell...
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"viewToDo"])
    {
        ZAViewToDoVC *nextVC = segue.destinationViewController;
        NSIndexPath *ip = self.tableView.indexPathForSelectedRow;
        nextVC.myToDo = self.myData.toDos[ip.row];
    }
}

- (IBAction)sortButton:(id)sender
{
    UIActionSheet *sortSheet = [[UIActionSheet alloc] initWithTitle:@"Sort" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"By Name", @"By Tag", nil];
    
    [sortSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.myData sortToDosByName];
        [self.tableView reloadData];
    } else if (buttonIndex == 1)
    {
        [self.myData sortToDosByTag];
        [self.tableView reloadData];
    }
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

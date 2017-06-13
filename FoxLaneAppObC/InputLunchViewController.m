//
//  ViewController.m
//  TableViewTry2
//
//  Created by Brian Poor on 1/3/17.
//  Copyright © 2017 Brian Poor. All rights reserved.
//

#import "InputLunchViewController.h"
#import "DayViewController.h"
#include <Parse/Parse.h>

@interface InputLunchViewController (){
    NSArray* tableData;
    NSMutableArray* lunchData;
}

@end

@implementation InputLunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        tableData =@[@"Day A",@"Day B",@"Day C",@"Day D",@"Day E",@"Day 1",@"Day 2",@"Day 3",@"Day 4",@"Day 5"];
    lunchData = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 9; i++)
    {
        [lunchData addObject:@"Middle"];
        NSLog(@"%@",lunchData[i]);
    }
    [self parseSetLunch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*NSString * simpleIdentifier = @"simpleIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    if (cell == nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIdentifier];
    }
    cell.textLabel.text = tableData[indexPath.row];
    
    return cell;*/
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [lunchData objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"HELP");
    /*UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];*/
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[tableData objectAtIndex:indexPath.row]
                                                                   message:@"Select Lunch Time"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIAlertAction* earlyAction = [UIAlertAction actionWithTitle:@"Early" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {[lunchData replaceObjectAtIndex:indexPath.row withObject:@"Early"]; cell.detailTextLabel.text = lunchData[indexPath.row ];}];
    UIAlertAction* middleAction = [UIAlertAction actionWithTitle:@"Middle" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {[lunchData replaceObjectAtIndex:indexPath.row withObject:@"Middle"]; cell.detailTextLabel.text = lunchData[indexPath.row];}];
    UIAlertAction* lateAction = [UIAlertAction actionWithTitle:@"Late" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {[lunchData replaceObjectAtIndex:indexPath.row withObject:@"Late"]; cell.detailTextLabel.text = lunchData[indexPath.row];}];
    
    [alert addAction:earlyAction];
    [alert addAction:middleAction];
    [alert addAction:lateAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void) pushParse{
    PFQuery *query = [PFQuery queryWithClassName:@"ScheduleBrian"];
    PFQuery *lunchQuery = [query whereKeyExists:@"lunchData"];
    NSArray *results = [lunchQuery findObjects];
    if ([results count] == 0){
        PFObject *mySchedule = [PFObject objectWithClassName:@"ScheduleBrian"];
        mySchedule[@"lunchData"] = [lunchData componentsJoinedByString:@",::"];
        [mySchedule saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
                NSLog(@"YAY YAY YAY");
            } else {
                // There was a problem, check error.description
                NSLog(@"NO NO NO");
            }
        }];
    } else{
        PFObject *mySchedule = results[0];
        mySchedule[@"lunchData"] = [lunchData componentsJoinedByString:@",::"];
        [mySchedule save];
    }
}

- (void) parseSetLunch{
    PFQuery *query = [PFQuery queryWithClassName:@"ScheduleBrian"];
    //PFObject *mySchedule = [query getObjectWithId:@"B4NArQDLyh"];
    //NSString *lunchString = mySchedule[@"lunchData"];
    query = [query whereKeyExists:@"lunchData"];
    NSArray *results = [query findObjects];
    
    if ([results count] == 0)
        return;
    
    PFObject *mySchedule = results[0];
    NSString *lunchString = mySchedule[@"lunchData"];
    NSLog(@"ALL I WANT FOR CHRISDFKDSFLJ %@", lunchString);
    lunchData = [[NSMutableArray alloc] init];
    [lunchData addObjectsFromArray:[lunchString componentsSeparatedByString:@",::"]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"lunchDataSegue"]) {
        DayViewController * destinationVC = segue.destinationViewController;
        LunchConnector *connectorClass = [[LunchConnector alloc] init];
        connectorClass.lunchArrayBeingPassed = lunchData;
        destinationVC.connectorClass = connectorClass;
    }
}
- (IBAction)doneButtonClick:(id)sender {
    [self pushParse];
    [self performSegueWithIdentifier:@"lunchDataSegue" sender:self];
}


@end

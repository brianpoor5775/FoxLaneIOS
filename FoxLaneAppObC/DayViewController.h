//
//  DayViewController.h
//  TableViewTry2
//
//  Created by Brian Poor on 1/5/17.
//  Copyright © 2017 Brian Poor. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "LunchConnector.h"

@interface DayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

}
@property (weak, nonatomic) IBOutlet UITableView *scheduleTableView;
@property (weak, nonatomic) IBOutlet UIButton *dayButton;
@property (strong, nonatomic) NSMutableArray * lunchData;
@property (strong, nonatomic) NSMutableArray * courseData;
@property (weak, nonatomic) NSMutableArray * scheduleData;

@property (strong, nonatomic) LunchConnector *connectorClass;


@end

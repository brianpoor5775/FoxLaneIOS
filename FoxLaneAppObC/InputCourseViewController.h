//
//  InputCourseViewController.h
//  TableViewTry2
//
//  Created by Brian Poor on 1/4/17.
//  Copyright © 2017 Brian Poor. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "LunchConnector.h"

@interface InputCourseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
}
@property (weak, nonatomic) IBOutlet UITextField *courseTextField;
@property (weak, nonatomic) IBOutlet UITableView *courseTableView;
@property (strong, nonatomic) LunchConnector *connectorClass;



@end

//
//  EventDetailsViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "EventDetailsViewController.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Event Details";
    
    //Set the view text to variables here
    self.eventDescriptionLabel.text = [self eventDescriptionText];
    self.eventTitleLabel.text = [self eventTitleText];
    self.publisherLabel.text = [self publisherText];
    self.buildingLabel.text = [self eventBuildingText];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

- (IBAction)mainMapButton:(id)sender {
        NSLog(@"Home button pressed");
        /*
        ViewController *mmVC
        = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMapView"];
         [self.navigationController pushViewController:mmVC animated:YES];
         */
        
        //Goes back to the main map view controller
        [self.navigationController popToRootViewControllerAnimated:NO];
}
@end
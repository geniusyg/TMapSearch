//
//  ViewController.m
//  TMapSearch
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"

@interface ViewController () <UISearchBarDelegate, TMapViewDelegate>

@property TMapView *mapView;

@end

@implementation ViewController

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
	[_mapView clearCustomObjects];
	
	NSString *keyword = searchBar.text;
	TMapPathData *path = [[TMapPathData alloc] init];
	NSArray *result = [path requestFindTitlePOI:keyword];
	
	NSLog(@"number : %d", result.count);
	
	int i=0;
	
	for(TMapPOIItem *item in result) {
		NSLog(@"Name %@ - Point %@", [item getPOIName], [item getPOIPoint]);
		
		NSString *markerID = [NSString stringWithFormat:@"marker_%d", i++];
		TMapMarkerItem *marker = [[TMapMarkerItem alloc] init];
		[marker setTMapPoint:[item getPOIPoint]];
		[marker setIcon:[UIImage imageNamed:@"point.png"]];
		
		[marker setCanShowCallout:YES];
		[marker setCalloutTitle:[item getPOIName]];
		[marker setCalloutSubtitle:[item getPOIAddress]];
		
		[_mapView addCustomObject:marker ID:markerID];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	CGRect rect = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44);
	
	_mapView = [[TMapView alloc] initWithFrame:rect];
	[_mapView setSKPMapApiKey:@"86a2bcf5-5df8-3727-a7b2-55957bfda634"];
	
	_mapView.delegate = self;
	
	[self.view addSubview:_mapView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end























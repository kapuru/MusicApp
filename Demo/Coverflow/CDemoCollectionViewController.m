//
//	CDemoCollectionViewController.m
//	Coverflow
//
//	Created by Jonathan Wight on 9/24/12.
//	Copyright 2012 Jonathan Wight. All rights reserved.
//
//	Redistribution and use in source and binary forms, with or without modification, are
//	permitted provided that the following conditions are met:
//
//	   1. Redistributions of source code must retain the above copyright notice, this list of
//		  conditions and the following disclaimer.
//
//	   2. Redistributions in binary form must reproduce the above copyright notice, this list
//		  of conditions and the following disclaimer in the documentation and/or other materials
//		  provided with the distribution.
//
//	THIS SOFTWARE IS PROVIDED BY JONATHAN WIGHT ``AS IS'' AND ANY EXPRESS OR IMPLIED
//	WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//	FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL JONATHAN WIGHT OR
//	CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//	ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//	NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//	ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//	The views and conclusions contained in the software and documentation are those of the
//	authors and should not be interpreted as representing official policies, either expressed
//	or implied, of Jonathan Wight.

#import "CDemoCollectionViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "CDemoCollectionViewCell.h"
#import "CCoverflowTitleView.h"
#import "CCoverflowCollectionViewLayout.h"
#import "CReflectionView.h"
#import "xmlParsingClass.h"
#import "SingleTon.h"
#import "Reachability.h"

@interface CDemoCollectionViewController ()
@property (readwrite, nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (readwrite, nonatomic, assign) NSInteger cellCount;
@property (readwrite, nonatomic, strong) NSArray *assets;
@property (readwrite, nonatomic, strong) CCoverflowTitleView *titleView;
@property (readwrite, nonatomic, strong) NSCache *imageCache;
@property (readwrite, nonatomic, strong) NSArray *songNames;
@property (readwrite, nonatomic, strong) SingleTon *theSingleTon;
@property (readwrite, nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation CDemoCollectionViewController

- (void)viewDidLoad{
    
    
	[super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CCoverflowTitleView class]) bundle:NULL] forSupplementaryViewOfKind:@"title" withReuseIdentifier:@"title"];
    
    
    self.imageArray = [[NSMutableArray alloc]init];
    self.theSingleTon = [SingleTon manager];
    
    dispatch_async(dispatch_queue_create("Dispatch For Parsing", NULL), ^{
        self.activityLoadingIndicator.frame = CGRectMake(120, 100, 80, 80);
        [self.activityLoadingIndicator startAnimating];
        [self.view addSubview:self.activityLoadingIndicator];
        
        xmlParsingClass *xmlPar = [[xmlParsingClass alloc]init];
        [xmlPar executeXML];
        self.songNames = xmlPar.songsForXML;
        self.assets = xmlPar.pictureLinks;
        
        for (NSString *element in self.assets){
            NSURL *theURL = [NSURL URLWithString:element];
            NSData *imageData = [[NSData alloc]initWithContentsOfURL:theURL];
            UIImage *theImage = [UIImage imageWithData:imageData];
            [self.imageArray addObject:theImage];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationItem.rightBarButtonItem = NULL;
        [self.collectionView reloadData];
        [self.activityLoadingIndicator stopAnimating];
        [self.activityLoadingIndicator setHidden:YES];
        });
    });
}


-(void)viewDidAppear:(BOOL)animated{
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        [self performSelectorOnMainThread:@selector(updateFunctionON) withObject:nil waitUntilDone:NO];
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        [self performSelectorOnMainThread:@selector(updateFunctionOFF) withObject:nil waitUntilDone:NO];
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}

-(void)updateFunctionON{
    self.navigationItem.rightBarButtonItem = NULL;
}
-(void)updateFunctionOFF{
    //[self.switchForInternet setOn:NO];
    
    UIBarButtonItem *go = [[UIBarButtonItem alloc] initWithTitle:@"Offline" style:UIBarButtonItemStylePlain target:self action:@selector(toolbarItemTapped:)];
    
    self.navigationItem.rightBarButtonItem = go;
    self.assets = [[NSArray alloc]init];
    self.songNames = [[NSArray alloc]init];
    self.songNames = NULL;
    self.assets = NULL;
	[self.collectionView reloadData];
}

-(void)toolbarItemTapped: (id) sender{
    
}


#pragma mark -

- (void)updateTitle
	{
// Asking a collection view for indexPathForItem inside a scrollViewDidScroll: callback seems unreliable.
//	NSIndexPath *theIndexPath = [self.collectionView indexPathForItemAtPoint:(CGPoint){ CGRectGetMidX(self.collectionView.frame) + self.collectionView.contentOffset.x, CGRectGetMidY(self.collectionView.frame) }];
     

    
	NSIndexPath *theIndexPath = ((CCoverflowCollectionViewLayout *)self.collectionView.collectionViewLayout).currentIndexPath;
	if (theIndexPath == NULL)
		{
		self.titleView.titleLabel.text = NULL;
		}
	else 
		{
            self.titleView.titleLabel.text = [self.songNames objectAtIndex:theIndexPath.row];
		}
     
	}

#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
	{
	return(self.imageArray.count);
	}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
	{
	CDemoCollectionViewCell *theCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"DEMO_CELL" forIndexPath:indexPath];

	if (theCell.gestureRecognizers.count == 0)
		{
		[theCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)]];
		}

	theCell.backgroundColor = [UIColor colorWithHue:(float)indexPath.row / (float)self.cellCount saturation:0.333 brightness:1.0 alpha:1.0];

        /*
		NSURL *theURL = [NSURL URLWithString:[self.assets objectAtIndex:indexPath.row]];
        NSData *imageData = [[NSData alloc]initWithContentsOfURL:theURL];
        UIImage *theImage = [UIImage imageWithData:imageData];
            
		if (theImage == NULL)
			{
			theImage = [UIImage imageWithContentsOfFile:theURL.path];
			[self.imageCache setObject:theImage forKey:theURL];
			}
         */
		theCell.imageView.image = [self.imageArray objectAtIndex:indexPath.row];
		theCell.reflectionImageView.image = [self.imageArray objectAtIndex:indexPath.row];
		theCell.backgroundColor = [UIColor clearColor];

        
	return(theCell);
	}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
	{
	CCoverflowTitleView *theView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"title" forIndexPath:indexPath];
	self.titleView = theView;
	[self updateTitle];
	return(theView);
	}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
	{
	[self updateTitle];
	}

#pragma mark -

- (void)tapCell:(UITapGestureRecognizer *)inGestureRecognizer
	{
        
        NSIndexPath *theIndexPath = [self.collectionView indexPathForCell:(UICollectionViewCell *)inGestureRecognizer.view];
        
        //NSLog(@"%@", [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:theIndexPath]);
        self.theSingleTon.selectedSongIndex = theIndexPath.row;
        self.theSingleTon.songString = [self.songNames objectAtIndex:theIndexPath.row];
        self.theSingleTon.pictureURL = [self.assets objectAtIndex:theIndexPath.row];
        [self.navigationController.viewControllers[0] performSegueWithIdentifier:@"segwayForOptionsVC" sender:self];
	}

@end

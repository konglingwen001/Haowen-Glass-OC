//
//  GuideViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/9/17.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

int numOfPage = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = self.view.bounds;

    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(frame.size.width * numOfPage, frame.size.height);
    
    scrollView.pagingEnabled = true;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.scrollsToTop = false;
    
    for (int i = 0; i < numOfPage; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.png", i]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height);
        [scrollView addSubview:imageView];
        
    }
    scrollView.contentOffset = CGPointZero;
    [self.view addSubview:scrollView];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int twidth = (numOfPage - 1) * self.view.bounds.size.width;
    if (scrollView.contentOffset.x > twidth) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [main instantiateInitialViewController];
        [self presentViewController:viewController animated:true completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

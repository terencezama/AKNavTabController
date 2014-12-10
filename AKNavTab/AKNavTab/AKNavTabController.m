//
//  AKNavTabController.m
//  AKNavTab
//
//  Created by Terence Adrien Zama on 11/12/14.
//  Copyright (c) 2014 Terence Adrien Zama. All rights reserved.
//

#import "AKNavTabController.h"
#pragma mark - AKDependencies
#import "UIView+AKUtils.h"
#import "UIViewController+AKUtils.h"
#pragma mark - Contants properties
static const CGFloat tabHeight = 90.0;
static const CGFloat lineHeight = 2.0;
static const CGFloat buttonHeight = 30.0;
#pragma mark - AKNavColor
@interface AKNavColor : UIColor
+(UIColor *)backgroundColor;
+(UIColor *)lineColor;
+(UIColor *)selectionColor;
@end
@implementation AKNavColor

+(UIColor *)backgroundColor{
    return [UIColor colorWithRed:44.0/255.0 green:62.0/255.0 blue:80.0/255.0 alpha:1.0];
}
+(UIColor *)lineColor{
    return [UIColor colorWithRed:225.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];
}
+(UIColor *)selectionColor{
    return [UIColor colorWithRed:225.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];
}
@end
#pragma mark - AKNavButton
@interface AKNavButton : UIButton
@property (nonatomic,assign) NSInteger index;
@end
@implementation AKNavButton

@end
#pragma mark - AKNavTabView
@protocol AKNavTabViewDelegate <NSObject>
@required
-(void) navButtonClicked:(AKNavButton *)navButton;

@end

@interface AKNavTabView : UIView
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,weak) id <AKNavTabViewDelegate> delegate;
@end
@implementation AKNavTabView{
    UIScrollView *_scrollView;
    UIView *_selectionLine;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[AKNavColor backgroundColor];
        _scrollView=[[UIScrollView alloc] initWithFrame:self.bounds];
        //_scrollView.pagingEnabled=YES;
        [self addSubview:_scrollView];
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
        CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [AKNavColor lineColor].CGColor);
    CGContextFillRect(context, CGRectMake(0,CGRectGetHeight(self.frame)-lineHeight , CGRectGetWidth(self.frame), lineHeight));
}
-(void)addSubview:(UIView *)view{
    if (view==_scrollView) {
        [super addSubview:view];
    }else{
        //Incremental addsubview for scrollview
    }
}
-(void) setTitles:(NSArray *)titles{
    _titles=titles;
    
    //Remove all existing buttons
    for (UIView *subview in _scrollView.subviews) {
        if ([subview isKindOfClass:[AKNavButton class]]) {
            [subview removeFromSuperview];
        }
    }
    
    //Adding selection line
    if (!_selectionLine) {
        _selectionLine=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-2*lineHeight, 10, lineHeight)];
        [_selectionLine setBackgroundColor:[AKNavColor selectionColor]];
        [_scrollView addSubview:_selectionLine];
    }
    
    //Cases :
    // 3 tabs on one nav
    
    NSInteger titlesCount = _titles.count;
    CGFloat _width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat _buttonWidth = _width/3.0;
    
    CGFloat _pointer =0.0;
    if (titlesCount==1) {
        _buttonWidth = _width;
    }else if (titlesCount==2){
        _buttonWidth = _width/2.0;
    }
    
    _selectionLine.width=_buttonWidth;
    NSInteger _index = 0;
    for (NSString *title in _titles) {
        AKNavButton *button = [AKNavButton buttonWithType:UIButtonTypeCustom];
        button.index=_index;
        CGRect frame = button.frame;
        frame.size.height=buttonHeight;
        frame.size.width=_buttonWidth;
        button.frame=frame;
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(navButtonAction:) forControlEvents:UIControlEventTouchDown];
        [button setShowsTouchWhenHighlighted:YES];
        button.minX=_pointer;
        button.maxY=CGRectGetHeight(self.frame);
        [_scrollView addSubview:button];
        _pointer=button.maxX;
        
        _index ++;
    }
    
    [_scrollView setContentSize:CGSizeMake(_pointer, buttonHeight)];

}

-(void) navButtonAction:(AKNavButton *)navButton{
    [UIView animateWithDuration:0.1 animations:^{
        [_selectionLine setMinX:navButton.minX];
        [_selectionLine setWidth:navButton.width];
    }];
    
    CGFloat _offset = navButton.minX-navButton.width;
    if (_offset<0) {
        _offset=0;
    }else if (_offset>_scrollView.contentSize.width-_scrollView.width){
        _offset = _scrollView.contentOffset.x;
    }
    [_scrollView setContentOffset:CGPointMake(_offset, 0) animated:YES];
    
    
    !(_delegate && [_delegate respondsToSelector:@selector(navButtonClicked:)])?:[_delegate navButtonClicked:navButton];
}
@end
#pragma mark - AKNavTabController
@interface AKNavTabController ()<AKNavTabViewDelegate>

@end

@implementation AKNavTabController{
    AKNavTabView *_tabView;
    
    NSMutableArray *_viewControllers;
    
    UIViewController *_currentChild;
    BOOL _transitioning;
}
#pragma mark  AKNavTabViewDelegate
-(void) navButtonClicked:(AKNavButton *)navButton{
    UIViewController *nextVc = _viewControllers[navButton.index];
    
    if (nextVc==_currentChild || _transitioning) {
        return;
    }
    
    _transitioning = YES;
    // Containment
    [self addChildViewController:nextVc];
    [_currentChild willMoveToParentViewController:nil];
    

    //Index of current
    CGFloat _width = CGRectGetWidth(self.view.bounds);
    NSInteger currentIndex = [_viewControllers indexOfObject:_currentChild];
    if (currentIndex<navButton.index) {
        nextVc.view.minX=_width;
    }else{
        nextVc.view.minX=-_width;
    }
    
    [self transitionFromViewController:_currentChild toViewController:nextVc duration:0.3 options:0 animations:^{
        // Do any fancy animation you like
        if (currentIndex<navButton.index) {
            _currentChild.view.minX=-_width;
        }else{
            _currentChild.view.minX=_width;
            
        }
        nextVc.view.minX=0;
        
    } completion:^(BOOL finished) {
        [nextVc didMoveToParentViewController:self];
        [_currentChild removeFromParentViewController];
        _currentChild = nextVc;
        _transitioning = NO;
    }];
    [self.view insertSubview:nextVc.view belowSubview:_tabView];
}
#pragma mark Titles & Vc setter
-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    // #1 Fill tabView
    [_tabView setTitles:_titles];
}
-(void)setViewControllersId:(NSArray *)viewControllersId{
    _viewControllersId = viewControllersId;
    
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc] initWithCapacity:_viewControllersId.count];
    }else{
        [_viewControllers removeAllObjects];
    }
    
    
    for (NSString *vcId in _viewControllersId) {
        [_viewControllers addObject:[self vcWithStoryboardId:vcId]];
    }
    
    // #2 Set Root Vc
    //Initial viewcontroller
    [_currentChild willMoveToParentViewController:nil];
    UIViewController *vc = _viewControllers[0];
    [self addChildViewController:vc];
    [self.view insertSubview:vc.view belowSubview:_tabView];
    [vc didMoveToParentViewController:self];
    _currentChild=vc;
}
#pragma mark  Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    //#Core properties ```
    CGFloat _width = CGRectGetWidth([ UIScreen mainScreen].bounds);
    _tabView=[[AKNavTabView alloc] initWithFrame:CGRectMake(0, 0, _width, tabHeight)];
    _tabView.delegate=self;
    [self.view addSubview:_tabView];
    

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

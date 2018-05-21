//
//  DDPhotoBrowser.m
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import "DDPhotoBrowser.h"
#import "DDPhotoBrowserCollectionViewCell.h"


#define kDDPhotoBrowserWidth ([UIScreen mainScreen].bounds.size.width + 10.0f)


@interface DDPhotoBrowser ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UITapGestureRecognizer *singleTapGestureRecognizer;
    UIPanGestureRecognizer * panGesture;
}
/**图片边距*/
@property (nonatomic,assign) CGFloat kDDPhotoImageViewPadding;
@property(nonatomic,assign) BOOL statusBarHidden;
/**背景*/
@property (nonatomic,strong) UIView *backgroundView;
/**collectionView*/
@property (nonatomic,strong) UICollectionView * collectionView;
/**DDPhotoItem 数组*/
@property (nonatomic,strong) NSMutableArray *photoItems;
@property (nonatomic,assign) NSUInteger currentPage;
@property (nonatomic,strong) id<DDPhotoImageDownloadEngine> imageDownloadEngine;
@property (nonatomic,copy)   DDPhotoBrowserChangeToIndexBlock photoBrowserBlock;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,strong) UILabel *pageLabel;

@end

@implementation DDPhotoBrowser
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
- (instancetype)init {
    NSAssert(NO, @"Use photoBrowserWithPhotoItems: instead.");
    return nil;
}
+ (instancetype)photoBrowserWithPhotoItems:(NSArray<DDPhotoItem *> *)photoItems currentIndex:(NSUInteger)currentIndex
{
    DDPhotoBrowser * bVC = [[DDPhotoBrowser alloc] initWithPhotoItems:photoItems currentIndex:currentIndex];
    bVC.imageDownloadEngine = [[DDPhotoSDImageDownloadEngine alloc]init];
    return bVC;
}
+ (instancetype)photoBrowserWithPhotoItems:(NSArray<DDPhotoItem *> *)photoItems
                              currentIndex:(NSUInteger)currentIndex
                              imageDownloadEngine:(id<DDPhotoImageDownloadEngine>)imageDownloadEngine
{
    DDPhotoBrowser * bVC = [[DDPhotoBrowser alloc] initWithPhotoItems:photoItems currentIndex:currentIndex];
    bVC.imageDownloadEngine = imageDownloadEngine;
    return bVC;
}
- (instancetype)initWithPhotoItems:(NSArray<DDPhotoItem *> *)photoItems currentIndex:(NSUInteger)currentIndex
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.photoItems = [NSMutableArray arrayWithArray:photoItems];
        self.currentPage = currentIndex;
        self.backgroundStyle = DDPhotoBrowserBackgroundStyleBlurDark;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self __setupPageIndicateStyleUI];
    [self __hideOrShowPageIndicateHandle:1];
    [UIView animateWithDuration:kDDPhotoBrowserAnimationTime animations:^{
        self.backgroundView.alpha = 1.0;
    }];
}

- (void)photoBrowserClickedBlock:(DDPhotoBrowserChangeToIndexBlock)block
{
    self.photoBrowserBlock = block;
}
/**弹出*/
- (void)showFromVC:(UIViewController *)vc
{
    [vc presentViewController:self animated:NO completion:^{
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.contentOffset = CGPointMake(self.currentPage*kDDPhotoBrowserWidth, 0);
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDidHandle:)];
    [self.view addGestureRecognizer:panGesture];
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneHandler)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    
    self.statusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    
}
- (void)oneHandler
{
    [self.view removeGestureRecognizer:singleTapGestureRecognizer];
    [self dismissSelf];
}
/**手势拖拽*/
- (void)panGestureDidHandle:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.view];
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.currentPage inSection:0];
    [self __hideOrShowPageIndicateHandle:0];
    DDPhotoBrowserCollectionViewCell * cell = (DDPhotoBrowserCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell.imageView cancelImageRequest];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            DDPhotoItem * item = self.photoItems[self.currentPage];
            item.sourceView.hidden = YES;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            double percent = 1 - fabs(point.y)/(self.view.frame.size.height/2);
            percent = MAX(percent, 0);
            double s = MAX(percent, 0.5);
            CGAffineTransform translation = CGAffineTransformMakeTranslation(point.x/s, point.y/s);
            CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
            cell.imageView.imageView.transform = CGAffineTransformConcat(translation, scale);
            self.backgroundView.alpha = percent;
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            double percent = 1 - fabs(point.y)/(self.view.frame.size.height/2);
            percent = MAX(percent, 0);
            if (percent < 0.5) {/**消失*/
                [self dismissSelf];
            } else {
                [self cancelPanHandle];/**取消手势并在当前控制器*/
            }
        }
            break;
        default:
            break;
    }

}

/**退出消失*/
- (void)dismissSelf
{
    [self.view removeGestureRecognizer:panGesture];
    [self.view removeGestureRecognizer:singleTapGestureRecognizer];
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.currentPage inSection:0];
    DDPhotoBrowserCollectionViewCell * cell = (DDPhotoBrowserCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    DDPhotoItem * item = self.photoItems[self.currentPage];
    
    item.sourceView.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:self.statusBarHidden withAnimation:UIStatusBarAnimationFade];
    [UIView animateWithDuration:0.33 animations:^{
        cell.imageView.imageView.frame = item.sourceViewInWindowRect;
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        item.sourceView.hidden = NO;
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
/**取消拖动*/
- (void)cancelPanHandle
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.currentPage inSection:0];
    DDPhotoBrowserCollectionViewCell * cell = (DDPhotoBrowserCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    DDPhotoItem * item = self.photoItems[self.currentPage];
    item.sourceView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        cell.imageView.imageView.transform = CGAffineTransformIdentity;
        self.backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            item.sourceView.hidden = NO;
            cell.item = item;
        }
    }];
    [self __hideOrShowPageIndicateHandle:1];
}

#pragma mark -<UICollectionViewDataSource>
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDPhotoBrowserCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDPhotoBrowserCollectionViewCell" forIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    DDPhotoBrowserCollectionViewCell * photoCell = (DDPhotoBrowserCollectionViewCell *)cell;
    photoCell.imageViewEngineType = self.imageViewEngineType;
    photoCell.imageDownloadEngine = self.imageDownloadEngine;
    photoCell.item = self.photoItems[indexPath.row];
//    photoCell.imageView.panGesture = panGesture;
    [singleTapGestureRecognizer  requireGestureRecognizerToFail:photoCell.imageView.doubleGestureRecognizer];
}
/**监听滑动*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        NSInteger pageIndex =  (NSInteger)scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
        self.currentPage = pageIndex;
        DDPhotoItem * item = self.photoItems[self.currentPage];
        if (self.photoBrowserBlock) {
            self.photoBrowserBlock(self.currentPage, item);
        }
        [self __setupPageIndicateStyleUI];
    }
}
/**布局pageIndicate*/
- (void)__setupPageIndicateStyleUI
{
    if (self.pageIndicateStyle == DDPhotoBrowserPageIndicateStylePageLabel) {
        self.pageLabel.text = [NSString stringWithFormat:@"%ld  /  %ld",self.currentPage+1,self.photoItems.count];
    } else if (self.pageIndicateStyle == DDPhotoBrowserPageIndicateStylePageControl) {
        self.pageControl.hidden = NO;
        self.pageControl.currentPage = self.currentPage;
    }
}
/**隐藏或显示pageIndicate*/
- (void)__hideOrShowPageIndicateHandle:(CGFloat)alpha
{
    if (self.photoItems.count == 1) {
        self.pageControl.hidden = YES;
        self.pageLabel.hidden = YES;
        return;
    }
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:kDDPhotoBrowserAnimationTime delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
        __strong typeof(wself) sself = wself;
        if (self.pageIndicateStyle == DDPhotoBrowserPageIndicateStylePageLabel) {
            sself.pageLabel.alpha = alpha;
        } else if (self.pageIndicateStyle == DDPhotoBrowserPageIndicateStylePageControl) {
            sself.pageControl.alpha = alpha;
        }
    }completion:^(BOOL finish) {
    }];
}
#pragma mark - set方法
/**设置背景*/
- (void)setBackgroundStyle:(DDPhotoBrowserBackgroundStyle)backgroundStyle
{
    if (_backgroundStyle == backgroundStyle) {
        return;
    }
    _backgroundStyle = backgroundStyle;
    if (_backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
    }
    if (backgroundStyle == DDPhotoBrowserBackgroundStyleBlack) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
    } else {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:(UIBlurEffectStyle)backgroundStyle];
        UIVisualEffectView * effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = [UIScreen mainScreen].bounds;
        _backgroundView = effectview;
    }
    _backgroundView.alpha = 0.0;
    [self.view addSubview:self.backgroundView];
    [self.view sendSubviewToBack:self.backgroundView];
}
- (void)setPageIndicateStyle:(DDPhotoBrowserPageIndicateStyle)pageIndicateStyle
{
    if (pageIndicateStyle == _pageIndicateStyle) {
        return;
    }
    _pageIndicateStyle = pageIndicateStyle;
    if (_pageIndicateStyle == DDPhotoBrowserPageIndicateStylePageLabel) {
        [self.pageControl removeFromSuperview];
        [self.view addSubview:self.pageLabel];
    } else if (_pageIndicateStyle == DDPhotoBrowserPageIndicateStylePageControl) {
        [self.pageLabel removeFromSuperview];
        [self.view addSubview:self.pageControl];
    }
    [self __hideOrShowPageIndicateHandle:1];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kDDPhotoBrowserWidth, [UIScreen mainScreen].bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDDPhotoBrowserWidth, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = YES;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DDPhotoBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"DDPhotoBrowserCollectionViewCell"];
    }
    return _collectionView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-40, self.view.bounds.size.width, 20)];
        _pageControl.numberOfPages = self.photoItems.count;
        _pageControl.currentPage = self.currentPage;
        _pageControl.alpha = 0;
    }
    return _pageControl;
}
- (UILabel *)pageLabel
{
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-40, self.view.bounds.size.width, 20)];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.font = [UIFont systemFontOfSize:16];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.alpha = 0;
    }
    return _pageLabel;
}
- (void)dealloc
{
    NSLog(@"dealloc：%@",NSStringFromClass([self class]));
    //删除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

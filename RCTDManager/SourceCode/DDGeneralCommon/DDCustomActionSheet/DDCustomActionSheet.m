//
//  DDCustomActionSheet.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/7.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDCustomActionSheet.h"

@interface DDCustomActionSheet () <UITableViewDelegate,UITableViewDataSource>

/**背景*/
@property (nonatomic, strong) UIView * maskView;

/**内容view，包含 tableView 和 取消 按钮*/
@property (nonatomic, strong) UIView * contentView;

/**显示标题的tableView*/
@property (nonatomic, strong) UITableView * tableView;

/**取消按钮button*/
@property (nonatomic, strong) UIButton * cancelButton;

/** 标题 */
@property (nonatomic, strong) UILabel * titleLabel;

/**点击 选择 回调*/
@property (nonatomic,copy) void (^selectedBlock)(NSInteger row,NSString * title);

@end

@implementation DDCustomActionSheet

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _configUI];
    }
    return self;
}

- (void)_configUI
{
    
    self.lineHeight = 50;
    /** 内容的背景颜色 */
    self.contentViewBackgroundColor =  [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0];
    
    self.cancelButtonContentViewSpace = 5;
    
    /** 字体颜色初始化 */
    self.otherTitleColor =self.titleColor = self.cancelColor =  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    
    /** cell 的背景颜色 */
    self.otherTitleBackgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1/1.0];
    
    /** font初始化 */
    self.titleFont = self.cancelFont = self.otherTitleFont = [UIFont systemFontOfSize:32/2.0];
    
    /** 设置取消按钮的文字 */
    self.cancelString = @"取消";
    
    [self addSubview:self.maskView];
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.tableView];
    
}

#pragma mark - tableViewDelegate && tableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.lineHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.otherTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.lineHeight)];
        button.userInteractionEnabled = NO;
        button.tag = 1000000;
        [cell.contentView addSubview:button];
        
        //最下面的线
        UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 0.5)];
        bottomLineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0];
        bottomLineView.tag = 99999;
        bottomLineView.bottom = self.lineHeight;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:bottomLineView];
    }
    cell.contentView.backgroundColor = self.otherTitleBackgroundColor;
    
    UIButton * button = [cell.contentView viewWithTag:1000000];
    [button setTitle:self.otherTitleArray[indexPath.row] forState:UIControlStateNormal];
    button.titleLabel.font = self.otherTitleFont;

    if ([self.otherTitleColor isKindOfClass:[NSArray class]]) {//是数组
        NSArray * titleColorArray = self.otherTitleColor;
        if (indexPath.row < titleColorArray.count) {
            [button setTitleColor:titleColorArray[indexPath.row] forState:UIControlStateNormal];
        }
    } else {
        [button setTitleColor:self.otherTitleColor forState:UIControlStateNormal];
    }
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    if (self.otherImageNameArray) {
        if (indexPath.row < self.otherImageNameArray.count) {
            NSString * imageName = self.otherImageNameArray[indexPath.row];
            if (imageName && imageName.length) {
                [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                button.imageEdgeInsets = UIEdgeInsetsMake(0, -ceil(8/2.0), 0, ceil(8/2.0));
                button.titleEdgeInsets = UIEdgeInsetsMake(0, ceil(8/2.0), 0, -ceil(8/2.0));
            }
        }
    }
    UIView * bottomLineView = [cell.contentView viewWithTag:99999];
    bottomLineView.hidden = NO;
    if (indexPath.row == self.otherTitleArray.count - 1) {
        bottomLineView.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismiss:nil];
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row, self.otherTitleArray[indexPath.row]);
    }
}

/** 最后弹出 */
- (void)showFromView:(UIView *)fromView selectedBlock:(void (^)(NSInteger row,NSString * title))selectedBlock
{
    if (!fromView) {
        return;
    }
    if (!self.otherTitleArray || !self.otherTitleArray.count) {
        NSLog(@"内容标题不能为空");
        return;
    }
    self.selectedBlock = selectedBlock;
    [fromView addSubview:self];
    CGRect fromViewBounds = fromView.bounds;
    self.frame = fromViewBounds;
    
    self.maskView.frame = self.bounds;
    
    CGFloat contentViewHeight = 0;
    /** 标题 */
    if (self.titleString && self.titleString.length) {
        contentViewHeight = contentViewHeight +self.lineHeight;
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = self.titleFont;
        self.titleLabel.textColor = self.titleColor;
        self.titleLabel.text = self.titleString;
        self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.lineHeight);
        self.titleLabel.backgroundColor = self.otherTitleBackgroundColor;
        UIView * lineView = [self.titleLabel viewWithTag:99999];
//        lineView.backgroundColor = [UIColor orangeColor];
        lineView.frame = CGRectMake(0, self.titleLabel.frame.size.height-0.5, self.titleLabel.frame.size.width, 1);
    }
    /** 取消 */
    CGFloat cancelButtonHeight = self.lineHeight;
    if (self.cancelString && self.cancelString.length) {
        [self.cancelButton setTitle:self.cancelString forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:self.cancelColor forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = self.cancelFont;
        [self.contentView addSubview:self.cancelButton];
        cancelButtonHeight = self.lineHeight ;
        if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {
            cancelButtonHeight = self.lineHeight + 34;
        }
        self.cancelButton.frame = CGRectMake(0, 0, self.frame.size.width, cancelButtonHeight);
        
        contentViewHeight = contentViewHeight + cancelButtonHeight;
    } else {
        self.cancelButtonContentViewSpace = 0;
    }
    self.contentView.backgroundColor = self.contentViewBackgroundColor;

    /** 大于当前的view */
    if ((self.cancelButtonContentViewSpace + contentViewHeight + self.otherTitleArray.count*self.lineHeight) > (fromViewBounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - 44)) {
        int contentCount = (int)floorf((fromViewBounds.size.height - contentViewHeight - self.cancelButtonContentViewSpace- [UIApplication sharedApplication].statusBarFrame.size.height - 44)/self.lineHeight);
        self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, contentCount * self.lineHeight);
        contentViewHeight = contentViewHeight + contentCount * self.lineHeight;
    } else {
        self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.otherTitleArray.count * self.lineHeight);
        contentViewHeight = contentViewHeight + self.otherTitleArray.count * self.lineHeight;
    }
    //如果有标题
    if (self.titleString && self.titleString.length) {
        self.tableView.frame = CGRectMake(0, self.titleLabel.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height);
    }
    //如果有取消按钮
    if (self.cancelString && self.cancelString.length) {
        self.cancelButton.frame = CGRectMake(0, self.tableView.frame.origin.y+self.tableView.frame.size.height+self.cancelButtonContentViewSpace,self.cancelButton.frame.size.width, self.cancelButton.frame.size.height);
    }
    
    self.contentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, contentViewHeight);
    self.userInteractionEnabled = YES;
    self.maskView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame = CGRectMake(0, self.frame.size.height - self.contentView.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
        self.maskView.alpha = 1;
    } completion:^(BOOL finished) {
        self.maskView.userInteractionEnabled = YES;;
    }];
    
}

/**隐藏消失*/
- (void)dismiss:(void (^)(BOOL finished))completion
{
    self.maskView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.contentView.frame.size.height);
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
        [self removeFromSuperview];
    }];
}

- (void)_dismiss
{
    [self dismiss:nil];
}

+ (void)showWithView:(UIView *)fromView
               title:(NSString *)title
              cancel:(NSString *)cancel
   otherButtonTitles:(NSArray *)otherButtonTitles
 otherImageNameArray:(NSArray *)otherImageNameArray
        clickedBlock:(void (^)(NSInteger index,NSString * title))clickedBlock
{
    DDCustomActionSheet * sheet = [[DDCustomActionSheet alloc] init];
    sheet.titleString = title;
    sheet.cancelString = cancel;
    sheet.otherTitleArray = otherButtonTitles;
    sheet.otherImageNameArray = otherImageNameArray;
    [sheet showFromView:fromView selectedBlock:clickedBlock];
}

+ (void)showWithView:(UIView *)fromView
               title:(NSString *)title
              cancel:(NSString *)cancel
   otherButtonTitles:(NSArray *)otherButtonTitles
        clickedBlock:(void (^)(NSInteger index,NSString * title))clickedBlock
{
    [self showWithView:fromView title:title cancel:cancel otherButtonTitles:otherButtonTitles otherImageNameArray:nil clickedBlock:clickedBlock];
}

+ (void)showWithView:(UIView *)fromView
              cancel:(NSString *)cancel
   otherButtonTitles:(NSArray *)otherButtonTitles
        clickedBlock:(void (^)(NSInteger index,NSString * title))clickedBlock
{
    [self showWithView:fromView title:nil cancel:cancel otherButtonTitles:otherButtonTitles otherImageNameArray:nil clickedBlock:clickedBlock];
}

+ (void)showWithView:(UIView *)fromView
   otherButtonTitles:(NSArray *)otherButtonTitles
        clickedBlock:(void (^)(NSInteger index,NSString * title))clickedBlock
{
    [self showWithView:fromView title:nil cancel:@"取消" otherButtonTitles:otherButtonTitles otherImageNameArray:nil clickedBlock:clickedBlock];
}

#pragma mark - 懒加载
- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _maskView.alpha = 0;
        _maskView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismiss)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}
/**内容view，包含 tableView 和 取消 按钮*/
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}
/** 标题 */
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.clipsToBounds = YES;
        UIView * bottomLineView = [[UIView alloc] init];
        bottomLineView.tag =  99999;
        bottomLineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0];
        [_titleLabel addSubview:bottomLineView];
    }
    return _titleLabel;
}
/**显示标题的tableView*/
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
    }
    return _tableView;
}
/**取消按钮button*/
- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitle:self.cancelString forState:UIControlStateNormal];
        [_cancelButton setTitleColor:self.cancelColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(_dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


- (void)dealloc
{
    NSLog(@"dealloc : %@",NSStringFromClass(self.class));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  UIView+WCKeyboardObServer.m
//  TestGwc
//
//  Created by admin on 23/04/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#import "UIView+WCKeyboardObServer.h"

@implementation UIView (WCKeyboardObServer)

UIView *rootView;
NSMutableArray*inputTextFields;
#pragma mark - Public Methods
-(void)addKeyboardObserver{
    [self registerKeyboardNotifications];
    if (inputTextFields==nil) {
        inputTextFields=[[NSMutableArray alloc] init];
    }
    [inputTextFields addObject:self];
    [(id)self setDelegate:self];
}
-(void)removeKeyboardObserver{
    [inputTextFields removeObject:self];
    [self removeKeyboardNotifications];
}
-(void)addSimpleKeyboardObserver{
    [self registerKeyboardNotifications];
    if (inputTextFields==nil) {
        inputTextFields=[[NSMutableArray alloc] init];
    }
    [inputTextFields addObject:self];
}
-(void)addGlobalKeyboardObserver{
    if (inputTextFields==nil) {
        inputTextFields=[[NSMutableArray alloc] init];
    }else{
        [inputTextFields removeAllObjects];
    }
    [self addAllInputTextField:[self getRootView:false] inputTextFields:inputTextFields];
}
/**
 *递归遍历界面中所有的UIView，找出所有的UITextField<br>
 * 并为UITextField注册键盘监听和委托
 **/
-(void)addAllInputTextField:(UIView*)rootView inputTextFields:(NSMutableArray*)inputTextFields{
    for (UIView *subView in rootView.subviews) {
        if (subView.subviews!=nil) {
            [self addAllInputTextField:subView inputTextFields:inputTextFields];
        }
        if ([subView isKindOfClass:[UITextField class]]){
            [self registerKeyboardNotifications];
            [(id)subView setDelegate:self];
            [inputTextFields addObject:subView];
        }
    }
}
-(void)removeGlobalKeyboardObserver{
    NSMutableArray*inputTextFields=[[NSMutableArray alloc] init];
    [self addAllInputTextField:[self getRootView:false] inputTextFields:inputTextFields];
    [inputTextFields removeObjectsInArray:inputTextFields];
    [self removeKeyboardNotifications];
}
#pragma mark - Keyboad Notification Methods
- (void)registerKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notification{
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    UITextField*firstResponderTextField=[self getFirstResponderTextField];
    CGFloat y=[self getAbsoluteY:firstResponderTextField];
    CGFloat offset = (y+firstResponderTextField.frame.size.height+20) - ([self getRootView:true].frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            [self getRootView:true].frame = CGRectMake(0.0f, -offset, [self getRootView:true].frame.size.width, [self getRootView:true].frame.size.height);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notify{
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        [self getRootView:true].frame = CGRectMake(0, 0, [self getRootView:true].frame.size.width, [self getRootView:true].frame.size.height);
    }];
}
/**
 * 获取targetView所在的UIScrollView
 */
-(UIScrollView*)getScrollView:(UIView*)targetView{
    UIScrollView*scrollView;
    UIView*superView;
    while (true) {
        superView=targetView.superview;
        if (superView==nil) {
            break;
        }else if([superView isKindOfClass:[UIScrollView class]]){
            scrollView=(UIScrollView*)superView;
            break;
        }else{
            targetView=superView;
        }
    }
    return scrollView;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[self getFirstResponderTextField] resignFirstResponder];
    return true;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [[self getFirstResponderTextField] resignFirstResponder];
}
/**
 * 获取获得焦点的输入框
 **/
-(UITextField*)getFirstResponderTextField{
    __block UITextField*firstResponderTextField=nil;
    [inputTextFields enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (((UITextField*)obj).isFirstResponder) {
            firstResponderTextField=obj;
            *stop=YES;
        }
    }];
    return firstResponderTextField;
}
/**
 * 获取当前界面的根View
 **/
-(UIView*)getRootView:(BOOL)useCache{
    if (self.window!=nil)return self.window;
    if (rootView!=nil&&useCache)return rootView;
    UIView*superView;
    UIView*targetView=self;
    while (true) {
        superView=targetView.superview;
        if (superView==nil) {
            superView=targetView;
            break;
        }else{
            targetView=superView;
        }
    }
    return rootView=superView;
}
/**
 * 获取view在窗口中的Y轴绝对位置
 **/
-(CGFloat)getAbsoluteY:(UIView*)view{
    UIView*tempView=view;
    CGFloat y;
    while (true) {
        y+=tempView.frame.origin.y;
        if ([tempView.superview isMemberOfClass:[UIView class]]) {
            tempView=tempView.superview;
        }else{
            break;
        }
    }
    return y;
}

@end

#pragma mark ----具体使用如下
/*
-(void)viewDidAppear:(BOOL)animated{
    //    [self.tf2 addKeyboardObserver];//为tf2输入框添加监听
    [self.view addGlobalKeyboardObserver]; //为界面中所有的输入框添加监听
}
-(void)viewDidDisappear:(BOOL)animated{
    //    [self.tf2 removeKeyboardObserver];//为tf2输入框移除监听
    [self.view removeGlobalKeyboardObserver];//移除界面上所有输入框的监听
}
 */

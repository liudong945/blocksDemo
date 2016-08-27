//
//  ViewController.m
//  blocksDemo
//
//  Created by 刘东 on 16/4/22.
//  Copyright © 2016年 刘东. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    UILabel *_label;
    //声明一个带两个参数的blocks
    void (^myBlocks)(UILabel *tmpLabel,NSString *str);

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self testC];
    [self createBlocks];
    [self createInterface];

}

//C的函数
//1.返回值是void 没有参数的C函数
//格式：返回值 方法名 (参数...)
void cfun (void){
    //调用时才执行函数里面的内容
    printf("this is a c method\n");
}
//2.返回值是void 带两个参数的C函数
void cfun1(int a,int b){
    printf("%d\n",a+b);
}
//3.有返回值 带两个参数的C函数
int cfun2(int c,int d){
    int muli = c*d;
    return muli;
}

-(void)testC{
    cfun();
    cfun1(2, 3);
    int muli = cfun2(4, 5);
    NSLog(@"乘积是%d",muli);
    
    //1.声明一个返回值是void,不带参数的函数指针
    //格式:返回值(*xxx)(参数...)
    void (*fun1)(void);
    fun1 = &cfun;   //函数名本身就是一个地址，&可加可不加
    fun1();
    //2.声明一个返回值是void,带两个参数的函数指针
    void (*fun2)(int a,int b);
    fun2 = cfun1;
    fun2(6,7);
    //3.声明一个返回值是int,带两个参数的函数指针
    int (*fun3)(int a,int b);
    fun3 = cfun2;
    NSLog(@"%d",fun3(8,9));
    
}



#pragma mark - blocks基本用法
-(void)createBlocks{
    void (*func)(void);
    func = cfun;
    func();
    
    //blocks
    NSLog(@"1.声明一个不带参数的blocks");
    void (^myBlocks)(void);
    void (^myBlocks11)(void);
    myBlocks11 = ^void(void){
        NSLog(@"坑爹啊");
    };
    myBlocks11();
    NSLog(@"2.给一个blocks赋值");
    //标准格式:^返回值类型(参数...){blocks体}
    // ^void(void){}
    //返回值可以不写
    // ^(void){}
    //参数如果是void,可以不写
    // ^{}
    myBlocks = ^void(void){
        //blocks体
        NSLog(@"this is a blocks");
    };
    NSLog(@"3.调用一个blocks");
    myBlocks();
    
    
    void (^myBlocks1)(void);
    //返回值类型不管是什么，赋值时都可以不写返回值类型
    //如果参数是void,也可以省略不写
    myBlocks1 = ^{
        NSLog(@"in blocks");
    };
    myBlocks1();
    
    
    //2.声明一个返回值是void,带两个参数的blocks
    NSLog(@"声明一个带参的，返回值是void的blocks");
    void (^myBlocks2)(int a,int b);
    NSLog(@"给blocks赋值");
    myBlocks2 = ^(int a,int b){
        NSLog(@"%d",a+b);
    };
    NSLog(@"调用blocks");
    myBlocks2(9,6);
    
    //练习
    void (^myBlocks3)(NSString *str,char c);
    myBlocks3 = ^(NSString *str,char c){
        NSString *str0 = [NSString stringWithFormat:@"%@%c",str,c];
        NSLog(@"str0 = %@",str0);
    };
    myBlocks3(@"hello",'W');
    
    //3.声明一个返回值类型是int,带两个参数的blocks
    NSLog(@"声明一个返回值类型是int,带两个参数的blocks");
    int (^myBocks4)(int a,int b);
    NSLog(@"给blocks赋值");
    myBocks4 = ^(int a,int b){
        int muli = a*b;
        return muli;
    };
    NSLog(@"调用blocks");
    NSLog(@"%d",myBocks4(5,6));
    
}
#pragma mark - 界面布局
-(void)createInterface{
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 40)];
    _label.text = @"用于显示文本内容";
    _label.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 160, 320, 40);
    [btn setTitle:@"通过blocks修改label的内容" forState:UIControlStateNormal];
    [btn setTitle:@"btn已选中" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //初始化blocks
    myBlocks = ^(UILabel *tmp,NSString *str){
        tmp.text = str;
    };
    
}
#pragma mark - 点击事件
-(void)btnClick:(UIButton *)btn{
    myBlocks(_label,btn.currentTitle);
    btn.selected = !btn.selected;
    //点击btn时，调用blocks，修改label显示的内容
    myBlocks(_label,btn.titleLabel.text);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

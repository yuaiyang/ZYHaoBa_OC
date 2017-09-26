//
//  WealthGestureUnlockView.m
//  Wealth
//
//  Created by yilu on 14-3-31.
//  Copyright (c) 2014年 许可. All rights reserved.
//

#import "MBGestureUnlockView.h"


//定义宏数据，进行对应的当前对应按钮阵列的边界间隙尺寸的定义处理
#define ButtonSiderWidth 10.f
//定义默认的视图横向的对应按钮数目
#define RowDefaultButtonNumber 3
//定义默认的视图纵向的对应按钮数目
#define CollumnDefaultButtonNumber 3

//定义默认的视图背景图片
#define BackGroundImage [UIImage imageNamed:@""]

@implementation MBGestureUnlockView
#pragma mark-TouchesActions
//调用手势代理，进行对应的手势滑动界面显示及对应的密码生成处理
//手势起始函数
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //当不能接受手势响应时直接返回
    if(!self.isCanReceiveTouch)
    {
        return;
    }
    
    //定义变量，获取对应的当前点击的对应点的坐标
    CGPoint beginPoint=[[touches anyObject] locationInView:self];
    
    //调用循环进行对应的当前是否点击到对应的按钮的判断操作
    for(MBImageUnlockButton *tempBtn in self.buttonsArr)
    {
        //定义变量，获取对应的按钮尺寸
        float buttonWidth=tempBtn.frame.size.width;
        //定义变量，进行对应的当前点击处同对应的按钮中心位置的对应距离
        float xDistance=beginPoint.x-tempBtn.center.x;
        float yDistance=beginPoint.y-tempBtn.center.y;
        
        //对应的点击点同对应的中心处的距离小于按钮半径尺寸时，标明已经点击到对应的按钮，进行对应的点击判断处理
        if((fabsf(xDistance)<(buttonWidth/2-1.f)&&(yDistance)<(buttonWidth/2-1.f)&&fabsf(xDistance)<0&&fabsf(yDistance)<0))
        {
            //当当前的对应按钮并没有被选中时，进行对应按钮的选中处理操作
               if(!tempBtn.selected)
               {
                   tempBtn.selected=YES;
                   //保存当前触摸的按钮到对应的数组中
                   [self.selectedButtonsArr addObject:tempBtn];
               }
        }
        else
        {
            tempBtn.selected=NO;
        }
    }
    
    //调用函数，进行对应的界面显示的重绘操作
    [self setNeedsDisplay];
    
}

//手势移动函数
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //当不能接受手势响应时直接返回
    if(!self.isCanReceiveTouch)
    {
        return;
    }
    
    //定义变量，获取当前移动的对应点坐标
    CGPoint movePoint=[[touches anyObject] locationInView:self];
    //将当前移动的点赋值给对应的属性变量
    self.currentTouchesPoint=movePoint;
    
    //调用循环，进行对应的选中按钮的判断处理并进行对应的按钮选中操作
    for(MBImageUnlockButton *tempBtn in self.buttonsArr)
    {
        float buttonWidth=tempBtn.frame.size.width;
        float xDistance=movePoint.x-tempBtn.center.x;
        float yDistance=movePoint.y-tempBtn.center.y;
        
        //如果当前的区域在对应的按钮内时进行对应的按钮选中操作处理
        if(fabsf(xDistance)<(buttonWidth/2-1.f)&&fabsf(yDistance)<(buttonWidth/2-1.f))
        {
            if(!tempBtn.selected)
            {
                tempBtn.selected=YES;
                //保存当前触摸的按钮到对应的数组中
                [self.selectedButtonsArr addObject:tempBtn];
            }
        }
    }
    
    //调用函数，进行对应的界面显示的重绘操作
    [self setNeedsDisplay];
}

//手势结束函数
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //当不能接受手势响应时直接返回
    if(!self.isCanReceiveTouch)
    {
        return;
    }
    
    //当对应的选中数组为空时，进行对应编码的置空及对应信息的提示处理
    if(self.selectedButtonsArr==nil||self.selectedButtonsArr.count==0)
    {
        self.currentCodeString=nil;
        showAlert(@"请勾画您要输入的手势图形！");
    }
    //当对应选中的手势包含的点过少时，进行对应的提醒处理
    else if (self.selectedButtonsArr.count<4)
    {
        self.currentCodeString=nil;
        showAlert(@"手势图形至少由4个点构成，请重新勾画您要输入的手势图形！");
    }
    //当输入符合规范时，进行对应的当前密码的获取保存操作
    else
    {
        //在进行对应的密码初始化时进行对应的置空处理，放置数据过多造成荣誉
        self.currentCodeString=nil;
        //调用循环，进行对应的当前编码的保存处理
        for(int i=0;i<self.selectedButtonsArr.count;i++)
        {
            MBImageUnlockButton *tempButton=self.selectedButtonsArr[i];
            //如果当前的对应编码字符串为空时，进行第一个编码的保存处理
            if(self.currentCodeString==nil||self.currentCodeString.length==0)
            {
                self.currentCodeString=[NSString stringWithFormat:@"%d",tempButton.currentIndex];
            }
            //如果当前的编码字段不为空时，进行对应的字符串拼接处理
            else
            {
                self.currentCodeString=[NSString stringWithFormat:@"%@,%d",self.currentCodeString,tempButton.currentIndex];
            }
            
        }
    }
    
    //调用循环，在对应手势结束时进行对应的所有按钮选中的取消操作
    for(MBImageUnlockButton *tempBtn in self.buttonsArr)
    {
        tempBtn.selected=NO;
    }
    
    //在触摸结束时进行对应的数组清空操作处理
    [self.selectedButtonsArr removeAllObjects];
    
    //调用函数，进行对应的界面显示的重绘操作
    [self setNeedsDisplay];
    
    //当外界响应了对应代理时调用对应的代理处理函数，进行对应的密码操作
    if(self.delegate&&[self.delegate respondsToSelector:@selector(didFinishTouchesInView:withCode:)])
    {
        //调用函数，将对应的当前视图及对应的密码数据进行传递
        
        [self.delegate didFinishTouchesInView:self withCode:self.currentCodeString];
    }
}

//重写重绘函数，进行对应的手势连线的绘画操作
-(void)drawRect:(CGRect)rect
{
    //当不能接受手势响应时直接返回
    if(!self.isCanReceiveTouch)
    {
        return;
    }
    
    //定义变量，进行对应的当前周边环境变量的获取操作
    CGContextRef context=UIGraphicsGetCurrentContext();
    //定义两个按钮，进行对应的划线准备操作
    MBImageUnlockButton *beginButton;
    MBImageUnlockButton *nextButton;
    
    //当对应的选中按钮数组并不为空时，进行对应的划线操作
    if(self.selectedButtonsArr!=nil&&self.selectedButtonsArr.count!=0)
    {
        //获取对应的首个按钮并进行对应的划线操作
        beginButton=self.selectedButtonsArr[0];
        
        //设定要画的线的类型宽度及颜色等属性
        CGContextSetLineCap(context,kCGLineCapSquare);
        CGContextSetLineWidth(context,6.f);
//        CGContextSetRGBStrokeColor(context, 0.f/255.f, 167.f/255.f,246.f/255.f, 1.0);
        CGContextSetRGBStrokeColor(context, 240.f/255.f, 74.f/255.f, 58.f/255.f, 1);
        
        //将当前的点移动到对应的起始点
        CGContextMoveToPoint(context, beginButton.center.x, beginButton.center.y);
        
        //调用循环，进行对应选中按钮的划线操作
        for(int i=1;i<self.selectedButtonsArr.count;i++)
        {
            nextButton=self.selectedButtonsArr[i];
            //添加对应的线条到对应的按钮之间
            CGContextAddLineToPoint(context, nextButton.center.x, nextButton.center.y);
        }
        //在移动手势时将对应的线条添加到当前的触点处
        CGContextAddLineToPoint(context, self.currentTouchesPoint.x, self.currentTouchesPoint.y);
    }
//    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    //进行划线操作，之前的仅仅是画出对应的路径，这一句完成对应的划线操作
    CGContextStrokePath(context);
}
#pragma mark-ButtonBuiltActions
//定义函数进行对应的传入的按钮行数与列数的校验处理操作
-(BOOL)checkButtonNUMWithRowNUM:(int)rowNUM collumnNUM:(int)collumnNum
{
    //定义结果变量，进行对应的验证结果保存操作
    BOOL result=FALSE;
    
    //对传入的对应的每行按钮及每列按钮数目进行对应的校验处理操作
    if(rowNUM<=1||collumnNum<=1)
    {
        xh(@"进行手势解锁创建按钮阵列视图时传入的每行、每列按钮数目有误，请检查输入！");
        return result;
    }

    //如果传入的按钮数目过少，无法构成至少3*3的对应按钮矩阵，则进行提醒，并将对应的错误信息进行输出显示
    if(rowNUM*collumnNum<9)
    {
        xh(@"进行手势解锁创建按钮阵列视图时传入的每行、每列数目过少，请保证每行至少有三个按钮，否则会影响数据的复杂性，造成密码过于简单！");
        return result;
    }
    
    //当传入的对应按钮横行与竖行按钮数目相同时，进行对应的提醒及返回操作
    if(rowNUM==self.currentRowNumber&&collumnNum==self.currentCollumnNumber)
    {
        //当不为初始化操作时，进行错误信息的显示并返回操作
        if(!self.isInit)
        {
            xh(@"传入的每行、每列按钮数目与当前按钮阵列数目相同！");
            return result;
        }
        //当为初始化操作时，进行对应的判断变量置假操作处理
        else
        {
            self.isInit=NO;
        }
    
    }
    //当传入的对应行按钮数和列按钮数至少有一个不同时，进行对应的按钮阵列重绘操作
    else
    {
        self.currentRowNumber=rowNUM;
        self.currentCollumnNumber=collumnNum;
    }
    
    //当验证成功后将对应的结果变量设置为真
    result=YES;
    
    //将对应的验证结果返回
    return result;
}

//定义函数，进行对应的当前按钮视图的绘制显示操作
-(void)resetGestureUnlockViewWithRowNum:(int)rowNUM collumnNum:(int)collumnNum
{
    //调用函数，进行对应的传入按钮行数与列数的校验处理,并在数据校验成功后进行对应的当前行数列数的赋值操作处理
    if(![self checkButtonNUMWithRowNUM:rowNUM collumnNUM:collumnNum])
    {
        return;
    }
    
    //对对应的按钮数组进行对应的清空重置操作
    if(self.buttonsArr!=nil&&self.buttonsArr.count!=0)
    {
        [self.buttonsArr removeAllObjects];
    }
    else
    {
        self.buttonsArr=[[NSMutableArray alloc]init];
    }
    
    //将对应背景视图上的对应按钮阵列进行对应的移除清空操作处理
    for(UIView *tempView in [self.backGroundImageView subviews])
    {
        if([tempView isKindOfClass:[MBImageUnlockButton class]])
        {
            [tempView removeFromSuperview];
        }
    }
    
    //定义变量，进行对应的按钮尺寸的保存处理，因为按钮本身为圆形，故其按钮本身尺寸为长宽相等的
    float buttonWidth=0.f;
    
    //定义变量，进行当前背景视图的尺寸的保存处理
    CGRect viewBounds=self.backGroundImageView.frame;
    //定义变量，分别保存对应的背景视图的宽和高
    float viewWidth=viewBounds.size.width-2*ButtonSiderWidth;
    float viewHeight=viewBounds.size.height-2*ButtonSiderWidth;
    
    //定义浮点型变量，当对应的横排与竖排按钮不同时进行对应的显示位置调整处理
    float buttonXOffset=0.f;
    float buttonYOffset=0.f;
    
    //判断当前设定的背景视图的大小是否合适
    if((viewHeight-ButtonSiderWidth*2<=0)||(viewHeight-ButtonSiderWidth*2<=0))
    {
        xh(@"进行手势解锁时设计的背景视图尺寸过小，请重新给定合适的尺寸大小，以便视图可以正确显示！");
        return;
    }
    
    //根据当前视图的宽高进行对应的按钮及按钮间隙的对应尺寸的设定处理
    if(viewWidth>=viewHeight)
    {
//        //在高比宽少时，如果横列的按钮数目比纵列的按钮数目少时，直接进行对应的按钮宽高计算
//        if(collumnNum<rowNUM)
//        {
//            buttonWidth=viewWidth/(2*rowNUM-1);
//            
//            //设定对应的横轴与纵轴的对应坐标偏移量
//            buttonXOffset=(viewWidth-buttonWidth*(2*collumnNum-1))/2;
//            buttonYOffset=0.f;
//        }
//        //当对应的横列的按钮数目比纵列的按钮数目少时，比较横纵二者的按钮试计算大小，取较小的按钮尺寸
//        else
//        {
            //分别获取对应的横排与竖排按钮的宽度并比较大小
            float tempRowButtonWidth=viewWidth/(3*collumnNum/2);
            float tempCollumnButtonWidth=viewHeight/(3*rowNUM/2);
            
            //根据对应按钮的大小取二者之间比较小的进行对应的按钮大小的设定
            if(tempRowButtonWidth>=tempCollumnButtonWidth)
            {
                buttonWidth=tempCollumnButtonWidth;
                
                //设定对应的横轴与纵轴的对应坐标偏移量
                buttonXOffset=(viewWidth-buttonWidth*(3*collumnNum/2))/2;
                buttonYOffset=0.f;
            }
            else
            {
                buttonWidth=tempRowButtonWidth;
                
                //设定对应的横轴与纵轴的对应坐标偏移量
                buttonXOffset=0.f;
                buttonYOffset=(viewHeight-buttonWidth*(3*rowNUM/2))/2;
            }
//        }
    }
    else if(viewWidth<=viewHeight)
    {
//        //在宽比高少时，如果纵列的按钮数目比横列的按钮数目少时，直接进行对应的按钮宽高计算
//        if(collumnNum>rowNUM)
//        {
//            buttonWidth=viewHeight/(2*collumnNum-1);
//            
//            //设定对应的横轴与纵轴的对应坐标偏移量
//            buttonXOffset=0.f;
//            buttonYOffset=(viewHeight-buttonWidth*(2*rowNUM-1))/2;
//        }
//        //当对应的横列的按钮数目比纵列的按钮数目多时，比较横纵二者的按钮试计算大小，取较小的按钮尺寸
//        else
//        {
            //分别获取对应的横排与竖排按钮的宽度并比较大小
            float tempRowButtonWidth=viewWidth/(3*collumnNum/2);
            float tempCollumnButtonWidth=viewHeight/(3*rowNUM/2);
            
            //根据对应按钮的大小取二者之间比较小的进行对应的按钮大小的设定
            if(tempRowButtonWidth>=tempCollumnButtonWidth)
            {
                buttonWidth=tempCollumnButtonWidth;
                //设定对应的横轴与纵轴的对应坐标偏移量
                buttonXOffset=(viewWidth-buttonWidth*(3*collumnNum/2))/2;
                buttonYOffset=0.f;
            }
            else
            {
                buttonWidth=tempRowButtonWidth;
                
                //设定对应的横轴与纵轴的对应坐标偏移量
                buttonXOffset=0.f;
                buttonYOffset=(viewHeight-buttonWidth*(3*rowNUM/2))/2;
            }
//        }
    }
    
    //当对应的按钮尺寸大小过小时进行对应的错误提醒并返回
    if((int)buttonWidth<=0)
    {
        xh(@"进行手势解锁按钮阵列按钮尺寸计算过程中设定的对应背景视图过小导致对应按钮尺寸过小，请酌情增大对应背景视图或是减少对应按钮数量！");
        return;
    }
    
    
    //调用循环，进行对应的按钮阵列的创建操作
    //外层循环为横向循环
    for(int i=0;i<collumnNum;i++)
    {
        //内层循环为纵向循环
        for (int j=0;j<rowNUM; j++)
        {
            //定义对应按钮，进行对应的点阵中对应点的显示处理
            MBImageUnlockButton *unlockButton=[[MBImageUnlockButton alloc]initWithFrame:CGRectMake(buttonXOffset+ButtonSiderWidth+(1.5*i)*buttonWidth, buttonYOffset+ButtonSiderWidth+(1.5*j)*buttonWidth, buttonWidth, buttonWidth) normalImage:self.buttonNormalImage selectImage:self.buttonSelectImage currentTag:j*collumnNum+i selectedStatus:NO];  //initWithFrame:CGRectMake(buttonXOffset+ButtonSiderWidth+(2*i)*buttonWidth, buttonYOffset+ButtonSiderWidth+(2*j)*buttonWidth, buttonWidth, buttonWidth) currentTag:j*collumnNum+i selectedStatus:NO];
            unlockButton.backgroundColor=[UIColor clearColor];
            //将对应的按钮添加到对应的背景视图上
            [self.backGroundImageView addSubview:unlockButton];
            //将对应的按钮添加到对应的按钮数组上
            [self.buttonsArr addObject:unlockButton];
        }
    }
    
    //在进行对应的按钮添加后进行对应的界面刷新操作
    [self reloadInputViews];
}
#pragma mark-ViewDealtActions
//定义函数，根据传入的对应密码值进行对应的按钮选中显示处理
-(void)setSelectedButtonWithCodeString:(NSString *)codeString
{
    //对传入的密码字符串，进行对应的判空操作
    if(codeString==nil||codeString.length==0)
    {
        xh(@"进行手势解锁视图设置当前选中按钮时传入的对应手势密码有误，请检查输入！");
        return;
    }
    
    //调用循环，在初始时清空对应的按钮选中状态
    for(MBImageUnlockButton *tempBtn in self.buttonsArr)
    {
        tempBtn.selected=NO;
    }
    
    //定义数组，进行对应的密码分割操作处理
    NSArray *selectedButtonTagsArr=[codeString componentsSeparatedByString:@","];
    //利用循环，进行对应的按钮选中处理
    for(int j=0;j<selectedButtonTagsArr.count;j++)
    {
        //定义字符串，获取当前的对应选中button的tag值
        NSString *currentTag=selectedButtonTagsArr[j];
        for(int i=0;i<self.buttonsArr.count;i++)
        {
            //获取对应的button
            MBImageUnlockButton *tempBtn=self.buttonsArr[i];
            if(tempBtn.currentIndex==[currentTag intValue])
            {
                tempBtn.selected=YES;
                break;
            }
        }

    }
    
    //当设定对应按钮的选中后，直接设置视图不能接受对应的手势点击处理操作
    self.isCanReceiveTouch=NO;
}
#pragma mark-InitActions
//定义函数，进行对应视图本身的初始化操作处理
- (MBGestureUnlockView *)initWithFrame:(CGRect)frame backGroundImage:(UIImage *)backGroundImage buttonNormalImage:(UIImage *)buttonNormalImage buttonSelectImage:(UIImage *)buttonSelectImage rowNum:(int)rowNUM colNum:(int)collumnNUM
{
    //调用函数，进行对应的视图本身的初始化操作
    self = [super initWithFrame:frame];
    if (self)
    {
        //设置本身视图的背景颜色为透明色,一定要加，且如果不加就会使得在手势移动过程中造成绘制的线很多(包括移动路径上的),加上后就保证了对应的链接为一条线
        self.backgroundColor=[UIColor clearColor];
        
        //当传入的背景图片为空时，进行对应的默认的背景的设置处理
        if(backGroundImage==nil)
        {
            self.backGroundImage=BackGroundImage;
        }
        //当传入的对应背景图片不为空时，进行对应的传入图片的背景图片设置处理
        else
        {
            self.backGroundImage=backGroundImage;
        }
        
        //初始化对应的背景视图，并将对应的背景图片视图添加到视图上
        self.backGroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.backGroundImageView.backgroundColor=[UIColor clearColor];
        self.backGroundImageView.userInteractionEnabled=YES;
        self.backGroundImageView.image=self.backGroundImage;
        [self addSubview:self.backGroundImageView];
        
        //根据传入的横行按钮数目，进行对应的当前横排按钮数目的初始化操作
        if(rowNUM<=0)
        {
            self.currentRowNumber=RowDefaultButtonNumber;
        }
        else
        {
            self.currentRowNumber=rowNUM;
        }
        
        //根据传入的竖行按钮数目，进行对应的当前竖排按钮数目的初始化操作
        if(collumnNUM<=0)
        {
            self.currentCollumnNumber=CollumnDefaultButtonNumber;
        }
        else
        {
            self.currentCollumnNumber=collumnNUM;
        }
        
        //将对应的判断变量进行对应的初始化操作,设置为可以进行按钮阵列初始化操作
        self.isInit=YES;
        
        //初始化时将对应的手势密码字符串进行对应的置空操作处理
        self.currentCodeString=nil;
        
        //初始时默认设置可以接受手势事件
        self.isCanReceiveTouch=YES;
        
        //进行对应出入的手势按钮图片的保存处理操作,不论其传入的对应图片是否为空，当为空时进行对应的默认视图的显示处理操作
        _buttonNormalImage=buttonNormalImage;
        _buttonSelectImage=buttonSelectImage;
        
        //调用函数，进行当前的对应按钮视图的对应创建操作
        [self resetGestureUnlockViewWithRowNum:self.currentRowNumber collumnNum:self.currentCollumnNumber];
        
        //当对应的保存当前选中按钮的数组没有创建时将进行对应的数组创建操作
        if(self.selectedButtonsArr==nil)
        {
            self.selectedButtonsArr=[[NSMutableArray alloc]init];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

## TTDefaultPage

我是一个TableView的缺省页分类，在没有cell内容的时候展示

## Example

显示效果如图：


![不带按钮](http://a1.qpic.cn/psb?/V14HUEIQ1MT5om/vmx5evYCStrEeqSrAPwHsW.pRMGtfgAZyiCNZn22LRc!/b/dOEAAAAAAAAA&bo=2gE7AgAAAAAFAME!&rf=viewer_4.jpg) 



![带按钮](http://a1.qpic.cn/psb?/V14HUEIQ1MT5om/UwX9bCbrICIjobghi8*wW7PijRbcltE1.TDZtyrGkpw!/b/dAsBAAAAAAAA&bo=3AGwAQAAAAAFB0g!&rf=viewer_4.jpg)


## Usage

1. 添加文件UITableView+DefaultPage.h和UITableView+DefaultPage.m到工程中

2. import头文件到所需要的目录


然后在你需要添加的tableView处敲入代码1，如果你需要修改缺省页则敲如代码2,在你觉得不需要的内容上，你可以置nil，但是Title和Image必须要有。


```
//代码1
[self.tableView addDefaultPageWithImageName:@"imageName" andTitle:@"ContentTitle"];




//代码2
[self setDefaultPageWithImageName:@"imageName2" andTitle:@"ContentTitle2" andSubTitle:nil andBtnImage:nil andbtnTitle:nil andBtnAction:nil];

```


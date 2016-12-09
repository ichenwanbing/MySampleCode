## TTRegex

I'm a simple tool to check Regular Expression.

## Usage

1.add TTRegex.h and TTRegex.m to your project.

2.input #import "TTRegex.h" to file where you need to use.

3.read Method Annotation in TTRegex.h.

## Example 
This is a example to check phone number.


```
[JJRegexKit stringsSeparatedByText:self.textField.text pattern:@"^[1][34578][0-9]{9}$" TextPart:^(JJTextPart *textPart) {
    //textPart return the right textfield.text input
}];

```








#中文说明

这是一个工具类，用于正则表达式检测字符串类型的正确性。


#使用方法
1. 将TTRegex.h和TTRegex.m导入工程

2. 在需要使用正则表达式验证的类中#import "TTRegex.h" 

3. 阅读.h文件使用方法；


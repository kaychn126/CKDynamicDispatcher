##CKDynamicDispatcher

Dynamic dispatch any UIViewController with any property and method

CKDynamicDispatcher提供的功能是：通过Scheme或者JSBridge注入iOS客户端一段Json文本，CKDynamicDispatcher用反射的方式可以动态调用iOS客户端内部任何UIViewController的子类。 此项目的主要目的是使H5页面可以动态调用任何Native页面，而不用提前将调用逻辑写在客户端中。使客户端可以更加灵活的支持各种类型的运营活动。

###Installation
Cocoapods: `'pod CKDynamicDispatcher' `

###Usage
>`#import "CKDispatcherCenter.h"`
> ####Push a UIViewController
> 
>
>`[CKDispatcherCenter pushWithParams:params withNavigationController:self.navigationController];`  
>
> ####Get a UIViewController
> `UIViewController *viewController = [CKDispatcherCenter viewControllerWithParams:params];`
> 
> *params can be NSString in json format or NSDictionary*

####Examples
 * Push `SecondViewController`:    
 `params : {"target": "SecondViewController"}`
 
 * Push `SecondViewController` and set property:  
 `params : {
  "propertyList": [
    {
      "propertyValue": "1212ioio",
      "propertyName": "userId"
    }
  ],
  "target": "SecondViewController"
}`    

* Push `SecondViewController ` and set custom property  
`params : {
  "propertyList": [
    {
      "propertyName": "user",
      "propertyClassName": "UserModel",
      "propertyList": [
        {
          "propertyName": "userName",
          "propertyValue": "kaychn126"
        }
      ]
    }
  ],
  "target": "SecondViewController"
}`    

* Push `SecondViewController` and invoke instance method  
`params : {
  "target": "SecondViewController",
  "action": {
    "methodName": "setPropertyWithUserId:userName:",
    "methodType": 1,
    "argumentList": [
      "bnbnm2bn9",
      "kaychn126"
    ]
  }
}`  

* Invoke class method  
`params : {
  "target": "SecondViewController",
  "action": {
    "methodName": "viewControllerUserId:userName:",
    "methodType": 2,
    "argumentList": [
      "bnbnm2bn9",
      "kaychn126"
    ]
  }
}`

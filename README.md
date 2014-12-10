AKNavTabController
==================

This is a custom viewcontroller similar to the android google play store scroll tab on ios


###Use
- Extend AKNavTabController
- Create your viewcontrollers in your storyboards and add a storyboardId to them
- In your viewDidload  you can add your titles and your viewcontroller ids.

```
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.titles=@[@"vc0",@"vc1",@"vc2",@"vc3"];
    self.viewControllersId=@[@"vc0",@"vc1",@"vc2",@"vc3"];
}
```

###Note
 There is no need to reinitialize the controller if you have to add newViewControllers. Just Change the array and it will do it automatically.
 
 
###Future work
It will have the ability to retain its viewcontrollers and will be more flexible on editing the controller.
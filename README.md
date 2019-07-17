# DStorageKit
A simple implementation of UITableViewDelegate + UITableViewDataSource that allows you to manage the content of a complex table with multiple sections and cells and customize the interface.

# Quick look through
We have a complex UITableView with many different sections and cells that can be changed in the display order, disabled or added to our tableView. 
Main target of this framework is to separate logic elements, remove all switch-case statements and create our code more readable and flexible.

<img src="https://github.com/ese9/DStorageKit/blob/master/Images/Section_Screen.png" width="300" height="650" />

## How it works
### Custom DataSource
1) Create new swift class
2) Inherit class from TableDataSource
3) Assign this class to table view delegate and dataSource
4) Create sections and add them by calling ```addNewSection(with: sectionKey, section)```
> NOTE: 
No need to store your section in variable. You can get refernce by simple calling ```let section: YourSectionType = self[sectionKey]```

5) You can set section ```baseFlowDelegate``` - custom BaseFlowDelegate which functions can be implemented in viewController.
> NOTE: 
Since we can't use protocol as concrete generic type you should cast your ```baseFlowDelegate``` variable to the required type (for each section)

<img src="https://github.com/ese9/DStorageKit/blob/master/Images/DataSource_Screen.png" />

### Custom Section with 1 cell
1) Create new swift class.
2) Inherit it from TableSection  where T is your table cell type
> NOTE:
Make sure your cell class has the same name with table cell identifier

3) After implementing your initializtion call ```super.init(priority: 1, minRowsCount: 0, maxRowsCount: Int.max)```
> NOTE: 
 ```Priority``` property is responsible for displaying sections order. Set ```minRowsCount``` and ```maxRowsCount``` for your section. ```originRowsCount``` will be clamped between these 2 values

4) Customize your section using variables:
```swift
    open var sectionRowHeight = UITableView.automaticDimension
    open var headerHeight = UITableView.automaticDimension
    open var footerHeight = UITableView.automaticDimension
```
5) Set ```originRowsCount``` in your initializtion. This variable is resposible for the number of cells to be created
<img src="https://github.com/ese9/DStorageKit/blob/master/Images/SectionInit_Screen.png"/>

6) You can override section functions:
```swift
    open func onCellAddedToSection(at index: Int, cell: T) {}
    open func onCellRemovedFromSection(at index: Int, cell: T) {}
    open func onCellSelectedInSection(at index: Int, cell: T) {}
    open func onCellUpdatedInSection(at index: Int, cell: T) {}
    open func configureHeader() -> UIView? { return nil }
    open func configureFooter() -> UIView? { return nil }
```
<img src="https://github.com/ese9/DStorageKit/blob/master/Images/SectionOverride_Screen.png"/>

7) Add your section to dataSource

### Custom Section with more than 1 cell
1) Create new swift class
2) Inherit it from MultiTableSection
..) 3-5 Do the same steps as in single-cell section implementation
6) Create new class and inherit it from CellWrapper<T, U> for each cell you want to be displayed
> NOTE: T - your cell class type. U - section class type (owner for created wrapper). Wrapper has weak reference to its owner ```wrapperOwner```. Wrapper has their own display priority

<img src="https://github.com/ese9/DStorageKit/blob/master/Images/Wrapper_Screen.png"/>

7) Add wrappers to section by calling ```addWrapper(with: wrapperKey, wrapper: wrapper)```.
> NOTE: You can get reference to wrapper by calling ```let wrapper: YourWrapperType = self[wrapperKey]```

<img src="https://github.com/ese9/DStorageKit/blob/master/Images/MultSectionInit_Screen.png"/>

6) Overridable SECTION functions:
```swift
    open func configureHeader() -> UIView? { return nil }
    open func configureFooter() -> UIView? { return nil }
```
7) Overridable WRAPPER functions:
```swift
    open func onCellAddedToSection(at index: Int, cell: T) {}
    open func onCellRemovedFromSection(at index: Int, cell: T) {}
    open func onCellSelectedInSection(at index: Int, cell: T) {}
    open func onCellUpdatedInSection(at index: Int, cell: T) {}
```

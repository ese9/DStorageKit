

Pod::Spec.new do |spec|

  spec.name         = "DStorageKit"
  spec.version      = "1.3.0"
  spec.summary      = "Library for flexible UITableView control"
  spec.homepage     = "http://github.com/ese9/DStorageKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Roman Novikov" => "n90.roman@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/ese9/DStorageKit.git", :tag => "1.3.0" }
  spec.source_files  = "DStorageKit/DataSource", "DStorageKit/DataSource/Protocols/*.swift", "DStorageKit/DataSource/Protocols/Section/*.swift", "DStorageKit/DataSource/Table/*.swift", "DStorageKit/DataSource/Table/Section/*.swift", "DStorageKit/DataSource/Table/Wrapper/*.swift"
  spec.framework  = "UIKit"
  spec.requires_arc = true
  spec.swift_version = "5.0"

end

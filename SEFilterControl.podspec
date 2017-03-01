Pod::Spec.new do |s|
    s.name         = 'SEFilterControl-ProgressColor'
    s.version      = '2.1.0'
    s.license      = 'MIT'
    s.platform     = :ios, "5.0"
    s.authors      = { 'Ali Germiyanoglu' => 'aligermiyanoglu@gmail.com'}
    s.homepage     = 'github.com/aligermiyanoglu/ios-filter-control/'
    s.summary      = 'An iOS Filter UIControl Subclass. Zero Graphics. Highly Customizable.'
    s.source       = { :git => 'github.com/aligermiyanoglu/ios-filter-control/', :tag => "#{s.version}"}
    s.source_files = '*.{h,m}' 
    s.requires_arc = true
end

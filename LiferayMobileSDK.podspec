Pod::Spec.new do |s|
    s.name     = 'LiferayMobileSDK'
    s.version  = '1.0.0'
    s.license  = {
        :type => 'LGPL',
        :file => 'copyright.txt'
    }
    s.summary  = 'Objective-C SDK to use Liferay''s services'
    s.homepage = 'http://www.liferay.com'
    s.author   = 'Bruno Farache'
    s.source   = {
        :git => 'https://github.com/liferay/liferay-mobile-sdk.git',
        :tag => s.version.to_s
    }
    s.requires_arc        = true
    s.platform            = :ios
    s.source_files        = 'ios/core/**/*.{h,m}', 'gen/ios/**/*.{h,m}'


end

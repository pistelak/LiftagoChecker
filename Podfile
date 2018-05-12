
workspace 'LiftagoChecker.xcworkspace'
platform :ios, '9.0'

# use_frameworks!
inhibit_all_warnings!

target 'LiftagoChecker' do
	project 'LiftagoChecker/LiftagoChecker.xcodeproj'

	pod 'Google/SignIn', '~> 3.0.3'
end

target :GMailService do
	project 'LiftagoChecker/GMailService/GMailService.xcodeproj'

	pod 'GoogleAPIClientForREST/Gmail', '~> 1.2.1'
end

target:GMailServiceTests do
    project 'LiftagoChecker/GMailService/GMailService.xcodeproj'
    
    pod 'GoogleAPIClientForREST/Gmail', '~> 1.2.1'
end



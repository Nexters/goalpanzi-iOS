generate:
	make clean
	tuist install
	tuist generate

clean:
	killAll Xcode && rm -rf ~/Library/Saved\ Application\ State/com.apple.dt.Xcode.savedState
	tuist clean
	rm -rf **/**/**/*.xcodeproj
	rm -rf **/**/*.xcodeproj
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace
	rm -rf ./Tuist/.build

module:
	swift Scripts/GenerateModule.swift

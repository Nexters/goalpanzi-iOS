generate:
	tuist install
	tuist generate

clean:
	tuist clean
	rm -rf **/**/**/*.xcodeproj
	rm -rf **/**/*.xcodeproj
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

module:
	swift Scripts/GenerateModule.swift

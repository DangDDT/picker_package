cp:
	flutter create --template=package .
	
ce:
	flutter create example

clean:
	@echo "╠ Cleaning the project & pub get..."
	@cd example 
	@rm -rf pubspec.lock 
	@flutter clean
	@cd ..
	@rm -rf pubspec.lock 
	@flutter clean
	@flutter pub get 

gen:
	dart run build_runner build --delete-conflicting-outputs

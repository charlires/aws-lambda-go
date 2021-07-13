<!-- build:
	@echo ":: Generating Deployment Package ::"
	@cd .; GOOS=linux go build -o ../bin/main
	@cd ../deployment; zip -rj function.zip ../bin/main
	@echo ":: Done! ::" -->
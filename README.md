# aws-lambda-go
AWS Lambda, IaC with Terraform, Written in Golan

<!-- build:
	@echo ":: Generating Deployment Package ::"
	@cd .; GOOS=linux go build -o ../bin/main
	@cd ../deployment; zip -rj function.zip ../bin/main
	@echo ":: Done! ::" -->
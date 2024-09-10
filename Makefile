SCRIPT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

cli:
	@echo "Checking if CLIs are installed..."
	@if dart pub global list | grep -q 'pipeline'; then \
		echo "Pipeline CLI is already installed. Reinstalling..."; \
		dart pub global deactivate pipeline; \
	else \
		echo "Pipeline CLI not installed. Installing..."; \
	fi
	@dart pub global activate -s path $(SCRIPT_DIR)/pipeline_cli
	@make print_success


print_success:
	@echo ""
	@echo "-----------------------------------------------"
	@echo "*** Success! ***"
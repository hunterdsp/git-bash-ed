ARTIFACT = git-bash-ed.tar.gz
TESTHELPER_PATH = test/test_helper
REPORT_PATH = test-results
SONARQUBE_PATH = ./gcovr
TOJUNIT = $(TESTHELPER_PATH)/checkstyle2junit.xslt
.PHONY: lint
lint:
	shellcheck -f checkstyle src/*.sh | 
		xmlstarlet tr $(TOJUNIT) > $(REPORT_PATH)/shellcheck.xml

.PHONY: build
build:
	mkdir $(REPORT_PATH)

# Use kcov to run bats and compute coverage
.PHONY: test
test:
	kcov \
		--dump-summary \
		--include-pattern=/src \
		--exclude-pattern=/test \
		$(REPORT_PATH)/coverage \
		/bin/bats test
	mkdir -p $(SONARQUBE_PATH)
	cp $(REPORT_PATH)/coverage/bats.*/sonarqube.xml $(SONARQUBE_PATH)/sonarqube-report.xml
	tar -cvzf $(ARTIFACT) src $(REPORT_PATH)
	rm -f $(TESTHELPER_PATH)/bats-*/*.json

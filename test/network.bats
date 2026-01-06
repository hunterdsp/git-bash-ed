load 'test_helper/common-setup'
source 'src/network.sh'
_common_setup

@test 'test-internet-access help' {
	run test-internet-access -h
	# shellcheck disable=SC2154
	assert_output --regexp "${HELP_REGEX}"
}

@test 'test-internet-access' {
	run test-internet-access
	assert_success
}

@test 'test-internet-access -v' {
	run test-internet-access -v
	assert_success
}

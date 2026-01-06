load 'test_helper/common-setup'
source 'src/file.sh'
_common_setup

setup() {
	TEMPFILE=$(mktemp /tmp/tmp.XXXXXXXXXX)
	FROMPATH=$(mktemp /tmp/tmp.XXXXXXXXXX)
	TOPATH=$(mktemp /tmp/tmp.XXXXXXXXXX)
	cat <<-EOF >"$FROMPATH"
		APPLE
		BANANA

		AVOCADO

		PLUM
	EOF
}

@test 'add-line unknown option -k' {
	run add-line -k
	assert_output --regexp "$(
		echo "Invalid option: -k" &
		# shellcheck disable=SC2154
		echo "${HELP_REGEX}"
	)"
}

@test 'add-line no input' {
	run add-line
	# shellcheck disable=SC2154
	assert_output --regexp "Not enough arguments.*\n*${HELP_REGEX:1}"
}

@test 'add-line path' {
	run add-line "${TEMPFILE}"
	run add-line "${TEMPFILE}"
	run add-line "${TEMPFILE}"
	assert_equal "$(grep -c "^$" "${TEMPFILE}")" 3
}

@test 'remove-line path' {
	run remove-line "${TEMPFILE}"
	run remove-line "${TEMPFILE}"
	run remove-line "${TEMPFILE}"
	assert_equal "$(grep -c "^$" "${TEMPFILE}")" 0
}

@test 'add-line path no blanks' {
	run add-line -x "${TEMPFILE}"
	run add-line -x "${TEMPFILE}"
	run add-line -x "${TEMPFILE}"
	run add-line -x "${TEMPFILE}"
	assert_equal "$(grep -c "^$" "${TEMPFILE}")" 1
}

@test 'add-line entry path' {
	run add-line 'ENTRY' "${TEMPFILE}"
	run bash -c "awk '/^ENTRY$/' ${TEMPFILE} | grep ."
	assert_success
}

@test 'remove-line -h' {
	run remove-line -h
	# shellcheck disable=SC2154
	assert_output --regexp "${HELP_REGEX}"
}

@test 'remove-line unknown option -k' {
	run remove-line -k
	assert_output --regexp "$(
		echo "Invalid option: -k" &
		# shellcheck disable=SC2154
		echo "${HELP_REGEX}"
	)"
}

@test 'remove-line no input' {
	run remove-line
	# shellcheck disable=SC2154
	assert_output --regexp "Not enough arguments.*\n*${HELP_REGEX:1}"
}

@test 'remove-line entry' {
	run remove-line 'MY_NEW_LINE' "${TEMPFILE}"
	run bash -c "awk '/^MY_NEW_LINE$/' ${TEMPFILE} | grep ."
	assert_failure
}

@test 'add-contents' {
	run add-contents "${FROMPATH}" "${TOPATH}"
	run bash -c "diff -q ${FROMPATH} ${TOPATH} >/dev/null"
	assert_success
}

@test 'add-contents twice' {
	run add-contents "${FROMPATH}" "${TOPATH}"
	run bash -c "diff ${FROMPATH} ${TOPATH}"
	assert_success
}

teardown() {
	rm -f "${TEMPFILE}"
	rm -f "${FROMPATH}"
	rm -f "${TOPATH}"
}

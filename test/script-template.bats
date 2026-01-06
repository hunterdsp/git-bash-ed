load 'test_helper/common-setup'
_common_setup

EXPECTED_HELP=$(
	cat <<'EOF'
Usage: script-template [OPTIONS] [-p PARAM] [ARGS] ...

  Script Title and Short Summary.

Options:
  -h         Show this message and exit.
  -p PARAM   Option that accepts an argument stored in $OPTARG.
  -v         Show the version and exit.

Arguments:
  MYCMD      Some command or other stored in $1
  MYVAR      Some variable or other stored in $2
Cleaning up!!!
EOF
)
EXPECTED_UNKNOWN=$(
	cat <<EOF
Invalid option: -u
${EXPECTED_HELP}
EOF
)

@test "unknown option -u" {
	run script-template -u
	echo "${EXPECTED_UNKNOWN}" | assert_output -
}

@test "option -h" {
	run script-template -h
	echo "${EXPECTED_HELP}" | assert_output -
}

@test "option -v" {
	run script-template -v
	assert_output - <<-EOF
		X.Y.Z
		Cleaning up!!!
	EOF
}

@test "option -p myparam" {
	run script-template -p myparam
	assert_output - <<-EOF
		Option -p specified with argument: myparam
		Cleaning up!!!
	EOF
}

@test "command" {
	run script-template SOMECMD
	assert_output - <<-EOF
		Executing somecmd()
		Cleaning up!!!
	EOF
}

@test "positional args" {
	run script-template myarg1 myarg2 myarg3
	assert_output - <<-'EOF'
		Processing argument: myarg1 from $@ in a loop
		Processing argument: myarg2 from $@ in a loop
		Processing argument: myarg3 from $@ in a loop
		Cleaning up!!!
	EOF
}

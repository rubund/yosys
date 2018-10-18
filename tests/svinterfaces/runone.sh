#!/bin/bash -e


TESTNAME=$1

STDOUTFILE=${TESTNAME}.log_stdout
STDERRFILE=${TESTNAME}.log_stderr

echo "" > $STDOUTFILE
echo "" > $STDERRFILE

echo -n "Test: ${TESTNAME} -> "

$PWD/../../yosys -p "read_verilog -sv ${TESTNAME}.sv ; hierarchy -check -top TopModule ; synth ; write_verilog ${TESTNAME}_syn.v" >> $STDOUTFILE >> $STDERRFILE
$PWD/../../yosys -p "read_verilog -sv ${TESTNAME}_ref.v ; hierarchy -check -top TopModule ; synth ; write_verilog ${TESTNAME}_ref_syn.v" >> $STDOUTFILE >> $STDERRFILE

iverilog -g2012 ${TESTNAME}_syn.v
iverilog -g2012 ${TESTNAME}_ref_syn.v

iverilog -g2012 ${TESTNAME}_tb.v ${TESTNAME}_ref_syn.v
./a.out
mv output.txt reference_result.txt
iverilog -g2012 ${TESTNAME}_tb.v ${TESTNAME}_syn.v
./a.out
mv output.txt dut_result.txt

diff reference_result.txt dut_result.txt
RET=$?
if [ "$RET" != "0" ] ; then
    echo "failed"
    exit -1
fi

echo "ok"
exit 0

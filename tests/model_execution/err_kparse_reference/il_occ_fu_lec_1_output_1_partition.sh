#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

set -e
set -o pipefail

error_handler(){
    echo 'Run Error - terminating, see the log dir for details'
    proc_group_id=$(ps -p $$ -o pgid --no-headers)
    pgrep -a --pgroup $proc_group_id >> log/killout.txt
    pkill -9 --pgroup $proc_group_id
}
trap error_handler QUIT HUP INT KILL TERM ERR

mkdir -p log
rm -R -f log/*
touch log/stderror.err
ktools_monitor.sh $$ & pid0=$!

# --- Setup run dirs ---

find output/* ! -name '*summary-info*' -type f -exec rm -f {} +

rm -R -f fifo/*
rm -R -f work/*
mkdir work/kat
mkfifo fifo/il_P1
mkfifo fifo/il_S1_summary_P1

mkdir work/il_S1_summaryleccalc

# --- Do insured loss computes ---


tee < fifo/il_S1_summary_P1 work/il_S1_summaryleccalc/P1.bin > /dev/null & pid1=$!

( summarycalc -f  -1 fifo/il_S1_summary_P1 < fifo/il_P1 ) 2>> log/stderror.err  &

( eve 1 1 | getmodel | gulcalc -S100 -L100 -r -a1 -i - | fmcalc -a2 > fifo/il_P1  ) 2>> log/stderror.err &

wait $pid1


# --- Do insured loss kats ---


leccalc -r -Kil_S1_summaryleccalc -f output/il_S1_leccalc_full_uncertainty_oep.csv & lpid1=$!
wait $lpid1

rm -R -f work/*
rm -R -f fifo/*

# Stop ktools watcher
kill -9 $pid0

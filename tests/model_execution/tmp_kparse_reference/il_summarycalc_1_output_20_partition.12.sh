#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +

rm -R -f /tmp/%FIFO_DIR%/fifo/*
rm -R -f work/*
mkdir work/kat/


mkfifo /tmp/%FIFO_DIR%/fifo/il_P13

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P13
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P13



# --- Do insured loss computes ---
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P13 > work/kat/il_S1_summarycalc_P13 & pid1=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P13 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P13 > /dev/null & pid2=$!
summarycalc -m -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P13 < /tmp/%FIFO_DIR%/fifo/il_P13 &

eve 13 20 | getmodel | gulcalc -S100 -L100 -r -a1 -i - | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P13  &

wait $pid1 $pid2


# --- Do insured loss kats ---

kat work/kat/il_S1_summarycalc_P13 > output/il_S1_summarycalc.csv & kpid1=$!
wait $kpid1


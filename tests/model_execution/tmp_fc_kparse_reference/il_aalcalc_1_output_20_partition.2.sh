#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +
mkdir output/full_correlation/

rm -R -f /tmp/%FIFO_DIR%/fifo/*
mkdir /tmp/%FIFO_DIR%/fifo/full_correlation/
rm -R -f work/*
mkdir work/kat/
mkdir work/full_correlation/
mkdir work/full_correlation/kat/

mkdir work/il_S1_summaryaalcalc
mkdir work/full_correlation/il_S1_summaryaalcalc

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P3

mkfifo /tmp/%FIFO_DIR%/fifo/il_P3

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P3

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_P3

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P3



# --- Do insured loss computes ---
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P3 work/il_S1_summaryaalcalc/P3.bin > /dev/null & pid1=$!
summarycalc -m -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P3 < /tmp/%FIFO_DIR%/fifo/il_P3 &

# --- Do insured loss computes ---
tee < /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P3 work/full_correlation/il_S1_summaryaalcalc/P3.bin > /dev/null & pid2=$!
summarycalc -m -f  -1 /tmp/%FIFO_DIR%/fifo/full_correlation/il_S1_summary_P3 < /tmp/%FIFO_DIR%/fifo/full_correlation/il_P3 &

fmcalc -a2 < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P3 > /tmp/%FIFO_DIR%/fifo/full_correlation/il_P3 &
eve 3 20 | getmodel | gulcalc -S100 -L100 -r -j /tmp/%FIFO_DIR%/fifo/full_correlation/gul_fc_P3 -a1 -i - | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P3  &

wait $pid1 $pid2


# --- Do insured loss kats ---


# --- Do insured loss kats for fully correlated output ---


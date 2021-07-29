#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +

rm -R -f fifo/*
rm -R -f work/*
mkdir work/kat/

mkdir work/il_S1_summaryaalcalc

mkfifo fifo/il_P12

mkfifo fifo/il_S1_summary_P12



# --- Do insured loss computes ---
tee < fifo/il_S1_summary_P12 work/il_S1_summaryaalcalc/P12.bin > /dev/null & pid1=$!
summarycalc -m -f  -1 fifo/il_S1_summary_P12 < fifo/il_P12 &

eve 12 20 | getmodel | gulcalc -S100 -L100 -r -i - | fmcalc -a2 > fifo/il_P12  &

wait $pid1


# --- Do insured loss kats ---


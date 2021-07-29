#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +
mkdir output/full_correlation/

rm -R -f fifo/*
mkdir fifo/full_correlation/
rm -R -f work/*
mkdir work/kat/
mkdir work/full_correlation/
mkdir work/full_correlation/kat/


mkfifo fifo/full_correlation/gul_fc_P9

mkfifo fifo/il_P9

mkfifo fifo/il_S1_summary_P9
mkfifo fifo/il_S1_summarycalc_P9

mkfifo fifo/full_correlation/il_P9

mkfifo fifo/full_correlation/il_S1_summary_P9
mkfifo fifo/full_correlation/il_S1_summarycalc_P9



# --- Do insured loss computes ---
summarycalctocsv -s < fifo/il_S1_summarycalc_P9 > work/kat/il_S1_summarycalc_P9 & pid1=$!
tee < fifo/il_S1_summary_P9 fifo/il_S1_summarycalc_P9 > /dev/null & pid2=$!
summarycalc -m -f  -1 fifo/il_S1_summary_P9 < fifo/il_P9 &

# --- Do insured loss computes ---
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P9 > work/full_correlation/kat/il_S1_summarycalc_P9 & pid3=$!
tee < fifo/full_correlation/il_S1_summary_P9 fifo/full_correlation/il_S1_summarycalc_P9 > /dev/null & pid4=$!
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P9 < fifo/full_correlation/il_P9 &

fmcalc -a2 < fifo/full_correlation/gul_fc_P9 > fifo/full_correlation/il_P9 &
eve 9 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P9 -a1 -i - | fmcalc -a2 > fifo/il_P9  &

wait $pid1 $pid2 $pid3 $pid4


# --- Do insured loss kats ---

kat work/kat/il_S1_summarycalc_P9 > output/il_S1_summarycalc.csv & kpid1=$!

# --- Do insured loss kats for fully correlated output ---

kat work/full_correlation/kat/il_S1_summarycalc_P9 > output/full_correlation/il_S1_summarycalc.csv & kpid2=$!
wait $kpid1 $kpid2


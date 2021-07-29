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


mkfifo fifo/gul_P5

mkfifo fifo/gul_S1_summary_P5
mkfifo fifo/gul_S1_pltcalc_P5



# --- Do ground up loss computes ---
pltcalc -s < fifo/gul_S1_pltcalc_P5 > work/kat/gul_S1_pltcalc_P5 & pid1=$!
tee < fifo/gul_S1_summary_P5 fifo/gul_S1_pltcalc_P5 > /dev/null & pid2=$!
summarycalc -m -i  -1 fifo/gul_S1_summary_P5 < fifo/gul_P5 &

eve 5 20 | getmodel | gulcalc -S100 -L100 -r -a1 -i - > fifo/gul_P5  &

wait $pid1 $pid2


# --- Do ground up loss kats ---

kat work/kat/gul_S1_pltcalc_P5 > output/gul_S1_pltcalc.csv & kpid1=$!
wait $kpid1


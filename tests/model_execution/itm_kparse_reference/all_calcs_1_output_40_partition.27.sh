#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---
set -euET -o pipefail
shopt -s inherit_errexit 2>/dev/null || echo "WARNING: Unable to set inherit_errexit. Possibly unsupported by this shell, Subprocess failures may not be detected."

LOG_DIR=log
mkdir -p $LOG_DIR
rm -R -f $LOG_DIR/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +

find fifo/ \( -name '*P28[^0-9]*' -o -name '*P28' \) -exec rm -R -f {} +
rm -R -f work/*
mkdir -p work/kat/

mkdir -p work/gul_S1_summaryleccalc
mkdir -p work/gul_S1_summaryaalcalc
mkdir -p work/il_S1_summaryleccalc
mkdir -p work/il_S1_summaryaalcalc

mkfifo fifo/gul_P28

mkfifo fifo/gul_S1_summary_P28
mkfifo fifo/gul_S1_summary_P28.idx
mkfifo fifo/gul_S1_eltcalc_P28
mkfifo fifo/gul_S1_summarycalc_P28
mkfifo fifo/gul_S1_pltcalc_P28

mkfifo fifo/il_P28

mkfifo fifo/il_S1_summary_P28
mkfifo fifo/il_S1_summary_P28.idx
mkfifo fifo/il_S1_eltcalc_P28
mkfifo fifo/il_S1_summarycalc_P28
mkfifo fifo/il_S1_pltcalc_P28



# --- Do insured loss computes ---
eltcalc -s < fifo/il_S1_eltcalc_P28 > work/kat/il_S1_eltcalc_P28 & pid1=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P28 > work/kat/il_S1_summarycalc_P28 & pid2=$!
pltcalc -H < fifo/il_S1_pltcalc_P28 > work/kat/il_S1_pltcalc_P28 & pid3=$!
tee < fifo/il_S1_summary_P28 fifo/il_S1_eltcalc_P28 fifo/il_S1_summarycalc_P28 fifo/il_S1_pltcalc_P28 work/il_S1_summaryaalcalc/P28.bin work/il_S1_summaryleccalc/P28.bin > /dev/null & pid4=$!
tee < fifo/il_S1_summary_P28.idx work/il_S1_summaryaalcalc/P28.idx work/il_S1_summaryleccalc/P28.idx > /dev/null & pid5=$!
summarycalc -m -f  -1 fifo/il_S1_summary_P28 < fifo/il_P28 &

# --- Do ground up loss computes ---
eltcalc -s < fifo/gul_S1_eltcalc_P28 > work/kat/gul_S1_eltcalc_P28 & pid6=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P28 > work/kat/gul_S1_summarycalc_P28 & pid7=$!
pltcalc -H < fifo/gul_S1_pltcalc_P28 > work/kat/gul_S1_pltcalc_P28 & pid8=$!
tee < fifo/gul_S1_summary_P28 fifo/gul_S1_eltcalc_P28 fifo/gul_S1_summarycalc_P28 fifo/gul_S1_pltcalc_P28 work/gul_S1_summaryaalcalc/P28.bin work/gul_S1_summaryleccalc/P28.bin > /dev/null & pid9=$!
tee < fifo/gul_S1_summary_P28.idx work/gul_S1_summaryaalcalc/P28.idx work/gul_S1_summaryleccalc/P28.idx > /dev/null & pid10=$!
summarycalc -m -i  -1 fifo/gul_S1_summary_P28 < fifo/gul_P28 &

( eve 28 40 | getmodel | gulcalc -S100 -L100 -r -a1 -i - | tee fifo/gul_P28 | fmcalc -a2 > fifo/il_P28  ) & pid11=$!

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11


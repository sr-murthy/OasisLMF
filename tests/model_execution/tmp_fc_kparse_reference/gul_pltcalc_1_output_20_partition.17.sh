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


mkfifo /tmp/%FIFO_DIR%/fifo/gul_P18

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P18
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P18

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P18

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P18
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_pltcalc_P18



# --- Do ground up loss computes ---
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P18 > work/kat/gul_S1_pltcalc_P18 & pid1=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P18 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P18 > /dev/null & pid2=$!
summarycalc -m -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P18 < /tmp/%FIFO_DIR%/fifo/gul_P18 &

# --- Do ground up loss computes ---
pltcalc -s < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_pltcalc_P18 > work/full_correlation/kat/gul_S1_pltcalc_P18 & pid3=$!
tee < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P18 /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_pltcalc_P18 > /dev/null & pid4=$!
summarycalc -m -i  -1 /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P18 < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P18 &

eve 18 20 | getmodel | gulcalc -S100 -L100 -r -j /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P18 -a1 -i - > /tmp/%FIFO_DIR%/fifo/gul_P18  &

wait $pid1 $pid2 $pid3 $pid4


# --- Do ground up loss kats ---

kat work/kat/gul_S1_pltcalc_P18 > output/gul_S1_pltcalc.csv & kpid1=$!

# --- Do ground up loss kats for fully correlated output ---

kat work/full_correlation/kat/gul_S1_pltcalc_P18 > output/full_correlation/gul_S1_pltcalc.csv & kpid2=$!
wait $kpid1 $kpid2


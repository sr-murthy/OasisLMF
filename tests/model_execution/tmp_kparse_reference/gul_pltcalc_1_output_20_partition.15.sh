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


mkfifo /tmp/%FIFO_DIR%/fifo/gul_P16

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P16
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P16



# --- Do ground up loss computes ---
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P16 > work/kat/gul_S1_pltcalc_P16 & pid1=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P16 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P16 > /dev/null & pid2=$!
summarycalc -m -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P16 < /tmp/%FIFO_DIR%/fifo/gul_P16 &

eve 16 20 | getmodel | gulcalc -S100 -L100 -r -a1 -i - > /tmp/%FIFO_DIR%/fifo/gul_P16  &

wait $pid1 $pid2


# --- Do ground up loss kats ---

kat work/kat/gul_S1_pltcalc_P16 > output/gul_S1_pltcalc.csv & kpid1=$!
wait $kpid1


#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

set -e
set -o pipefail
mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output/* ! -name '*summary-info*' -exec rm -R -f {} +

rm -R -f work/*
mkdir work/kat/

rm -R -f /tmp/%FIFO_DIR%/
mkdir -p /tmp/%FIFO_DIR%/fifo/
mkdir work/gul_S1_summaryleccalc
mkdir work/gul_S1_summaryaalcalc
mkdir work/gul_S2_summaryleccalc
mkdir work/gul_S2_summaryaalcalc
mkdir work/il_S1_summaryleccalc
mkdir work/il_S1_summaryaalcalc
mkdir work/il_S2_summaryleccalc
mkdir work/il_S2_summaryaalcalc

mkfifo /tmp/%FIFO_DIR%/fifo/gul_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P3
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P4
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P5
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P6
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P7
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P8
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P9
mkfifo /tmp/%FIFO_DIR%/fifo/gul_P10

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P1

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P2

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P3
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P3
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P3

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P4
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P4
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P4

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P5
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P5
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P5

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P6
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P6
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P6

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P7
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P7
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P7

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P8
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P8
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P8

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P9
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P9
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P9

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P10
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P10
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P10

mkfifo /tmp/%FIFO_DIR%/fifo/il_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_P2
mkfifo /tmp/%FIFO_DIR%/fifo/il_P3
mkfifo /tmp/%FIFO_DIR%/fifo/il_P4
mkfifo /tmp/%FIFO_DIR%/fifo/il_P5
mkfifo /tmp/%FIFO_DIR%/fifo/il_P6
mkfifo /tmp/%FIFO_DIR%/fifo/il_P7
mkfifo /tmp/%FIFO_DIR%/fifo/il_P8
mkfifo /tmp/%FIFO_DIR%/fifo/il_P9
mkfifo /tmp/%FIFO_DIR%/fifo/il_P10

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P1
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P1

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P2
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P2
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P2

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P3
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P3
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P3
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P3

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P4
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P4
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P4
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P4

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P5
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P5
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P5
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P5

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P6
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P6
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P6
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P6

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P7
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P7
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P7
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P7

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P8
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P8
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P8
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P8

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P9
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P9
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P9
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P9

mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summary_P10
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summary_P10
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P10
mkfifo /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P10



# --- Do insured loss computes ---

eltcalc < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P1 > work/kat/il_S1_eltcalc_P1 & pid1=$!
summarycalctocsv < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P1 > work/kat/il_S1_summarycalc_P1 & pid2=$!
pltcalc < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P1 > work/kat/il_S1_pltcalc_P1 & pid3=$!
eltcalc < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P1 > work/kat/il_S2_eltcalc_P1 & pid4=$!
summarycalctocsv < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P1 > work/kat/il_S2_summarycalc_P1 & pid5=$!
pltcalc < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P1 > work/kat/il_S2_pltcalc_P1 & pid6=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P2 > work/kat/il_S1_eltcalc_P2 & pid7=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P2 > work/kat/il_S1_summarycalc_P2 & pid8=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P2 > work/kat/il_S1_pltcalc_P2 & pid9=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P2 > work/kat/il_S2_eltcalc_P2 & pid10=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P2 > work/kat/il_S2_summarycalc_P2 & pid11=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P2 > work/kat/il_S2_pltcalc_P2 & pid12=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P3 > work/kat/il_S1_eltcalc_P3 & pid13=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P3 > work/kat/il_S1_summarycalc_P3 & pid14=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P3 > work/kat/il_S1_pltcalc_P3 & pid15=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P3 > work/kat/il_S2_eltcalc_P3 & pid16=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P3 > work/kat/il_S2_summarycalc_P3 & pid17=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P3 > work/kat/il_S2_pltcalc_P3 & pid18=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P4 > work/kat/il_S1_eltcalc_P4 & pid19=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P4 > work/kat/il_S1_summarycalc_P4 & pid20=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P4 > work/kat/il_S1_pltcalc_P4 & pid21=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P4 > work/kat/il_S2_eltcalc_P4 & pid22=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P4 > work/kat/il_S2_summarycalc_P4 & pid23=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P4 > work/kat/il_S2_pltcalc_P4 & pid24=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P5 > work/kat/il_S1_eltcalc_P5 & pid25=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P5 > work/kat/il_S1_summarycalc_P5 & pid26=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P5 > work/kat/il_S1_pltcalc_P5 & pid27=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P5 > work/kat/il_S2_eltcalc_P5 & pid28=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P5 > work/kat/il_S2_summarycalc_P5 & pid29=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P5 > work/kat/il_S2_pltcalc_P5 & pid30=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P6 > work/kat/il_S1_eltcalc_P6 & pid31=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P6 > work/kat/il_S1_summarycalc_P6 & pid32=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P6 > work/kat/il_S1_pltcalc_P6 & pid33=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P6 > work/kat/il_S2_eltcalc_P6 & pid34=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P6 > work/kat/il_S2_summarycalc_P6 & pid35=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P6 > work/kat/il_S2_pltcalc_P6 & pid36=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P7 > work/kat/il_S1_eltcalc_P7 & pid37=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P7 > work/kat/il_S1_summarycalc_P7 & pid38=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P7 > work/kat/il_S1_pltcalc_P7 & pid39=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P7 > work/kat/il_S2_eltcalc_P7 & pid40=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P7 > work/kat/il_S2_summarycalc_P7 & pid41=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P7 > work/kat/il_S2_pltcalc_P7 & pid42=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P8 > work/kat/il_S1_eltcalc_P8 & pid43=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P8 > work/kat/il_S1_summarycalc_P8 & pid44=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P8 > work/kat/il_S1_pltcalc_P8 & pid45=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P8 > work/kat/il_S2_eltcalc_P8 & pid46=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P8 > work/kat/il_S2_summarycalc_P8 & pid47=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P8 > work/kat/il_S2_pltcalc_P8 & pid48=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P9 > work/kat/il_S1_eltcalc_P9 & pid49=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P9 > work/kat/il_S1_summarycalc_P9 & pid50=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P9 > work/kat/il_S1_pltcalc_P9 & pid51=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P9 > work/kat/il_S2_eltcalc_P9 & pid52=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P9 > work/kat/il_S2_summarycalc_P9 & pid53=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P9 > work/kat/il_S2_pltcalc_P9 & pid54=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P10 > work/kat/il_S1_eltcalc_P10 & pid55=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P10 > work/kat/il_S1_summarycalc_P10 & pid56=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P10 > work/kat/il_S1_pltcalc_P10 & pid57=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P10 > work/kat/il_S2_eltcalc_P10 & pid58=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P10 > work/kat/il_S2_summarycalc_P10 & pid59=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P10 > work/kat/il_S2_pltcalc_P10 & pid60=$!

tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P1 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P1 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P1 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P1 work/il_S1_summaryaalcalc/P1.bin work/il_S1_summaryleccalc/P1.bin > /dev/null & pid61=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P1 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P1 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P1 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P1 work/il_S2_summaryaalcalc/P1.bin work/il_S2_summaryleccalc/P1.bin > /dev/null & pid62=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P2 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P2 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P2 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P2 work/il_S1_summaryaalcalc/P2.bin work/il_S1_summaryleccalc/P2.bin > /dev/null & pid63=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P2 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P2 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P2 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P2 work/il_S2_summaryaalcalc/P2.bin work/il_S2_summaryleccalc/P2.bin > /dev/null & pid64=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P3 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P3 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P3 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P3 work/il_S1_summaryaalcalc/P3.bin work/il_S1_summaryleccalc/P3.bin > /dev/null & pid65=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P3 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P3 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P3 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P3 work/il_S2_summaryaalcalc/P3.bin work/il_S2_summaryleccalc/P3.bin > /dev/null & pid66=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P4 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P4 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P4 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P4 work/il_S1_summaryaalcalc/P4.bin work/il_S1_summaryleccalc/P4.bin > /dev/null & pid67=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P4 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P4 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P4 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P4 work/il_S2_summaryaalcalc/P4.bin work/il_S2_summaryleccalc/P4.bin > /dev/null & pid68=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P5 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P5 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P5 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P5 work/il_S1_summaryaalcalc/P5.bin work/il_S1_summaryleccalc/P5.bin > /dev/null & pid69=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P5 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P5 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P5 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P5 work/il_S2_summaryaalcalc/P5.bin work/il_S2_summaryleccalc/P5.bin > /dev/null & pid70=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P6 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P6 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P6 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P6 work/il_S1_summaryaalcalc/P6.bin work/il_S1_summaryleccalc/P6.bin > /dev/null & pid71=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P6 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P6 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P6 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P6 work/il_S2_summaryaalcalc/P6.bin work/il_S2_summaryleccalc/P6.bin > /dev/null & pid72=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P7 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P7 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P7 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P7 work/il_S1_summaryaalcalc/P7.bin work/il_S1_summaryleccalc/P7.bin > /dev/null & pid73=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P7 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P7 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P7 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P7 work/il_S2_summaryaalcalc/P7.bin work/il_S2_summaryleccalc/P7.bin > /dev/null & pid74=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P8 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P8 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P8 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P8 work/il_S1_summaryaalcalc/P8.bin work/il_S1_summaryleccalc/P8.bin > /dev/null & pid75=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P8 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P8 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P8 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P8 work/il_S2_summaryaalcalc/P8.bin work/il_S2_summaryleccalc/P8.bin > /dev/null & pid76=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P9 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P9 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P9 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P9 work/il_S1_summaryaalcalc/P9.bin work/il_S1_summaryleccalc/P9.bin > /dev/null & pid77=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P9 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P9 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P9 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P9 work/il_S2_summaryaalcalc/P9.bin work/il_S2_summaryleccalc/P9.bin > /dev/null & pid78=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S1_summary_P10 /tmp/%FIFO_DIR%/fifo/il_S1_eltcalc_P10 /tmp/%FIFO_DIR%/fifo/il_S1_summarycalc_P10 /tmp/%FIFO_DIR%/fifo/il_S1_pltcalc_P10 work/il_S1_summaryaalcalc/P10.bin work/il_S1_summaryleccalc/P10.bin > /dev/null & pid79=$!
tee < /tmp/%FIFO_DIR%/fifo/il_S2_summary_P10 /tmp/%FIFO_DIR%/fifo/il_S2_eltcalc_P10 /tmp/%FIFO_DIR%/fifo/il_S2_summarycalc_P10 /tmp/%FIFO_DIR%/fifo/il_S2_pltcalc_P10 work/il_S2_summaryaalcalc/P10.bin work/il_S2_summaryleccalc/P10.bin > /dev/null & pid80=$!

summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P1 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P1 < /tmp/%FIFO_DIR%/fifo/il_P1 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P2 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P2 < /tmp/%FIFO_DIR%/fifo/il_P2 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P3 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P3 < /tmp/%FIFO_DIR%/fifo/il_P3 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P4 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P4 < /tmp/%FIFO_DIR%/fifo/il_P4 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P5 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P5 < /tmp/%FIFO_DIR%/fifo/il_P5 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P6 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P6 < /tmp/%FIFO_DIR%/fifo/il_P6 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P7 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P7 < /tmp/%FIFO_DIR%/fifo/il_P7 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P8 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P8 < /tmp/%FIFO_DIR%/fifo/il_P8 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P9 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P9 < /tmp/%FIFO_DIR%/fifo/il_P9 &
summarycalc -f  -1 /tmp/%FIFO_DIR%/fifo/il_S1_summary_P10 -2 /tmp/%FIFO_DIR%/fifo/il_S2_summary_P10 < /tmp/%FIFO_DIR%/fifo/il_P10 &

# --- Do ground up loss computes ---

eltcalc < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P1 > work/kat/gul_S1_eltcalc_P1 & pid81=$!
summarycalctocsv < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P1 > work/kat/gul_S1_summarycalc_P1 & pid82=$!
pltcalc < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P1 > work/kat/gul_S1_pltcalc_P1 & pid83=$!
eltcalc < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P1 > work/kat/gul_S2_eltcalc_P1 & pid84=$!
summarycalctocsv < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P1 > work/kat/gul_S2_summarycalc_P1 & pid85=$!
pltcalc < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P1 > work/kat/gul_S2_pltcalc_P1 & pid86=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P2 > work/kat/gul_S1_eltcalc_P2 & pid87=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P2 > work/kat/gul_S1_summarycalc_P2 & pid88=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P2 > work/kat/gul_S1_pltcalc_P2 & pid89=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P2 > work/kat/gul_S2_eltcalc_P2 & pid90=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P2 > work/kat/gul_S2_summarycalc_P2 & pid91=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P2 > work/kat/gul_S2_pltcalc_P2 & pid92=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P3 > work/kat/gul_S1_eltcalc_P3 & pid93=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P3 > work/kat/gul_S1_summarycalc_P3 & pid94=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P3 > work/kat/gul_S1_pltcalc_P3 & pid95=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P3 > work/kat/gul_S2_eltcalc_P3 & pid96=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P3 > work/kat/gul_S2_summarycalc_P3 & pid97=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P3 > work/kat/gul_S2_pltcalc_P3 & pid98=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P4 > work/kat/gul_S1_eltcalc_P4 & pid99=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P4 > work/kat/gul_S1_summarycalc_P4 & pid100=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P4 > work/kat/gul_S1_pltcalc_P4 & pid101=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P4 > work/kat/gul_S2_eltcalc_P4 & pid102=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P4 > work/kat/gul_S2_summarycalc_P4 & pid103=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P4 > work/kat/gul_S2_pltcalc_P4 & pid104=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P5 > work/kat/gul_S1_eltcalc_P5 & pid105=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P5 > work/kat/gul_S1_summarycalc_P5 & pid106=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P5 > work/kat/gul_S1_pltcalc_P5 & pid107=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P5 > work/kat/gul_S2_eltcalc_P5 & pid108=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P5 > work/kat/gul_S2_summarycalc_P5 & pid109=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P5 > work/kat/gul_S2_pltcalc_P5 & pid110=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P6 > work/kat/gul_S1_eltcalc_P6 & pid111=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P6 > work/kat/gul_S1_summarycalc_P6 & pid112=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P6 > work/kat/gul_S1_pltcalc_P6 & pid113=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P6 > work/kat/gul_S2_eltcalc_P6 & pid114=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P6 > work/kat/gul_S2_summarycalc_P6 & pid115=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P6 > work/kat/gul_S2_pltcalc_P6 & pid116=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P7 > work/kat/gul_S1_eltcalc_P7 & pid117=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P7 > work/kat/gul_S1_summarycalc_P7 & pid118=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P7 > work/kat/gul_S1_pltcalc_P7 & pid119=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P7 > work/kat/gul_S2_eltcalc_P7 & pid120=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P7 > work/kat/gul_S2_summarycalc_P7 & pid121=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P7 > work/kat/gul_S2_pltcalc_P7 & pid122=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P8 > work/kat/gul_S1_eltcalc_P8 & pid123=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P8 > work/kat/gul_S1_summarycalc_P8 & pid124=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P8 > work/kat/gul_S1_pltcalc_P8 & pid125=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P8 > work/kat/gul_S2_eltcalc_P8 & pid126=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P8 > work/kat/gul_S2_summarycalc_P8 & pid127=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P8 > work/kat/gul_S2_pltcalc_P8 & pid128=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P9 > work/kat/gul_S1_eltcalc_P9 & pid129=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P9 > work/kat/gul_S1_summarycalc_P9 & pid130=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P9 > work/kat/gul_S1_pltcalc_P9 & pid131=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P9 > work/kat/gul_S2_eltcalc_P9 & pid132=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P9 > work/kat/gul_S2_summarycalc_P9 & pid133=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P9 > work/kat/gul_S2_pltcalc_P9 & pid134=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P10 > work/kat/gul_S1_eltcalc_P10 & pid135=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P10 > work/kat/gul_S1_summarycalc_P10 & pid136=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P10 > work/kat/gul_S1_pltcalc_P10 & pid137=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P10 > work/kat/gul_S2_eltcalc_P10 & pid138=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P10 > work/kat/gul_S2_summarycalc_P10 & pid139=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P10 > work/kat/gul_S2_pltcalc_P10 & pid140=$!

tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P1 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P1 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P1 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P1 work/gul_S1_summaryaalcalc/P1.bin work/gul_S1_summaryleccalc/P1.bin > /dev/null & pid141=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P1 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P1 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P1 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P1 work/gul_S2_summaryaalcalc/P1.bin work/gul_S2_summaryleccalc/P1.bin > /dev/null & pid142=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P2 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P2 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P2 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P2 work/gul_S1_summaryaalcalc/P2.bin work/gul_S1_summaryleccalc/P2.bin > /dev/null & pid143=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P2 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P2 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P2 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P2 work/gul_S2_summaryaalcalc/P2.bin work/gul_S2_summaryleccalc/P2.bin > /dev/null & pid144=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P3 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P3 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P3 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P3 work/gul_S1_summaryaalcalc/P3.bin work/gul_S1_summaryleccalc/P3.bin > /dev/null & pid145=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P3 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P3 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P3 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P3 work/gul_S2_summaryaalcalc/P3.bin work/gul_S2_summaryleccalc/P3.bin > /dev/null & pid146=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P4 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P4 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P4 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P4 work/gul_S1_summaryaalcalc/P4.bin work/gul_S1_summaryleccalc/P4.bin > /dev/null & pid147=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P4 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P4 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P4 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P4 work/gul_S2_summaryaalcalc/P4.bin work/gul_S2_summaryleccalc/P4.bin > /dev/null & pid148=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P5 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P5 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P5 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P5 work/gul_S1_summaryaalcalc/P5.bin work/gul_S1_summaryleccalc/P5.bin > /dev/null & pid149=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P5 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P5 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P5 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P5 work/gul_S2_summaryaalcalc/P5.bin work/gul_S2_summaryleccalc/P5.bin > /dev/null & pid150=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P6 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P6 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P6 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P6 work/gul_S1_summaryaalcalc/P6.bin work/gul_S1_summaryleccalc/P6.bin > /dev/null & pid151=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P6 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P6 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P6 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P6 work/gul_S2_summaryaalcalc/P6.bin work/gul_S2_summaryleccalc/P6.bin > /dev/null & pid152=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P7 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P7 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P7 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P7 work/gul_S1_summaryaalcalc/P7.bin work/gul_S1_summaryleccalc/P7.bin > /dev/null & pid153=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P7 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P7 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P7 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P7 work/gul_S2_summaryaalcalc/P7.bin work/gul_S2_summaryleccalc/P7.bin > /dev/null & pid154=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P8 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P8 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P8 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P8 work/gul_S1_summaryaalcalc/P8.bin work/gul_S1_summaryleccalc/P8.bin > /dev/null & pid155=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P8 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P8 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P8 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P8 work/gul_S2_summaryaalcalc/P8.bin work/gul_S2_summaryleccalc/P8.bin > /dev/null & pid156=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P9 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P9 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P9 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P9 work/gul_S1_summaryaalcalc/P9.bin work/gul_S1_summaryleccalc/P9.bin > /dev/null & pid157=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P9 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P9 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P9 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P9 work/gul_S2_summaryaalcalc/P9.bin work/gul_S2_summaryleccalc/P9.bin > /dev/null & pid158=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P10 /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P10 /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P10 /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P10 work/gul_S1_summaryaalcalc/P10.bin work/gul_S1_summaryleccalc/P10.bin > /dev/null & pid159=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P10 /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P10 /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P10 /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P10 work/gul_S2_summaryaalcalc/P10.bin work/gul_S2_summaryleccalc/P10.bin > /dev/null & pid160=$!

summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P1 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P1 < /tmp/%FIFO_DIR%/fifo/gul_P1 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P2 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P2 < /tmp/%FIFO_DIR%/fifo/gul_P2 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P3 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P3 < /tmp/%FIFO_DIR%/fifo/gul_P3 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P4 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P4 < /tmp/%FIFO_DIR%/fifo/gul_P4 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P5 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P5 < /tmp/%FIFO_DIR%/fifo/gul_P5 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P6 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P6 < /tmp/%FIFO_DIR%/fifo/gul_P6 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P7 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P7 < /tmp/%FIFO_DIR%/fifo/gul_P7 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P8 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P8 < /tmp/%FIFO_DIR%/fifo/gul_P8 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P9 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P9 < /tmp/%FIFO_DIR%/fifo/gul_P9 &
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P10 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P10 < /tmp/%FIFO_DIR%/fifo/gul_P10 &

eve 1 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P1 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P1  &
eve 2 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P2 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P2  &
eve 3 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P3 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P3  &
eve 4 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P4 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P4  &
eve 5 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P5 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P5  &
eve 6 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P6 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P6  &
eve 7 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P7 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P7  &
eve 8 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P8 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P8  &
eve 9 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P9 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P9  &
eve 10 10 | getmodel | gulcalc -S0 -L0 -r -a1 -i - | tee /tmp/%FIFO_DIR%/fifo/gul_P10 | fmcalc -a2 > /tmp/%FIFO_DIR%/fifo/il_P10  &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12 $pid13 $pid14 $pid15 $pid16 $pid17 $pid18 $pid19 $pid20 $pid21 $pid22 $pid23 $pid24 $pid25 $pid26 $pid27 $pid28 $pid29 $pid30 $pid31 $pid32 $pid33 $pid34 $pid35 $pid36 $pid37 $pid38 $pid39 $pid40 $pid41 $pid42 $pid43 $pid44 $pid45 $pid46 $pid47 $pid48 $pid49 $pid50 $pid51 $pid52 $pid53 $pid54 $pid55 $pid56 $pid57 $pid58 $pid59 $pid60 $pid61 $pid62 $pid63 $pid64 $pid65 $pid66 $pid67 $pid68 $pid69 $pid70 $pid71 $pid72 $pid73 $pid74 $pid75 $pid76 $pid77 $pid78 $pid79 $pid80 $pid81 $pid82 $pid83 $pid84 $pid85 $pid86 $pid87 $pid88 $pid89 $pid90 $pid91 $pid92 $pid93 $pid94 $pid95 $pid96 $pid97 $pid98 $pid99 $pid100 $pid101 $pid102 $pid103 $pid104 $pid105 $pid106 $pid107 $pid108 $pid109 $pid110 $pid111 $pid112 $pid113 $pid114 $pid115 $pid116 $pid117 $pid118 $pid119 $pid120 $pid121 $pid122 $pid123 $pid124 $pid125 $pid126 $pid127 $pid128 $pid129 $pid130 $pid131 $pid132 $pid133 $pid134 $pid135 $pid136 $pid137 $pid138 $pid139 $pid140 $pid141 $pid142 $pid143 $pid144 $pid145 $pid146 $pid147 $pid148 $pid149 $pid150 $pid151 $pid152 $pid153 $pid154 $pid155 $pid156 $pid157 $pid158 $pid159 $pid160


# --- Do insured loss kats ---

kat work/kat/il_S1_eltcalc_P1 work/kat/il_S1_eltcalc_P2 work/kat/il_S1_eltcalc_P3 work/kat/il_S1_eltcalc_P4 work/kat/il_S1_eltcalc_P5 work/kat/il_S1_eltcalc_P6 work/kat/il_S1_eltcalc_P7 work/kat/il_S1_eltcalc_P8 work/kat/il_S1_eltcalc_P9 work/kat/il_S1_eltcalc_P10 > output/il_S1_eltcalc.csv & kpid1=$!
kat work/kat/il_S1_pltcalc_P1 work/kat/il_S1_pltcalc_P2 work/kat/il_S1_pltcalc_P3 work/kat/il_S1_pltcalc_P4 work/kat/il_S1_pltcalc_P5 work/kat/il_S1_pltcalc_P6 work/kat/il_S1_pltcalc_P7 work/kat/il_S1_pltcalc_P8 work/kat/il_S1_pltcalc_P9 work/kat/il_S1_pltcalc_P10 > output/il_S1_pltcalc.csv & kpid2=$!
kat work/kat/il_S1_summarycalc_P1 work/kat/il_S1_summarycalc_P2 work/kat/il_S1_summarycalc_P3 work/kat/il_S1_summarycalc_P4 work/kat/il_S1_summarycalc_P5 work/kat/il_S1_summarycalc_P6 work/kat/il_S1_summarycalc_P7 work/kat/il_S1_summarycalc_P8 work/kat/il_S1_summarycalc_P9 work/kat/il_S1_summarycalc_P10 > output/il_S1_summarycalc.csv & kpid3=$!
kat work/kat/il_S2_eltcalc_P1 work/kat/il_S2_eltcalc_P2 work/kat/il_S2_eltcalc_P3 work/kat/il_S2_eltcalc_P4 work/kat/il_S2_eltcalc_P5 work/kat/il_S2_eltcalc_P6 work/kat/il_S2_eltcalc_P7 work/kat/il_S2_eltcalc_P8 work/kat/il_S2_eltcalc_P9 work/kat/il_S2_eltcalc_P10 > output/il_S2_eltcalc.csv & kpid4=$!
kat work/kat/il_S2_pltcalc_P1 work/kat/il_S2_pltcalc_P2 work/kat/il_S2_pltcalc_P3 work/kat/il_S2_pltcalc_P4 work/kat/il_S2_pltcalc_P5 work/kat/il_S2_pltcalc_P6 work/kat/il_S2_pltcalc_P7 work/kat/il_S2_pltcalc_P8 work/kat/il_S2_pltcalc_P9 work/kat/il_S2_pltcalc_P10 > output/il_S2_pltcalc.csv & kpid5=$!
kat work/kat/il_S2_summarycalc_P1 work/kat/il_S2_summarycalc_P2 work/kat/il_S2_summarycalc_P3 work/kat/il_S2_summarycalc_P4 work/kat/il_S2_summarycalc_P5 work/kat/il_S2_summarycalc_P6 work/kat/il_S2_summarycalc_P7 work/kat/il_S2_summarycalc_P8 work/kat/il_S2_summarycalc_P9 work/kat/il_S2_summarycalc_P10 > output/il_S2_summarycalc.csv & kpid6=$!

# --- Do ground up loss kats ---

kat work/kat/gul_S1_eltcalc_P1 work/kat/gul_S1_eltcalc_P2 work/kat/gul_S1_eltcalc_P3 work/kat/gul_S1_eltcalc_P4 work/kat/gul_S1_eltcalc_P5 work/kat/gul_S1_eltcalc_P6 work/kat/gul_S1_eltcalc_P7 work/kat/gul_S1_eltcalc_P8 work/kat/gul_S1_eltcalc_P9 work/kat/gul_S1_eltcalc_P10 > output/gul_S1_eltcalc.csv & kpid7=$!
kat work/kat/gul_S1_pltcalc_P1 work/kat/gul_S1_pltcalc_P2 work/kat/gul_S1_pltcalc_P3 work/kat/gul_S1_pltcalc_P4 work/kat/gul_S1_pltcalc_P5 work/kat/gul_S1_pltcalc_P6 work/kat/gul_S1_pltcalc_P7 work/kat/gul_S1_pltcalc_P8 work/kat/gul_S1_pltcalc_P9 work/kat/gul_S1_pltcalc_P10 > output/gul_S1_pltcalc.csv & kpid8=$!
kat work/kat/gul_S1_summarycalc_P1 work/kat/gul_S1_summarycalc_P2 work/kat/gul_S1_summarycalc_P3 work/kat/gul_S1_summarycalc_P4 work/kat/gul_S1_summarycalc_P5 work/kat/gul_S1_summarycalc_P6 work/kat/gul_S1_summarycalc_P7 work/kat/gul_S1_summarycalc_P8 work/kat/gul_S1_summarycalc_P9 work/kat/gul_S1_summarycalc_P10 > output/gul_S1_summarycalc.csv & kpid9=$!
kat work/kat/gul_S2_eltcalc_P1 work/kat/gul_S2_eltcalc_P2 work/kat/gul_S2_eltcalc_P3 work/kat/gul_S2_eltcalc_P4 work/kat/gul_S2_eltcalc_P5 work/kat/gul_S2_eltcalc_P6 work/kat/gul_S2_eltcalc_P7 work/kat/gul_S2_eltcalc_P8 work/kat/gul_S2_eltcalc_P9 work/kat/gul_S2_eltcalc_P10 > output/gul_S2_eltcalc.csv & kpid10=$!
kat work/kat/gul_S2_pltcalc_P1 work/kat/gul_S2_pltcalc_P2 work/kat/gul_S2_pltcalc_P3 work/kat/gul_S2_pltcalc_P4 work/kat/gul_S2_pltcalc_P5 work/kat/gul_S2_pltcalc_P6 work/kat/gul_S2_pltcalc_P7 work/kat/gul_S2_pltcalc_P8 work/kat/gul_S2_pltcalc_P9 work/kat/gul_S2_pltcalc_P10 > output/gul_S2_pltcalc.csv & kpid11=$!
kat work/kat/gul_S2_summarycalc_P1 work/kat/gul_S2_summarycalc_P2 work/kat/gul_S2_summarycalc_P3 work/kat/gul_S2_summarycalc_P4 work/kat/gul_S2_summarycalc_P5 work/kat/gul_S2_summarycalc_P6 work/kat/gul_S2_summarycalc_P7 work/kat/gul_S2_summarycalc_P8 work/kat/gul_S2_summarycalc_P9 work/kat/gul_S2_summarycalc_P10 > output/gul_S2_summarycalc.csv & kpid12=$!
wait $kpid1 $kpid2 $kpid3 $kpid4 $kpid5 $kpid6 $kpid7 $kpid8 $kpid9 $kpid10 $kpid11 $kpid12


aalcalc -Kil_S1_summaryaalcalc > output/il_S1_aalcalc.csv & lpid1=$!
leccalc -r -Kil_S1_summaryleccalc -F output/il_S1_leccalc_full_uncertainty_aep.csv -f output/il_S1_leccalc_full_uncertainty_oep.csv -S output/il_S1_leccalc_sample_mean_aep.csv -s output/il_S1_leccalc_sample_mean_oep.csv -W output/il_S1_leccalc_wheatsheaf_aep.csv -M output/il_S1_leccalc_wheatsheaf_mean_aep.csv -m output/il_S1_leccalc_wheatsheaf_mean_oep.csv -w output/il_S1_leccalc_wheatsheaf_oep.csv & lpid2=$!
aalcalc -Kil_S2_summaryaalcalc > output/il_S2_aalcalc.csv & lpid3=$!
leccalc -r -Kil_S2_summaryleccalc -F output/il_S2_leccalc_full_uncertainty_aep.csv -f output/il_S2_leccalc_full_uncertainty_oep.csv -S output/il_S2_leccalc_sample_mean_aep.csv -s output/il_S2_leccalc_sample_mean_oep.csv -W output/il_S2_leccalc_wheatsheaf_aep.csv -M output/il_S2_leccalc_wheatsheaf_mean_aep.csv -m output/il_S2_leccalc_wheatsheaf_mean_oep.csv -w output/il_S2_leccalc_wheatsheaf_oep.csv & lpid4=$!
aalcalc -Kgul_S1_summaryaalcalc > output/gul_S1_aalcalc.csv & lpid5=$!
leccalc -r -Kgul_S1_summaryleccalc -F output/gul_S1_leccalc_full_uncertainty_aep.csv -f output/gul_S1_leccalc_full_uncertainty_oep.csv -S output/gul_S1_leccalc_sample_mean_aep.csv -s output/gul_S1_leccalc_sample_mean_oep.csv -W output/gul_S1_leccalc_wheatsheaf_aep.csv -M output/gul_S1_leccalc_wheatsheaf_mean_aep.csv -m output/gul_S1_leccalc_wheatsheaf_mean_oep.csv -w output/gul_S1_leccalc_wheatsheaf_oep.csv & lpid6=$!
aalcalc -Kgul_S2_summaryaalcalc > output/gul_S2_aalcalc.csv & lpid7=$!
leccalc -r -Kgul_S2_summaryleccalc -F output/gul_S2_leccalc_full_uncertainty_aep.csv -f output/gul_S2_leccalc_full_uncertainty_oep.csv -S output/gul_S2_leccalc_sample_mean_aep.csv -s output/gul_S2_leccalc_sample_mean_oep.csv -W output/gul_S2_leccalc_wheatsheaf_aep.csv -M output/gul_S2_leccalc_wheatsheaf_mean_aep.csv -m output/gul_S2_leccalc_wheatsheaf_mean_oep.csv -w output/gul_S2_leccalc_wheatsheaf_oep.csv & lpid8=$!
wait $lpid1 $lpid2 $lpid3 $lpid4 $lpid5 $lpid6 $lpid7 $lpid8

rm -R -f work/*
rm -R -f /tmp/%FIFO_DIR%/

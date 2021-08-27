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

mkdir work/gul_S1_summaryleccalc
mkdir work/full_correlation/gul_S1_summaryleccalc

mkfifo fifo/gul_P1
mkfifo fifo/gul_P2
mkfifo fifo/gul_P3
mkfifo fifo/gul_P4
mkfifo fifo/gul_P5
mkfifo fifo/gul_P6
mkfifo fifo/gul_P7
mkfifo fifo/gul_P8
mkfifo fifo/gul_P9
mkfifo fifo/gul_P10
mkfifo fifo/gul_P11
mkfifo fifo/gul_P12
mkfifo fifo/gul_P13
mkfifo fifo/gul_P14
mkfifo fifo/gul_P15
mkfifo fifo/gul_P16
mkfifo fifo/gul_P17
mkfifo fifo/gul_P18
mkfifo fifo/gul_P19
mkfifo fifo/gul_P20

mkfifo fifo/gul_S1_summary_P1
mkfifo fifo/gul_S1_summary_P1.idx

mkfifo fifo/gul_S1_summary_P2
mkfifo fifo/gul_S1_summary_P2.idx

mkfifo fifo/gul_S1_summary_P3
mkfifo fifo/gul_S1_summary_P3.idx

mkfifo fifo/gul_S1_summary_P4
mkfifo fifo/gul_S1_summary_P4.idx

mkfifo fifo/gul_S1_summary_P5
mkfifo fifo/gul_S1_summary_P5.idx

mkfifo fifo/gul_S1_summary_P6
mkfifo fifo/gul_S1_summary_P6.idx

mkfifo fifo/gul_S1_summary_P7
mkfifo fifo/gul_S1_summary_P7.idx

mkfifo fifo/gul_S1_summary_P8
mkfifo fifo/gul_S1_summary_P8.idx

mkfifo fifo/gul_S1_summary_P9
mkfifo fifo/gul_S1_summary_P9.idx

mkfifo fifo/gul_S1_summary_P10
mkfifo fifo/gul_S1_summary_P10.idx

mkfifo fifo/gul_S1_summary_P11
mkfifo fifo/gul_S1_summary_P11.idx

mkfifo fifo/gul_S1_summary_P12
mkfifo fifo/gul_S1_summary_P12.idx

mkfifo fifo/gul_S1_summary_P13
mkfifo fifo/gul_S1_summary_P13.idx

mkfifo fifo/gul_S1_summary_P14
mkfifo fifo/gul_S1_summary_P14.idx

mkfifo fifo/gul_S1_summary_P15
mkfifo fifo/gul_S1_summary_P15.idx

mkfifo fifo/gul_S1_summary_P16
mkfifo fifo/gul_S1_summary_P16.idx

mkfifo fifo/gul_S1_summary_P17
mkfifo fifo/gul_S1_summary_P17.idx

mkfifo fifo/gul_S1_summary_P18
mkfifo fifo/gul_S1_summary_P18.idx

mkfifo fifo/gul_S1_summary_P19
mkfifo fifo/gul_S1_summary_P19.idx

mkfifo fifo/gul_S1_summary_P20
mkfifo fifo/gul_S1_summary_P20.idx

mkfifo fifo/full_correlation/gul_P1
mkfifo fifo/full_correlation/gul_P2
mkfifo fifo/full_correlation/gul_P3
mkfifo fifo/full_correlation/gul_P4
mkfifo fifo/full_correlation/gul_P5
mkfifo fifo/full_correlation/gul_P6
mkfifo fifo/full_correlation/gul_P7
mkfifo fifo/full_correlation/gul_P8
mkfifo fifo/full_correlation/gul_P9
mkfifo fifo/full_correlation/gul_P10
mkfifo fifo/full_correlation/gul_P11
mkfifo fifo/full_correlation/gul_P12
mkfifo fifo/full_correlation/gul_P13
mkfifo fifo/full_correlation/gul_P14
mkfifo fifo/full_correlation/gul_P15
mkfifo fifo/full_correlation/gul_P16
mkfifo fifo/full_correlation/gul_P17
mkfifo fifo/full_correlation/gul_P18
mkfifo fifo/full_correlation/gul_P19
mkfifo fifo/full_correlation/gul_P20

mkfifo fifo/full_correlation/gul_S1_summary_P1
mkfifo fifo/full_correlation/gul_S1_summary_P1.idx

mkfifo fifo/full_correlation/gul_S1_summary_P2
mkfifo fifo/full_correlation/gul_S1_summary_P2.idx

mkfifo fifo/full_correlation/gul_S1_summary_P3
mkfifo fifo/full_correlation/gul_S1_summary_P3.idx

mkfifo fifo/full_correlation/gul_S1_summary_P4
mkfifo fifo/full_correlation/gul_S1_summary_P4.idx

mkfifo fifo/full_correlation/gul_S1_summary_P5
mkfifo fifo/full_correlation/gul_S1_summary_P5.idx

mkfifo fifo/full_correlation/gul_S1_summary_P6
mkfifo fifo/full_correlation/gul_S1_summary_P6.idx

mkfifo fifo/full_correlation/gul_S1_summary_P7
mkfifo fifo/full_correlation/gul_S1_summary_P7.idx

mkfifo fifo/full_correlation/gul_S1_summary_P8
mkfifo fifo/full_correlation/gul_S1_summary_P8.idx

mkfifo fifo/full_correlation/gul_S1_summary_P9
mkfifo fifo/full_correlation/gul_S1_summary_P9.idx

mkfifo fifo/full_correlation/gul_S1_summary_P10
mkfifo fifo/full_correlation/gul_S1_summary_P10.idx

mkfifo fifo/full_correlation/gul_S1_summary_P11
mkfifo fifo/full_correlation/gul_S1_summary_P11.idx

mkfifo fifo/full_correlation/gul_S1_summary_P12
mkfifo fifo/full_correlation/gul_S1_summary_P12.idx

mkfifo fifo/full_correlation/gul_S1_summary_P13
mkfifo fifo/full_correlation/gul_S1_summary_P13.idx

mkfifo fifo/full_correlation/gul_S1_summary_P14
mkfifo fifo/full_correlation/gul_S1_summary_P14.idx

mkfifo fifo/full_correlation/gul_S1_summary_P15
mkfifo fifo/full_correlation/gul_S1_summary_P15.idx

mkfifo fifo/full_correlation/gul_S1_summary_P16
mkfifo fifo/full_correlation/gul_S1_summary_P16.idx

mkfifo fifo/full_correlation/gul_S1_summary_P17
mkfifo fifo/full_correlation/gul_S1_summary_P17.idx

mkfifo fifo/full_correlation/gul_S1_summary_P18
mkfifo fifo/full_correlation/gul_S1_summary_P18.idx

mkfifo fifo/full_correlation/gul_S1_summary_P19
mkfifo fifo/full_correlation/gul_S1_summary_P19.idx

mkfifo fifo/full_correlation/gul_S1_summary_P20
mkfifo fifo/full_correlation/gul_S1_summary_P20.idx



# --- Do ground up loss computes ---



tee < fifo/gul_S1_summary_P1 work/gul_S1_summaryleccalc/P1.bin > /dev/null & pid1=$!
tee < fifo/gul_S1_summary_P1.idx work/gul_S1_summaryleccalc/P1.idx > /dev/null & pid2=$!
tee < fifo/gul_S1_summary_P2 work/gul_S1_summaryleccalc/P2.bin > /dev/null & pid3=$!
tee < fifo/gul_S1_summary_P2.idx work/gul_S1_summaryleccalc/P2.idx > /dev/null & pid4=$!
tee < fifo/gul_S1_summary_P3 work/gul_S1_summaryleccalc/P3.bin > /dev/null & pid5=$!
tee < fifo/gul_S1_summary_P3.idx work/gul_S1_summaryleccalc/P3.idx > /dev/null & pid6=$!
tee < fifo/gul_S1_summary_P4 work/gul_S1_summaryleccalc/P4.bin > /dev/null & pid7=$!
tee < fifo/gul_S1_summary_P4.idx work/gul_S1_summaryleccalc/P4.idx > /dev/null & pid8=$!
tee < fifo/gul_S1_summary_P5 work/gul_S1_summaryleccalc/P5.bin > /dev/null & pid9=$!
tee < fifo/gul_S1_summary_P5.idx work/gul_S1_summaryleccalc/P5.idx > /dev/null & pid10=$!
tee < fifo/gul_S1_summary_P6 work/gul_S1_summaryleccalc/P6.bin > /dev/null & pid11=$!
tee < fifo/gul_S1_summary_P6.idx work/gul_S1_summaryleccalc/P6.idx > /dev/null & pid12=$!
tee < fifo/gul_S1_summary_P7 work/gul_S1_summaryleccalc/P7.bin > /dev/null & pid13=$!
tee < fifo/gul_S1_summary_P7.idx work/gul_S1_summaryleccalc/P7.idx > /dev/null & pid14=$!
tee < fifo/gul_S1_summary_P8 work/gul_S1_summaryleccalc/P8.bin > /dev/null & pid15=$!
tee < fifo/gul_S1_summary_P8.idx work/gul_S1_summaryleccalc/P8.idx > /dev/null & pid16=$!
tee < fifo/gul_S1_summary_P9 work/gul_S1_summaryleccalc/P9.bin > /dev/null & pid17=$!
tee < fifo/gul_S1_summary_P9.idx work/gul_S1_summaryleccalc/P9.idx > /dev/null & pid18=$!
tee < fifo/gul_S1_summary_P10 work/gul_S1_summaryleccalc/P10.bin > /dev/null & pid19=$!
tee < fifo/gul_S1_summary_P10.idx work/gul_S1_summaryleccalc/P10.idx > /dev/null & pid20=$!
tee < fifo/gul_S1_summary_P11 work/gul_S1_summaryleccalc/P11.bin > /dev/null & pid21=$!
tee < fifo/gul_S1_summary_P11.idx work/gul_S1_summaryleccalc/P11.idx > /dev/null & pid22=$!
tee < fifo/gul_S1_summary_P12 work/gul_S1_summaryleccalc/P12.bin > /dev/null & pid23=$!
tee < fifo/gul_S1_summary_P12.idx work/gul_S1_summaryleccalc/P12.idx > /dev/null & pid24=$!
tee < fifo/gul_S1_summary_P13 work/gul_S1_summaryleccalc/P13.bin > /dev/null & pid25=$!
tee < fifo/gul_S1_summary_P13.idx work/gul_S1_summaryleccalc/P13.idx > /dev/null & pid26=$!
tee < fifo/gul_S1_summary_P14 work/gul_S1_summaryleccalc/P14.bin > /dev/null & pid27=$!
tee < fifo/gul_S1_summary_P14.idx work/gul_S1_summaryleccalc/P14.idx > /dev/null & pid28=$!
tee < fifo/gul_S1_summary_P15 work/gul_S1_summaryleccalc/P15.bin > /dev/null & pid29=$!
tee < fifo/gul_S1_summary_P15.idx work/gul_S1_summaryleccalc/P15.idx > /dev/null & pid30=$!
tee < fifo/gul_S1_summary_P16 work/gul_S1_summaryleccalc/P16.bin > /dev/null & pid31=$!
tee < fifo/gul_S1_summary_P16.idx work/gul_S1_summaryleccalc/P16.idx > /dev/null & pid32=$!
tee < fifo/gul_S1_summary_P17 work/gul_S1_summaryleccalc/P17.bin > /dev/null & pid33=$!
tee < fifo/gul_S1_summary_P17.idx work/gul_S1_summaryleccalc/P17.idx > /dev/null & pid34=$!
tee < fifo/gul_S1_summary_P18 work/gul_S1_summaryleccalc/P18.bin > /dev/null & pid35=$!
tee < fifo/gul_S1_summary_P18.idx work/gul_S1_summaryleccalc/P18.idx > /dev/null & pid36=$!
tee < fifo/gul_S1_summary_P19 work/gul_S1_summaryleccalc/P19.bin > /dev/null & pid37=$!
tee < fifo/gul_S1_summary_P19.idx work/gul_S1_summaryleccalc/P19.idx > /dev/null & pid38=$!
tee < fifo/gul_S1_summary_P20 work/gul_S1_summaryleccalc/P20.bin > /dev/null & pid39=$!
tee < fifo/gul_S1_summary_P20.idx work/gul_S1_summaryleccalc/P20.idx > /dev/null & pid40=$!

summarycalc -m -i  -1 fifo/gul_S1_summary_P1 < fifo/gul_P1 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P2 < fifo/gul_P2 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P3 < fifo/gul_P3 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P4 < fifo/gul_P4 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P5 < fifo/gul_P5 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P6 < fifo/gul_P6 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P7 < fifo/gul_P7 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P8 < fifo/gul_P8 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P9 < fifo/gul_P9 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P10 < fifo/gul_P10 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P11 < fifo/gul_P11 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P12 < fifo/gul_P12 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P13 < fifo/gul_P13 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P14 < fifo/gul_P14 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P15 < fifo/gul_P15 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P16 < fifo/gul_P16 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P17 < fifo/gul_P17 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P18 < fifo/gul_P18 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P19 < fifo/gul_P19 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P20 < fifo/gul_P20 &

# --- Do ground up loss computes ---



tee < fifo/full_correlation/gul_S1_summary_P1 work/full_correlation/gul_S1_summaryleccalc/P1.bin > /dev/null & pid41=$!
tee < fifo/full_correlation/gul_S1_summary_P1.idx work/full_correlation/gul_S1_summaryleccalc/P1.idx > /dev/null & pid42=$!
tee < fifo/full_correlation/gul_S1_summary_P2 work/full_correlation/gul_S1_summaryleccalc/P2.bin > /dev/null & pid43=$!
tee < fifo/full_correlation/gul_S1_summary_P2.idx work/full_correlation/gul_S1_summaryleccalc/P2.idx > /dev/null & pid44=$!
tee < fifo/full_correlation/gul_S1_summary_P3 work/full_correlation/gul_S1_summaryleccalc/P3.bin > /dev/null & pid45=$!
tee < fifo/full_correlation/gul_S1_summary_P3.idx work/full_correlation/gul_S1_summaryleccalc/P3.idx > /dev/null & pid46=$!
tee < fifo/full_correlation/gul_S1_summary_P4 work/full_correlation/gul_S1_summaryleccalc/P4.bin > /dev/null & pid47=$!
tee < fifo/full_correlation/gul_S1_summary_P4.idx work/full_correlation/gul_S1_summaryleccalc/P4.idx > /dev/null & pid48=$!
tee < fifo/full_correlation/gul_S1_summary_P5 work/full_correlation/gul_S1_summaryleccalc/P5.bin > /dev/null & pid49=$!
tee < fifo/full_correlation/gul_S1_summary_P5.idx work/full_correlation/gul_S1_summaryleccalc/P5.idx > /dev/null & pid50=$!
tee < fifo/full_correlation/gul_S1_summary_P6 work/full_correlation/gul_S1_summaryleccalc/P6.bin > /dev/null & pid51=$!
tee < fifo/full_correlation/gul_S1_summary_P6.idx work/full_correlation/gul_S1_summaryleccalc/P6.idx > /dev/null & pid52=$!
tee < fifo/full_correlation/gul_S1_summary_P7 work/full_correlation/gul_S1_summaryleccalc/P7.bin > /dev/null & pid53=$!
tee < fifo/full_correlation/gul_S1_summary_P7.idx work/full_correlation/gul_S1_summaryleccalc/P7.idx > /dev/null & pid54=$!
tee < fifo/full_correlation/gul_S1_summary_P8 work/full_correlation/gul_S1_summaryleccalc/P8.bin > /dev/null & pid55=$!
tee < fifo/full_correlation/gul_S1_summary_P8.idx work/full_correlation/gul_S1_summaryleccalc/P8.idx > /dev/null & pid56=$!
tee < fifo/full_correlation/gul_S1_summary_P9 work/full_correlation/gul_S1_summaryleccalc/P9.bin > /dev/null & pid57=$!
tee < fifo/full_correlation/gul_S1_summary_P9.idx work/full_correlation/gul_S1_summaryleccalc/P9.idx > /dev/null & pid58=$!
tee < fifo/full_correlation/gul_S1_summary_P10 work/full_correlation/gul_S1_summaryleccalc/P10.bin > /dev/null & pid59=$!
tee < fifo/full_correlation/gul_S1_summary_P10.idx work/full_correlation/gul_S1_summaryleccalc/P10.idx > /dev/null & pid60=$!
tee < fifo/full_correlation/gul_S1_summary_P11 work/full_correlation/gul_S1_summaryleccalc/P11.bin > /dev/null & pid61=$!
tee < fifo/full_correlation/gul_S1_summary_P11.idx work/full_correlation/gul_S1_summaryleccalc/P11.idx > /dev/null & pid62=$!
tee < fifo/full_correlation/gul_S1_summary_P12 work/full_correlation/gul_S1_summaryleccalc/P12.bin > /dev/null & pid63=$!
tee < fifo/full_correlation/gul_S1_summary_P12.idx work/full_correlation/gul_S1_summaryleccalc/P12.idx > /dev/null & pid64=$!
tee < fifo/full_correlation/gul_S1_summary_P13 work/full_correlation/gul_S1_summaryleccalc/P13.bin > /dev/null & pid65=$!
tee < fifo/full_correlation/gul_S1_summary_P13.idx work/full_correlation/gul_S1_summaryleccalc/P13.idx > /dev/null & pid66=$!
tee < fifo/full_correlation/gul_S1_summary_P14 work/full_correlation/gul_S1_summaryleccalc/P14.bin > /dev/null & pid67=$!
tee < fifo/full_correlation/gul_S1_summary_P14.idx work/full_correlation/gul_S1_summaryleccalc/P14.idx > /dev/null & pid68=$!
tee < fifo/full_correlation/gul_S1_summary_P15 work/full_correlation/gul_S1_summaryleccalc/P15.bin > /dev/null & pid69=$!
tee < fifo/full_correlation/gul_S1_summary_P15.idx work/full_correlation/gul_S1_summaryleccalc/P15.idx > /dev/null & pid70=$!
tee < fifo/full_correlation/gul_S1_summary_P16 work/full_correlation/gul_S1_summaryleccalc/P16.bin > /dev/null & pid71=$!
tee < fifo/full_correlation/gul_S1_summary_P16.idx work/full_correlation/gul_S1_summaryleccalc/P16.idx > /dev/null & pid72=$!
tee < fifo/full_correlation/gul_S1_summary_P17 work/full_correlation/gul_S1_summaryleccalc/P17.bin > /dev/null & pid73=$!
tee < fifo/full_correlation/gul_S1_summary_P17.idx work/full_correlation/gul_S1_summaryleccalc/P17.idx > /dev/null & pid74=$!
tee < fifo/full_correlation/gul_S1_summary_P18 work/full_correlation/gul_S1_summaryleccalc/P18.bin > /dev/null & pid75=$!
tee < fifo/full_correlation/gul_S1_summary_P18.idx work/full_correlation/gul_S1_summaryleccalc/P18.idx > /dev/null & pid76=$!
tee < fifo/full_correlation/gul_S1_summary_P19 work/full_correlation/gul_S1_summaryleccalc/P19.bin > /dev/null & pid77=$!
tee < fifo/full_correlation/gul_S1_summary_P19.idx work/full_correlation/gul_S1_summaryleccalc/P19.idx > /dev/null & pid78=$!
tee < fifo/full_correlation/gul_S1_summary_P20 work/full_correlation/gul_S1_summaryleccalc/P20.bin > /dev/null & pid79=$!
tee < fifo/full_correlation/gul_S1_summary_P20.idx work/full_correlation/gul_S1_summaryleccalc/P20.idx > /dev/null & pid80=$!

summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P1 < fifo/full_correlation/gul_P1 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P2 < fifo/full_correlation/gul_P2 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P3 < fifo/full_correlation/gul_P3 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P4 < fifo/full_correlation/gul_P4 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P5 < fifo/full_correlation/gul_P5 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P6 < fifo/full_correlation/gul_P6 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P7 < fifo/full_correlation/gul_P7 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P8 < fifo/full_correlation/gul_P8 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P9 < fifo/full_correlation/gul_P9 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P10 < fifo/full_correlation/gul_P10 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P11 < fifo/full_correlation/gul_P11 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P12 < fifo/full_correlation/gul_P12 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P13 < fifo/full_correlation/gul_P13 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P14 < fifo/full_correlation/gul_P14 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P15 < fifo/full_correlation/gul_P15 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P16 < fifo/full_correlation/gul_P16 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P17 < fifo/full_correlation/gul_P17 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P18 < fifo/full_correlation/gul_P18 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P19 < fifo/full_correlation/gul_P19 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P20 < fifo/full_correlation/gul_P20 &

eve 1 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P1 -a1 -i - > fifo/gul_P1  &
eve 2 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P2 -a1 -i - > fifo/gul_P2  &
eve 3 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P3 -a1 -i - > fifo/gul_P3  &
eve 4 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P4 -a1 -i - > fifo/gul_P4  &
eve 5 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P5 -a1 -i - > fifo/gul_P5  &
eve 6 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P6 -a1 -i - > fifo/gul_P6  &
eve 7 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P7 -a1 -i - > fifo/gul_P7  &
eve 8 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P8 -a1 -i - > fifo/gul_P8  &
eve 9 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P9 -a1 -i - > fifo/gul_P9  &
eve 10 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P10 -a1 -i - > fifo/gul_P10  &
eve 11 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P11 -a1 -i - > fifo/gul_P11  &
eve 12 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P12 -a1 -i - > fifo/gul_P12  &
eve 13 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P13 -a1 -i - > fifo/gul_P13  &
eve 14 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P14 -a1 -i - > fifo/gul_P14  &
eve 15 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P15 -a1 -i - > fifo/gul_P15  &
eve 16 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P16 -a1 -i - > fifo/gul_P16  &
eve 17 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P17 -a1 -i - > fifo/gul_P17  &
eve 18 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P18 -a1 -i - > fifo/gul_P18  &
eve 19 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P19 -a1 -i - > fifo/gul_P19  &
eve 20 20 | getmodel | gulcalc -S0 -L0 -r -j fifo/full_correlation/gul_P20 -a1 -i - > fifo/gul_P20  &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12 $pid13 $pid14 $pid15 $pid16 $pid17 $pid18 $pid19 $pid20 $pid21 $pid22 $pid23 $pid24 $pid25 $pid26 $pid27 $pid28 $pid29 $pid30 $pid31 $pid32 $pid33 $pid34 $pid35 $pid36 $pid37 $pid38 $pid39 $pid40 $pid41 $pid42 $pid43 $pid44 $pid45 $pid46 $pid47 $pid48 $pid49 $pid50 $pid51 $pid52 $pid53 $pid54 $pid55 $pid56 $pid57 $pid58 $pid59 $pid60 $pid61 $pid62 $pid63 $pid64 $pid65 $pid66 $pid67 $pid68 $pid69 $pid70 $pid71 $pid72 $pid73 $pid74 $pid75 $pid76 $pid77 $pid78 $pid79 $pid80


# --- Do ground up loss kats ---


# --- Do ground up loss kats for fully correlated output ---


ordleccalc -r -Kgul_S1_summaryleccalc -F -f -S -s -M -m -O output/gul_S1_ept.csv & lpid1=$!
ordleccalc -r -Kfull_correlation/gul_S1_summaryleccalc -F -f -S -s -M -m -O output/full_correlation/gul_S1_ept.csv & lpid2=$!
wait $lpid1 $lpid2

rm -R -f work/*
rm -R -f fifo/*

#!/bin/bash
input="/root/pFIR/lpf_coefficients.txt"
coeff="/sys/class/fe_pFIR_248/fe_pFIR_248/wr_data"
address="/sys/class/fe_pFIR_248/fe_pFIR_248/rw_addr"
enable="/sys/class/fe_pFIR_248/fe_pFIR_248/wr_en"

size=$(stat -c%s "$input")

echo "Programming the FIR filter..."
j=0;
echo 1 > "$enable";

mapfile -t a < "$input"
for i in "${!a[@]}"; do
	echo "$j" | tee "$address" > /dev/null ;
	echo "$((16#${a[i]}))" | tee "$coeff" > /dev/null ;
	j=$((j+4));
done

echo 0 > "$enable";
echo "FIR filter successfully programmed!"

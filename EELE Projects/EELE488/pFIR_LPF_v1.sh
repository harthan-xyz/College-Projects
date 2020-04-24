#!/bin/bash
input="/root/pFIR/lpf_coefficients.txt"
coeff="/sys/class/fe_pFIR_248/fe_pFIR_248/wr_data"
address="/sys/class/fe_pFIR_248/fe_pFIR_248/rw_addr"

size=$(stat -c%s "$input")

echo "The size of $input is $size bytes."
j=0;

mapfile -t a < "$input"
for i in "${!a[@]}"; do
	printf "{a[%s]} = %s\n" "$j" "$((16#${a[i]}))";
	echo "$j" | tee "$address" > /dev/null ;
	echo "$((16#${a[i]}))" | tee "$coeff" > /dev/null ;
	j=$((j+4));
done

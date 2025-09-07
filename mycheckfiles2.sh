#!/bin/bash

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l

echo "#==========================================================="

echo "Start Times"

declare -a start_times
declare -a file_names
declare -a end_times
declare -a job_metrics
declare -a message_ids

for file in *.out; do
    file_names+=("$file")

    start_time=$(head -n 1 "$file")
    start_times+=("$start_time")

    end_time=$(grep "time.struct_time" "$file" | sed -n '2p')
    end_times+=("$end_time")

    metric=$(tail -n 4 "$file" | head -n 1)
    job_metrics+=("$metric")

    message_id=$(tail -n 2 "$file")
    message_ids+=("$message_id")
done

for i in "${!file_names[@]}"; do
    echo "==> ${file_names[$i]} <=="
    echo "${start_times[$i]}"
    echo
done

echo "End Times"

for i in "${!file_names[@]}"; do
    echo "==> ${file_names[$i]} <=="
    echo "${end_times[$i]}"
    echo "${job_metrics[$i]}"
    echo "${message_ids[$i]}"
    echo
done

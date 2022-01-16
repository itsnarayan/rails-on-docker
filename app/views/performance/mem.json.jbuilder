json.name 'Memory usage info'
json.message "Loaded #{GetProcessMem.new.mb.round - @previous_memory}MB object to memory. And currently loaded #{GetProcessMem.new.mb.round}MB data."
json.data_size @some_array.size

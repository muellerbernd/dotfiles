#!/bin/bash
# File              : del_files_listed_in_file.sh
# Author            : Bernd Müller <bernd@muellerbernd.de>
# Date              : 25.04.2023
# Last Modified Date: 25.04.2023
# Last Modified By  : Bernd Müller <bernd@muellerbernd.de>

file_name=$1

echo "$file_name"

while IFS= read -r line; do
  sudo rm $line
done < $file_name

#!/bin/bash

if [ -z "$1" ]; then 
    echo "usage: $0 <dev-tst-prd>"
    exit 1
fi

echo "environment: $1"

# extract summary line from plan - change path was /tmp/plan_${environment}
sed -r 's/\x1B\[0-9;]*[mK]//g' /tmp/${1}.tfplan > /tmp/${1}_summary
summary=$(grep "Plan:" /tmp/${1}_summary || true)

# extract counts with lookahead assertions - github
add=$(echo $summary | grep -oP '(\d+)(?= to add)' || echo "0")
change=$(echo $summary | grep -oP '(\d+)(?= to change)' || echo "0")
destroy=$(echo $summary | grep -oP '(\d+)(?= to destroy)' || echo "0")


# extract counts mac
# add=$(echo $summary | sed -nr 's/.*( |^)([0-9]+) to add.*/\2/p')
# if [ -z $add ]; then
#      add="0"
# fi
# change=$(echo $summary | sed -nr 's/.*( |^)([0-9]+) to change.*/\2/p')
# if [ -z $change ]; then
#      change="0"
# fi
# destroy=$(echo $summary | sed -nr 's/.*( |^)([0-9]+) to destroy.*/\2/p')
# if [ -z $destroy ]; then
#      destroy="0"
# fi

# extract resource names - adjust patterns if output format changes
add_resources=$(grep -E '^  # ' /tmp/${1}.tfplan | grep 'will be created' | sed 's/# //; s/ will be created//' || true)
change_resources=$(grep -E '^  # ' /tmp/${1}.tfplan | grep 'will be updated' | sed 's/# //; s/ will be updated//' || true)
destroy_resources=$(grep -E '^  # ' /tmp/${1}.tfplan | grep 'will be destroyed' | sed 's/# //; s/ will be destroyed//' || true)
destroy_resources=$(grep -E '^  # ' /tmp/${1}.tfplan | grep 'must be replaced' | sed 's/# //; s/ will be replaced//' || true)

# add_resources=$(grep -E '  #' /tmp/dev.tfplan | grep 'will be created' | sed 's/  # //; s/ will be created//' || true)
# change_resources=$(grep -E '  #' /tmp/dev.tfplan | grep 'will be updated' | sed 's/  # //; s/ will be updated.*//' || true)
# destroy_resources=$(grep -E '  #' /tmp/dev.tfplan | grep 'will be destroyed' | sed 's/ # //; s/ will be destroyed//' || true)
# destroy_resources=$(grep -E '  #' /tmp/dev.tfplan | grep 'must be replaced' | sed 's/  # //; s/ must be replaced//' || true)


# format as html function 
format_list_html() {
    if [ -z "$1" ]; then 
        echo "<p>none</p>"
    else
    echo "$1" | sed 's/^/<li>/' | sed 's/$/<\/li>/' | paste -sd " " -
fi
}

add_list_html=$(format_list_html "$add_resources")
change_list_html=$(format_list_html "$change_resources")
destroy_list_html=$(format_list_html "$destroy_resources")

# build html
html_content=$(cat <<EOF
<h2>terraform plan summary ${1}</h2>
<h3>overview</h3>
<table border="1" cellspacing="0" cellpadding="3" >
  <thead>
    <tr>
      <th align="left">action</th>
      <th align="left">count</th>
      <th align="left" >resources</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>add</strong></td>
      <td>${add}</td>
      <td><ul>${add_list_html}</ul></td>
    </tr>
    <tr>
      <td><strong>change</strong></td>
      <td>${change}</td>
      <td><ul>${change_list_html}</ul></td>
    </tr>
    <tr>
      <td><strong>destroy</strong></td>
      <td>${destroy}</td>
      <td><ul>${destroy_list_html}</ul></td>
    </tr>
  </tbody>
</table>

<h4>note: review detailed output prior to approval</h4>
EOF
)

echo $html_content >> $GITHUB_STEP_SUMMARY
# write summary to step summary file
echo $html_content > terraform_summary.md
# export summary to output
echo "summary<<EOF" >> $GITHUB_OUTPUT
echo "$html_content" >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT


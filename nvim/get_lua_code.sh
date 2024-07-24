find . -type f -name "*.lua" | while read -r file; do
    # Print the filename at the top
    echo "=== ${file} ==="
    # Concatenate the file content
    cat "${file}"
    # Add a separator for readability
    echo ""
done


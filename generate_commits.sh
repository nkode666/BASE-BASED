#!/bin/bash

# Script to generate 100 commits to BASE chain
# Usage: bash generate_commits.sh

# Configuration
TOTAL_COMMITS=100
COMMIT_MESSAGE_PREFIX="BASE chain commit"

echo "Starting generation of $TOTAL_COMMITS commits..."

# Create a commits directory if it doesn't exist
mkdir -p commits

for i in $(seq 1 $TOTAL_COMMITS); do
    # Create a new file for each commit
    FILENAME="commits/base_commit_${i}.txt"
    
    # Add content to the file
    cat > "$FILENAME" << EOF
Commit #$i
Generated at: $(date)
Chain: BASE
Description: This is commit $i in the sequence of 100 commits for BASE chain development.

Content block:
- Timestamp: $(date '+%Y-%m-%d %H:%M:%S')
- Commit number: $i
- Status: Active development
EOF

    # Stage the file
    git add "$FILENAME"
    
    # Create commit with timestamp
    GIT_COMMITTER_DATE="2026-05-16 $(printf '%02d:%02d:%02d' $((RANDOM % 24)) $((RANDOM % 60)) $((RANDOM % 60)))" \
    GIT_AUTHOR_DATE="2026-05-16 $(printf '%02d:%02d:%02d' $((RANDOM % 24)) $((RANDOM % 60)) $((RANDOM % 60)))" \
    git commit -m "$COMMIT_MESSAGE_PREFIX #$i - BASE chain development"
    
    # Display progress
    if [ $((i % 10)) -eq 0 ]; then
        echo "✓ Created $i commits..."
    fi
done

echo "✓ Successfully generated $TOTAL_COMMITS commits!"
echo "Total commits created: $(git rev-list --all --count)"
echo ""
echo "To push these commits to your repository, run:"
echo "  git push origin main"

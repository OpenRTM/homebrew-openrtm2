#!/usr/bin/env bash
set -euo pipefail

REPO="OpenRTM/homebrew-openrtm2"
TAG="v2.1.0"
TITLE="2.1.0 RELEASE"
NOTES="Homebrew bottles for OpenRTM-aist 2.1.0"

BOTTLE_PATTERN="*.bottle*.tar.gz"

# bottle ファイル確認
shopt -s nullglob
BOTTLES=( $BOTTLE_PATTERN )
shopt -u nullglob

if [ ${#BOTTLES[@]} -eq 0 ]; then
  echo "No bottle files found: $BOTTLE_PATTERN"
  exit 1
fi

# gh 認証確認
gh auth status >/dev/null

# tag 確認・作成
if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "Local tag exists: $TAG"
else
  echo "Creating local tag: $TAG"
  git tag "$TAG"
fi

# remote tag 確認・push
if git ls-remote --tags origin "refs/tags/$TAG" | grep -q "$TAG"; then
  echo "Remote tag exists: $TAG"
else
  echo "Pushing tag: $TAG"
  git push origin "$TAG"
fi

# release 確認・作成
if gh release view "$TAG" --repo "$REPO" >/dev/null 2>&1; then
  echo "Release already exists: $TAG"
else
  echo "Creating release: $TAG"
  gh release create "$TAG" \
    --repo "$REPO" \
    --title "$TITLE" \
    --notes "$NOTES"
fi

# bottle upload
echo "Uploading bottle files:"
printf '  %s\n' "${BOTTLES[@]}"

gh release upload "$TAG" "${BOTTLES[@]}" \
  --repo "$REPO" \
  --clobber

echo "Done."

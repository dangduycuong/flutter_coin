echo "========================Setup Env Config $BUILD_FLAVOR_KEY======================="
flavor="Development"

#Check prefix and set flavor config
if [ "$BUILD_FLAVOR_KEY" = "staging" ]; then
  flavor="Staging"
elif [ "$BUILD_FLAVOR_KEY" = "production" ]; then
  flavor="Production"
fi

echo Flavor "$flavor"
echo Branch name "$CI_BUILD_REF_NAME"
echo Commit title "$CI_COMMIT_TITLE"
echo User name "$GITLAB_USER_NAME"
{
echo BRANCH_NAME="$CI_BUILD_REF_NAME"
echo COMMIT_TITLE="$CI_COMMIT_TITLE"
echo USER_PERFORM="$GITLAB_USER_NAME"
} >>fastlane/.env."$BUILD_FLAVOR_KEY"
echo "========================Setup Env Finish======================="
